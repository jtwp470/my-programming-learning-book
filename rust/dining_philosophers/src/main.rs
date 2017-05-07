use std::thread;
use std::time::Duration;
use std::sync::{Mutex, Arc};

// 構造体
struct Philosopher {
    name: String,
    left: usize,
    right: usize,
}

// 構造体に関する定義を書く
impl Philosopher {
    fn new(name: &str, left: usize, right: usize) -> Philosopher {
        Philosopher {
            name: name.to_string(),
            left: left,
            right: right,
        }
    }

    fn eat(&self, table: &Table) {
        let _left = table.forks[self.left].lock().unwrap();
        thread::sleep(Duration::from_millis(150));
        let _right = table.forks[self.right].lock().unwrap();

        println!("{} is eating.", self.name);
        thread::sleep(Duration::from_millis(1000));
        println!("{} is done eating.", self.name);
    }
}

// フォークをモデル化したもの
struct Table {
    forks: Vec<Mutex<()>>,
}

fn main() {
    let table = Arc::new(Table { forks: vec![
        Mutex::new(()),
        Mutex::new(()),
        Mutex::new(()),
        Mutex::new(()),
        Mutex::new(()),
    ]});

    let philosophers = vec![
        Philosopher::new("Judith Butler", 0, 1),
        Philosopher::new("Gilles Deleuze", 1, 2),
        Philosopher::new("Karl Marx", 2, 3),
        Philosopher::new("Emma Goldman", 3, 4),
        Philosopher::new("Michel Foucault", 0, 4),  // デッドロックを回避するために1人左利きということにする
    ];

    // Vec<_>で中身は何らかの型のベクトルである という定義
    let handles: Vec<_> = philosophers.into_iter().map(|p| {
        let table = table.clone();

        // thread::spawn 関数はクロージャを1つ引数にとり、新しいスレッド上でそのクロージャを実行する
        thread::spawn(move || {
            p.eat(&table);
        }) // ここに ; を置かないことでこれは式となっている。
    }).collect();

    for h in handles {
        h.join().unwrap(); // 各スレッド実行が完了するまで実行をブロックする
    }
}

extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1, 101);

    println!("The secret number is {}", secret_number);

    loop {
        println!("Please input your guess.");

        let mut guess = String::new();

        io::stdin().read_line(&mut guess)
            .expect("Failed to read line");

        // シャドーイングにより、16行目で定義したguess変数を隠し、新しい変数定義を利用できる
        let guess: u32 = match guess.trim().parse() { // 入力には改行文字が含まれるため、 trim()で削除する
            Ok(num) => num,
            Err(_) => continue,  // 数値以外が入ってきてもエラーにはせずループを続行させる
        };

        println!("You guessed: {}", guess);

        match guess.cmp(&secret_number) {
            // Ordering は enum
            Ordering::Less    => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal   => {
                println!("You win!");
                break;
            }
        }
    }
}

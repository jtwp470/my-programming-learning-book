//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

str = "こんにちは"
str = str + "Swift"

// 変数
var num: Int = 3
var hel: String = "Hello"
// Int型を宣言してみる
var test: Int
// println(test) // 初期化されていないので実行できない
test = 4
println(test)

// 型推論
var age = 55

// 定数を宣言する場合はlet
let limit = 50
// limit = 100     // 定数なので変更不可

// StringとCharacter
var name = "太郎"
var char: Character = "あ"
// var char = "あいう" // エラーになる
// 型推論のときはデフォルトでStringと判定される

// 文字列に値を埋め込む式展開
// \(値)という形
var year = 2015
var s = "今年は\(year)年"
// 計算式の結果も埋め込むことができる
var heisei = 27
println("平成\(heisei)年は\(heisei + 1988)年です")

// 論理値
var isTrue: Bool = true

// タプル
var person1: (String, Int) = ("田中二郎", 55)
var person2 = ("田中二郎", 55)                 // 型推論
// タプルの値を変数に展開する
var (name1, age1) = person1
println(name1)

// いずれかの値が不要な場合
var (_, age2) = person1
// 添字アクセス
var name3 = person1.0
var age3 = person1.1

// タプルの要素に名前付け
var person4 = (name: "田中二郎", age: 55)
var name4 = person4.name
var age4 = person4.age

// 条件判断if 
// 基本的にはC言語と同じ. 条件に()がいらない
age = 20
if age == 20 {
    println("20歳です");
} else if age > 30 {
    println("三十路ですね")
} else {
    println("お疲れ様")
}

// switch文
// これも基本的にはC言語と同じだが, breakはいらない
// 省略してもっと便利な機能があるWhere句を用いる.これによって更に細かな条件判断ができる
age = 20
switch age {
case let n where age < 20:
    println("\(n)歳は未成年です")
case let n where age == 20:
    println("\(n)歳はちょうど成人です")
case let n where age > 20:
    println("\(n)歳は成人です")
default:
    break
}

// 繰返しの制御構造
var sum = 0
for var i = 1; i <= 10; i++ {
    sum += i
}
println(sum)

// for-in文
// クローズドレンジ:        a...b aからbまでの数値をイテレート
// ハーフクローズドレンジ:   a..<b aからb未満までの数値をイテレート
sum = 0
for num in 1...10 {
    sum += num
}
println(sum)

var i = 0
sum = 0
while i <= 10 {
    sum += i
    i++
}
println(sum)

// オプショナル型: 値が存在しているしていないという2つの状態を持つことができる
var num: Int?
num = 3
num = nil
// オプショナル値をアンラップする
var n: Int? = 4
// var sum = n + 1 //  エラーになる

// アンラップして取り出す方法
sum = n! + 4
// 自動的にアンラップする
var n1: Int! = 4
sum = num + 1      // 自動的にアンラップしてくれる
// オプショナルバインディング
// 使用時にnilであるとエラーになるのでオプショナル値を安全に利用できるようにするための書式
var nn: Int? = 3
sum = 0

if let n = nn {
    sum = 5 + n
} else {
    println("値がありません")
}
// オプショナルチェイニング
// オプショナル型の値の最後に?を記述すると複数のメソッドやプロパティをピリオドで鎖のように連結して実行できる


/*
 * 自作の関数を作成する
 */
// 引数と戻り値のない関数
func hello1() {
    println("こんにちは")
}
// 戻り値を返す
func hello2() -> String {
    return "こんにちは"
}
var helloStr2 = hello2() // 実行例
// 引数を指定する
func hello3(fName: String, lName: String) -> String {
    return "こんにちは \(lName + fName)さん"
}
var helloStr3 = hello3("一郎", "田中")

// 外部引数名
func hello4(firstName fName: String, lastName lName: String) -> String {
    return "こんにちは \(lName + fName)さん"
}
// 呼び出すとき
var helloStr4 = hello4(firstName: "一郎", lastName: "田中")
// 外部引数名と内部引数名を同じにする
// こんなときは外部引数名を書かずに引数名に#をつければよい.
func hello5(#fName: String, #lName: String) -> String {
    return "こんにちは \(lName + fName)さん"
}
var helloStr5 = hello5(fName: "一郎", lName: "田中")
// 引数のデフォルト値と可変長引数
// 外部引数名
func hello6(firstName fName: String, lastName lName: String, greeting: String = "こんにちは") -> String {
    return "\(greeting) \(lName + fName)さん"
}
var helloStr6 = hello6(firstName: "一郎", lastName: "田中", greeting: "こんばんは")

// 任意の数の引数を渡す
func sumAll(numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}

var sum1 = sumAll(1,2,3)
var sum2 = sumAll(8, 4, 5, 2, 1)

// 複数の値を返す (戻り値はタプル)
func maxMin(n1: Double, n2: Double) -> (maxValues: Double, minValue: Double) {
    var maxVal = max(n1, n2)
    var minVal = min(n1, n2)
    return (maxVal, minVal)
}
var (max1, min1) = maxMin(1.4, 3.0)

// クロージャ lambda式てきなもの
var sums = { (num1: Int, num2: Int) -> Int in
    return num1 + num2
}
var num3 = sums(4, 5)

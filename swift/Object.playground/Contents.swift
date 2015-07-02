//: Playground - noun: a place where people can play

import UIKit
import Foundation
// インスタンスの作成 var 変数名: 型 = クラス名(引数)
var now: NSDate = NSDate()

// プロパティを操作
var nowStr = now.description
println("現在時刻: \(nowStr)")

// メソッドの実行
var newDate = now.dateByAddingTimeInterval(60 * 60 * 24)
println("24時間後: \(newDate)")

/*
 * クラスと構造体の作成
 */
class Customer1 {
    var number = 0
    var name = "None"
    var point = 0
}

var c1 = Customer1()
c1.number = 1
c1.name = "井上和男"
c1.point = 10

println("顧客番号:\(c1.number) 名前:\(c1.name) ポイント: \(c1.point)")

// メソッドの追加
class Customer2 {
    var number = 0
    var name = "None"
    var point = 0
    
    // メソッド
    func description() -> String {
        return ("顧客番号:\(number) 名前:\(name) ポイント: \(point)")
    }
}
var c2 = Customer2()
c2.number = 10
c2.name = "井上和男"
c2.point = 10
println(c2.description())

// イニシャライザ
class Customer3 {
    var number: Int
    var name: String
    var point: Int
    
    // イニシャライザ
    init(number: Int, name: String, point: Int) {
        self.number = number
        self.name = name
        self.point = point
    }
    
    // メソッド
    func description() -> String {
        return ("顧客番号:\(number) 名前:\(name) ポイント: \(point)")
    }
}
var c3 = Customer3(number: 3, name: "山田太郎", point: 10)
println(c3.description())

// コンビニエンスイニシャライザの追加
// 1つのクラスに複数のイニシャライザを用意することが可能でこれらは「指定イニシャライザ」と「コンビニエンスイニシャライザ」に大別される

class Customer4 {
    var number: Int
    var name: String
    var point: Int
    
    // 指定イニシャライザ
    init(number: Int, name: String, point: Int) {
        self.number = number
        self.name = name
        self.point = point
    }
    
    convenience init(number: Int, name: String) {
        self.init(number: number, name: name, point: 0)
    }
    // メソッド
    func description() -> String {
        return ("顧客番号:\(number) 名前:\(name) ポイント: \(point)")
    }
}

// 指定イニシャライザによる初期化
var c41 = Customer4(number: 3, name: "山田太郎", point: 10)
println(c41.description())

// コンビニエンスイニシャライザで初期化
var c42 = Customer4(number: 5, name: "山田花子")
println(c42.description())

/* クラスの継承 */
// class クラス名: スーパークラス名 { }
// メソッドのオーバーライドをするときはoverrideと指定する必要がある
// override func ...
// 以下にCustor4を継承したGoldCustomerを示す.
class GoldCustomer: Customer4 {
    var isGold: Bool  // ゴールド会員であることを示す
    
    // 独自の指定イニシャライザ
    init(number: Int, name: String, point: Int, isGold: Bool) {
        self.isGold = isGold
        super.init(number: number, name: name, point: point)
    }
    
    // オーバーライドした指定イニシャライザ
    convenience override init(number: Int, name: String, point: Int) {
        self.init(number: number, name: name, point: point, isGold: false)
    }
    
    // オーバーライドされたdescription()
    override func description() -> String {
        return ("顧客番号:\(number) 名前:\(name) ポイント: \(point) ゴールド:\(isGold)")
    }
}

// GoldCustmerクラス独自の指定イニシャライザを使用して初期化
var c51 = GoldCustomer(number: 1, name: "山田太郎", point: 10, isGold: true)
println(c51.description())

// オーバーライドした
var c52 = GoldCustomer(number: 2, name: "山田花子", point: 30)
println(c52.description())

// 継承されたCustmer4クラスのコンビニエンスイニシャライザを使用
var c53 = GoldCustomer(number: 3, name: "大津真")
println(c53.description())

// クラスと構造体の相異
// 構造体は値型,クラスは参照型 P.117
// 構造体は値型なので値がコピーされる.しかしクラスは参照型なので1つの値を変化させると予想外のところに変化してしまうかもしれない


/*
 * 文字列
 */
// 長さを求める
var len = count("SWift入門")

/*
 * 配列
 */
// var 変数名: Array<型> or var 変数名: [型]
var seasons: Array<String> = ["春", "夏", "秋", "冬"]

// 配列の要素にアクセス
var spring = seasons[0]
var winter = seasons[seasons.count - 1]

for season in seasons {
    println(season)
}

// 辞書
var colors: Dictionary<String, String> = ["黄": "yellow", "白": "white", "赤": "red"]

// 辞書型はオプショナル型なのでアンラップする必要がある.
var key = "赤"
if let c = colors[key] {
    println("\(key)は英語では\(c)")
} else {
    println("\(key)に対応する値がありません")
}

// 要素の変更 / 追加 / 削除 P.124

// 辞書のすべての要素にアクセスする P.125

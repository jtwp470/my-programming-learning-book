# 第1章 WebSocketを使ったチャットアプリケーション


## ビルド方法

``` bash
$ go build -o chat
```

## メモ 注釈など

まずGoでは**メソッドレシーバ**というものがあり`func`キーワードとメソッド名の間にそれ自身の引数を並べて表現する.
詳しくは[A Tour of GoのMethodsの項](https://go-tour-jp.appspot.com/methods/1)を参考にすると良い.

またGoではstructフィールドを初期化する場合は以下の様な感じで書く.


```go
templateHandler{filename: "chat.html"})
```

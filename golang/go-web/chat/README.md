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


# 第2章 認証機能の追加

1章で作成したチャットアプリケーションを拡張して認証機能を追加する.

* Decoratorパターンに基づいて機能を追加
* 動的なパスでHTTPのエンドポイントを提供
* httpパッケージを使ってクッキーの読み書き
* Base64形式を使ってオブジェクトのエンコードと復元
* WebSocketを使ってJSONデータの送受信を行う
* 様々な種類のデータをテンプレートに渡す
* 自分で定義した型のチャネルを定義して利用する

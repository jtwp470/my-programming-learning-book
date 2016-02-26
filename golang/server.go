// ローカルでHello, Worldを表示するサーバー
// テンプレートを利用することができる
package main

import (
    "net/http"
    "text/template"
)

type Page struct {
    Title string
    Count int
}

func viewHandler(w http.ResponseWriter, r *http.Request) {
    page := Page{"Hello, World", 1}
    tmpl, err := template.ParseFiles("layout.tpl.html")
    if err != nil {
        panic(err)
    }

    err = tmpl.Execute(w, page)
    if err != nil {
        panic(err)
    }
}

func main() {
    http.HandleFunc("/", viewHandler)
    err := http.ListenAndServe(":8080", nil)
    if err != nil {
        panic(err)
    }
}

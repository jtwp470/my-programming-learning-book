package main

import (
	"context"
	"html/template"
	"log"
	"net/http"
	"time"

	"github.com/ryosan-470/practice/golang/concurrency_patterns/context/google"
	"github.com/ryosan-470/practice/golang/concurrency_patterns/context/userip"
)

func main() {
	http.HandleFunc("/search", handleSearch)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func handleSearch(w http.ResponseWriter, req *http.Request) {
	// ctx はこのハンドラーのContextです。キャンセルを呼び出すと、ctx.Doneチャネルはクローズし、
	// リクエストのキャンセルシグナルは、このハンドラーにより起動します。
	var (
		ctx    context.Context
		cancel context.CancelFunc
	)

	timeout, err := time.ParseDuration(req.FormValue("timeout"))
	if err == nil {
		// リクエストはタイムアウトをもっているため、タイムアウト経過後に自動でキャンセルする
		// Contextmを生成します。
		ctx, cancel = context.WithTimeout(context.Background(), timeout)
	} else {
		ctx, cancel = context.WithCancel(context.Background())
	}
	defer cancel() // handleSearch が帰ってくると同時に ctx をキャンセルします

	// search クエリを確認する
	query := req.FormValue("q")
	if query == "" {
		http.Error(w, "no query", http.StatusBadRequest)
		return
	}

	// 他のパッケージを用いて ctx にユーザーのIPアドレスを保存する
	userIP, err := userip.FromRequest(req)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	ctx = userip.NewContext(ctx, userIP)

	// Google検索を実行し結果を表示します
	start := time.Now()
	results, err := google.Search(ctx, query)
	elapsed := time.Since(start)

	if err := resultsTemplate.Execute(w, struct {
		Results          google.Results
		Timeout, Elapsed time.Duration
	}{
		Results: results,
		Timeout: timeout,
		Elapsed: elapsed,
	}); err != nil {
		log.Print(err)
		return
	}
}

var resultsTemplate = template.Must(template.New("results").Parse(`
<html>
<head/>
<body>
  <ol>
  {{range .Results}}
    <li>{{.Title}} - <a href="{{.URL}}">{{.URL}}</a></li>
  {{end}}
  </ol>
  <p>{{len .Results}} results in {{.Elapsed}}; timeout {{.Timeout}}</p>
</body>
</html>
`))

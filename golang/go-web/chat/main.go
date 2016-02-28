package main

import (
	"flag"
	"log"
	"net/http"
	"path/filepath"
	"sync"
	"text/template"

	"github.com/stretchr/gomniauth"
	"github.com/stretchr/gomniauth/providers/google"
	// "github.com/stretchr/objx"
)

type templateHandler struct {
	once     sync.Once
	filename string
	temp1    *template.Template
}

// ServeHTTPはHTTPリクエストを処理する
func (t *templateHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	t.once.Do(func() {
		t.temp1 =
			template.Must(template.ParseFiles(filepath.Join("templates", t.filename)))
	})
	t.temp1.Execute(w, r)
}
func main() {
	var addr = flag.String("addr", ":8080", "アプリケーションのアドレス")
	flag.Parse()
	// Gomniauthのセットアップ
	gomniauth.SetSecurityKey("セキュリティーキー")
	gomniauth.WithProviders(
		google.New(
			"488323899394-qro4auca5769rvrctha9g9a1olmli538.apps.googleusercontent.com",
			"PmCGtQH6CgasJguWBADvvy6h",
			"http://localhost:8080/auth/callback/google"),
	)
	r := newRoom()
	// r.tracer = trace.New(os.Stdout)
	http.Handle("/", MustAuth(&templateHandler{filename: "chat.html"}))
	http.Handle("/login", &templateHandler{filename: "login.html"})
	http.HandleFunc("/auth/", loginHandler)
	http.Handle("/room", r)
	// チャットルームを開始
	go r.run()
	// Webサーバーを起動する
	log.Println("Starting Web server at port: ", *addr)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}

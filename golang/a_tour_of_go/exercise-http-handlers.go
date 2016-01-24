package main

import (
	"fmt"
	"log"
	"net/http"
)

type String string

type Struct struct {
	Greeating string
	Punct     string
	Who       string
}

func (str String) ServeHTTP(
	w http.ResponseWriter,
	r *http.Request) {
	fmt.Fprintf(w, "%s", str)
}

func (str *Struct) ServeHTTP(
	w http.ResponseWriter,
	r *http.Request) {
	fmt.Fprintf(w, "%s%s%s", str.Greeating, str.Punct, str.Who)
}

func main() {
	http.Handle("/string", String("I'm a frayed knot."))
	http.Handle("/struct", &Struct{"Hello", ":", "Gophers!"})
	log.Fatal(http.ListenAndServe("localhost:5000", nil))
}

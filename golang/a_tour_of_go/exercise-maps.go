// WordCount関数を実装
package main

import (
	"golang.org/x/tour/wc"
	"strings"
)

func WordCount(s string) map[string]int {
	m := make(map[string]int) // mapを作成
	for _, v := range strings.Fields(s) {
		elem, ok := m[v] // key vが存在するか調べる
		if ok {
			m[v] = elem + 1
		} else {
			m[v] = 1
		}
	}
	return m
}

func main() {
	wc.Test(WordCount)
}

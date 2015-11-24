// HTTPコマンド (like wget)
package main

import (
    "fmt"
    "io/ioutil"
    "net/http"
    "os"
)

func main() {
    resp, err := http.Get(os.Args[1])
    if err != nil {
        fmt.Println("Error")
        return
    }
    // 遅延評価? 要調査
    defer resp.Body.Close() // 使い終わったら自動的に閉じてくれる

    body, err := ioutil.ReadAll(resp.Body)
    fmt.Printf("%s", body)
}

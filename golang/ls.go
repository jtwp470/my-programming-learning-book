// ls
package main

import (
    "fmt"
    "io/ioutil"
    "os"
)

func main() {
    args := os.Args
    if len(args) == 2 {
        dir, err := ioutil.ReadDir(args[1])
        if err != nil {
            fmt.Println("Error")
        }

        // range文は2つ値を返す.
        // 最初はループカウンタ, 2つ目はその中の値
        for _, f := range dir {
            fmt.Println(f.Name())
        }
    } else {
        fmt.Println("引数の数は1つでよろ☆")
    }
}

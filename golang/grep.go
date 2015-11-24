// grep
package main

import (
    "bufio"
    "fmt"
    "os"
    "regexp"
)

func main() {
    args := os.Args
    if len(args) == 3 {
        f, err := os.Open(args[1])
        if err != nil {
            panic(err)
        }
        defer f.Close()

        sc := bufio.NewScanner(f)
        for sc.Scan() {
            pattern := args[2]
            text := sc.Text()
            is_matched, err := regexp.MatchString(pattern, text)
            if err != nil {
                panic(err)
            }
            if is_matched {
                fmt.Println(text)
            }
        }
    }
}

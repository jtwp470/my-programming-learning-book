package main

import "fmt"

func fibonacci() func() int {
	i, j := 1, 1
	return func() int {
		i, j = j, i+j
		return i
	}
}

func main() {
	f := fibonacci()
	for i := 0; i < 10; i++ {
		fmt.Println(f())
	}
}

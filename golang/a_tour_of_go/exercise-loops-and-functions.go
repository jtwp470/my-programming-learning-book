package main

import (
	"fmt"
	"math"
)

func Sqrt(x float64) float64 {
	z := 1.0
	for {
		prez := z
		z = z - ((z*z - x) / 2 * z)
		if math.Abs(z-prez) < 1e-4 {
			break
		}
	}
	return z
}

func main() {
	fmt.Println(Sqrt(2))
	fmt.Println(math.Sqrt(2))
}

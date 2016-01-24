// Exercise: Errors
// Sqrt関数にErrorを追加する (負数だとエラー)
package main

import (
	"fmt"
	"math"
)

type ErrNegativeSqrt float64

func (e ErrNegativeSqrt) Error() string {
	return fmt.Sprintf("cannot Sqrt negative number :%f", e)
}

func Sqrt(x float64) (float64, error) {
	if x < 0 {
		return 0, ErrrNegativeSqrt(x)
	}
	z := 1.0
	for {
		prez := z
		z = z - ((z*z - x) / 2 * z)
		if math.Abs(z-prez) < 1e-4 {
			break
		}
	}
	return z, nil
}

func main() {
	fmt.Println(Sqrt(2))
	fmt.Println(Sqrt(-2))
}

package main

import (
	"fmt"

	"github.com/Figaarillo/calculator"
)

func main() {
	println("Hello, World!")
	total := calculator.Sum(12, 34)
	fmt.Println(total)
	fmt.Println("Version: ", calculator.Version)
}

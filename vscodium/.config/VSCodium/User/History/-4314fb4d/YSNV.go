package main

import (
	"fmt"

	"github.com/Figaarillo/calculator"
)

func main() {
	println("Hello, World!")
	total := calculator.Sum()
	fmt.Println(total)
	fmt.Println("Version: ", calculator.Version)
}

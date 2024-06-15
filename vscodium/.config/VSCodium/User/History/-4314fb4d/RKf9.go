package main

import (
	"fmt"

	"github.com/Figaarillo/calculator"
	"rsc.io/quote"
)

func main() {
	total := calculator.Sum(12, 324)
	fmt.Println(total)
	fmt.Println("Version ", calculator.Version)
	fmt.Println(quote.Hello())
}
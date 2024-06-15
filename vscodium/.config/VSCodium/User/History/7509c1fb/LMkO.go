package main

import "fmt"

func main() {
	x := 42
	y := "James Bond"
	z := true
	toPrint := fmt.Sprint(x, y, z)
	fmt.Println("Punto a)")
	fmt.Println(toPrint, '\n')
	fmt.Println(x)
	fmt.Println(y)
	fmt.Println(z)
}
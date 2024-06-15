package main

import "fmt"

func main() {
	exercise01()
}

func exercise01()  {
	fmt.Println("Exercise 01")
	x := 42
	y := "James Bond"
	z := true
	fmt.Println("Punto a)")
	fmt.Println(fmt.Sprint(x, " ", y, " ", z))
	fmt.Println("Punto b)")
	fmt.Println(x)
	fmt.Println(y)
	fmt.Println(z)
}
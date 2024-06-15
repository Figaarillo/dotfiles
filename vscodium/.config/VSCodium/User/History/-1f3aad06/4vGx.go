package main

import "fmt"

func main() {
	exercise01()
	exercise02()
	exercise03()
}

func exercise01()  {
	fmt.Println("Exercise 01\a")
	x := 42
	y := "James Bond"
	z := true
	fmt.Println("a)")
	fmt.Println(x, y, z)
	fmt.Println("b)")
	fmt.Println(x)
	fmt.Println(y)
	fmt.Println(z)
	fmt.Println("\v")
}

// var x int
// var y string
// var z bool

func exercise02() {
	fmt.Println("Exercise 02\a")
	fmt.Println("a)")
	fmt.Println(x)
	fmt.Println(y)
	fmt.Println(z)
	fmt.Println("b)")
	println("El compilador asigna valores a las varbales, Como son llamados esos valores? Los valores son llamados valores cero")
	fmt.Println("\v")
}

var x int = 42
var y string = "James Bond"
var z bool = true

func exercise03() {
	s := fmt.Sprintf("%v %v %v",x, " ", y, " ", z)
	fmt.Println(s)
}
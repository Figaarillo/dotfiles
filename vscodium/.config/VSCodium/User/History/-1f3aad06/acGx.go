package main

import "fmt"

func main() {
	exercise01()
	exercise02()
	exercise03()
	exercise04()
	exercise05()
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
	fmt.Println("Exercise 03\a")
	s := fmt.Sprintf("%v\t%v\t%v",x, y, z)
	fmt.Println(s)
	fmt.Println("\v")
}

type num int 

var x3 num

func exercise04() {
	fmt.Println("Exercise 04\a")
	fmt.Println(x3)
	fmt.Printf("El tipo de x es: %T\n", x3)
	x3 = 42
	fmt.Println(x3)
	fmt.Println("\v")
}

var y2 int

func exercise05() {
	fmt.Println("Exercise 05\a")
	fmt.Println(x3)
	fmt.Printf("El tipo de x es: %T\n", x3)
	x3 = 43
	fmt.Println(x3)
	y2 = int(x3)
	fmt.Println(y2)
	fmt.Printf("El tipo de y es: %T\n", y2)
	fmt.Println("\v")
}

func exercise06() {
	fmt.Println("Exercise 05\a")
	fmt.Println("\v")
}
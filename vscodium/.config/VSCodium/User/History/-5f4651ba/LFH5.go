package main

import (
	"fmt"
)

func main() {
	typebool()
	iotaTest()
}

var x1 bool
func typebool() {
	fmt.Println(x1)
	fmt.Printf("%T\n",x1)
	x := 12
	y := 3
	fmt.Printf("x=%v y=%v\n",x,y)
	fmt.Println("x > y ",x > y)
	fmt.Println("x < y ", x < y)
	fmt.Println("x == y ", x == y)
	fmt.Println("x <= y ", x <= y)
	fmt.Println("x >= y ", x >= y)
	fmt.Println("x != y ", x != y)
}

// IOTA
const (
	a = iota
	b = iota
	c = iota
	d = iota
)

const (
	e = iota
	f
	g
)

func iotaTest()  {
	fmt.Println(a)
	fmt.Printf("%T\n", a)
	fmt.Println(b)
	fmt.Printf("%T\n", b)
	fmt.Println(c)
	fmt.Printf("%T\n", c)
	fmt.Println(d)
	fmt.Printf("%T\n", d)
	fmt.Println(e)
	fmt.Printf("%T\n", e)
	fmt.Println(f)
	fmt.Printf("%T\n", f)
	fmt.Println(g)
	fmt.Printf("%T\n", g)
}
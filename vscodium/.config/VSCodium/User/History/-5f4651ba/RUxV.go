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
	fmt.Printf("%T\t", a)
	fmt.Println(a)
	fmt.Printf("%T\t", b)
	fmt.Println(b)
	fmt.Printf("%T\t", c)
	fmt.Println(c)
	fmt.Printf("%T\t", d)
	fmt.Println(d)
	fmt.Printf("%T\t", e)
	fmt.Println(e)
	fmt.Printf("%T\t", f)
	fmt.Println(f)
	fmt.Printf("%T\t", g)
	fmt.Println(g)
}
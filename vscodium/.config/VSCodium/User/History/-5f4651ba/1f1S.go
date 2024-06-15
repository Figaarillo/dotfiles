package main

import (
	"fmt"
)

// IOTA
const (
	a = iota
	b
	c
	d
)
func main() {
	typebool()
	// iota()
	fmt.Println(a)
	fmt.Printf("%T", a)
	fmt.Println(b)
	fmt.Printf("%T", b)
	fmt.Println(c)
	fmt.Printf("%T", c)
	fmt.Println(d)
	fmt.Printf("%T", d)
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
// func iota() {
// 	fmt.Println(a)
// 	fmt.Printf("%T", a)
// 	fmt.Println(b)
// 	fmt.Printf("%T", b)
// 	fmt.Println(c)
// 	fmt.Printf("%T", c)
// 	fmt.Println(d)
// 	fmt.Printf("%T", d)
// }

const a = iota
const b = iota
const c = iota
const d = iota


package main

import "fmt"

func main() {
	exercise01()
}

func exercise01() {
	fmt.Println("Exercise 01")
	const a int =  432

	fmt.Printf("D:%d\tB:%b\tH:%#x\n", a, a, a)
	Println()
}

func Println() {
	panic("unimplemented")
}
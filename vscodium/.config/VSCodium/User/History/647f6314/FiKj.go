package main

import "fmt"

func main() {
	exercise01()
}

func exercise01() {
	fmt.Println("Exercise 01\a")
	const a int =  432

	fmt.Printf("D:%d\tB:%b\tH:%#x\n", a, a, a)
	fmt.Println("\v")
}


func exercise02() {
	fmt.Println("Exercise 02\a")
	const a int =  432

	fmt.Printf("D:%d\tB:%b\tH:%#x\n", a, a, a)
	fmt.Println("\v")
}
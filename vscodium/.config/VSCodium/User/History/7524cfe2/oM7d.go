package main

import "fmt"

func main() {
	exercise01()
}

func exercise01() {
	fmt.Println("Exercise 01\a")

	for i := 0; i <= 1000; i++ {
		fmt.Printf("%v,", i)
	}

	fmt.Println("'\v")
}

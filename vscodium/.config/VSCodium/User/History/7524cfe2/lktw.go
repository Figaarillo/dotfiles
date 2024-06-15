package main

import "fmt"

func main() {
	exercise01()
	exercise02()
}

func exercise01() {
	fmt.Println("Exercise 01\a")

	for i := 0; i <= 1000; i++ {
		fmt.Printf("%v,", i)
	}

	fmt.Println("\v")
}

func exercise02() {
	fmt.Println("Exercise 01\a")

	for i := 65; i <= 90; i++ {
		fmt.Printf(`%v
		%#U, 
		%#U, 
		%#U, 
		i,i,i,i,i`)
	}

	fmt.Println("\v")
}

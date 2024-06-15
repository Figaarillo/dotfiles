package main

import (
	"fmt"
)

func main() {
	exercise01()
	exercise02()
	exercise03(1998)
	exercise04(1998)
}

func exercise01() {
	fmt.Println("Exercise 01\a")

	for i := 0; i <= 1000; i++ {
		fmt.Printf("%v,", i)
	}

	fmt.Println("\v")
}

func exercise02() {
	fmt.Println("Exercise 02\a")

	for i := 65; i <= 90; i++ {
		fmt.Printf(`
		%v
		%#U
		%#U
		%#U
		`,
			i, i, i, i)
	}

	fmt.Println("\v")
}

func exercise03(birthday int) {
	fmt.Println("Exercise 03\a")

	i := birthday
	for i <= 2023 {
		fmt.Printf("%v - ", i)
		i++
	}

	fmt.Println("\v")
}

func exercise04(birthday int) {
	fmt.Println("Exercise 04\a")

	i := birthday
	for {
		if i > 2023 {
			break
		}
		fmt.Printf("%v - ", i)
		i++
	}

	fmt.Println("\v")
}

func exercise05(init int, end int) {
	for i := init; i <= end; i++ {
		fmt.Printf("%v - ", i)
	}
}
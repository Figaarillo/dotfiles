package main

import "fmt"

func main() {
	cicloFor()
	cicloForAnidado()
}

func cicloFor() {
	for i := 0; i < 10; i++ {
		fmt.Printf("%v, ", i)
	}
	print("10\n")
}

func cicloForAnidado() {
	for i := 1; i < 4; i++ {
		for j := 1; j < 4; j++ {
			fmt.Printf("%v%v ", i,j)
		}
		fmt.Println("")
	}
}

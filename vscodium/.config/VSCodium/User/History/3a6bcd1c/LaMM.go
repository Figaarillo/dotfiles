package main

import "fmt"

func main() {
	cicloFor()
	cicloForAnidado(6)
}

func cicloFor() {
	for i := 0; i < 10; i++ {
		fmt.Printf("%v, ", i)
	}
	print("10\n")
}

func cicloForAnidado(l) {
	for i := 1; i < l; i++ {
		for j := 1; j < l; j++ {
			fmt.Printf("%v%v ", i, j)
		}
		fmt.Println("")
	}
}

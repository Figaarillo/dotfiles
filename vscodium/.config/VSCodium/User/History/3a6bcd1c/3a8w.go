package main

import "fmt"

func main() {
	cicloFor()
	cicloForAnidado()
	forSinCondicion()
}

func cicloFor() {
	for i := 0; i < 10; i++ {
		fmt.Printf("%v, ", i)
	}
	print("10\n")
}

func cicloForAnidado() {
	for i := 1; i < 5; i++ {
		for j := 1; j < 5; j++ {
			fmt.Printf("%v%v ", i, j)
		}
		fmt.Println("")
	}
}

func forConUnaCondicion() {
	i := 0
	for i < 10 {
		fmt.Println(i)
		i++
	}
}

func forSinCondicion() {
	i := 0
	for {
		if i > 10 
			fmt.Print("\n")
			break
		
		fmt.Print(i)
		i++
	}
}

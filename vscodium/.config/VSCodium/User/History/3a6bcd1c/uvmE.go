package main

import "fmt"

func main() {
	cicloFor()
	cicloForAnidado(10)
	forConUnaCondicion()
	forSinCondicion()
	printPair(100)
}

func cicloFor() {
	for i := 0; i < 10; i++ {
		fmt.Printf("%v, ", i)
	}
	print("10\n")
}

func cicloForAnidado(l int) {
	for i := 1; i < l; i++ {
		for j := 1; j < l; j++ {
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
		if i > 10 {
			fmt.Print("\n")
			break
		}
		fmt.Print(i)
		i++
	}
}

func printPair(limit int) {
	for i := 0; i < limit; i++ {
		if i%2 == 0 {
			fmt.Printf("%v, ", i)
		}
	}
	fmt.Printf("%v\n", limit)
}

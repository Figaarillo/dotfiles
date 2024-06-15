package main

import "fmt"

func main() {
for {
	i := 0
	if i < 10 break
	print(i)
}
	for {
		if i > 10 {
			break
		}
		fmt.Print(i)
		i = i + 1
	}
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
	for i := 1; i < 5; i++ {
		for j := 1; j < 5; j++ {
			fmt.Printf("%v%v ", i, j)
		}
		fmt.Println("")
	}
}

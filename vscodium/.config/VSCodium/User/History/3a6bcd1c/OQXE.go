package main

import "fmt"

func main() {
	cicloFor()
}

func cicloFor() {
	for i := 0; i < 10; i++ {
		fmt.Printf("%v, ", i)
	}
}

package main

import "fmt"

func main() {
	fmt.Println("Hello, world!")
	
}

// Funciones que reciben un numrto indeterminado de parametros

func foo(x ...int) {
	for i := 0; i < len(x); i++ {
		fmt.Println(x[i])
	}
}

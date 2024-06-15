package main

import "fmt"

func main() {
	fmt.Println("Hello, world!")
	foo("Axel", 1, 2, 2, 3, 4, 4, 5, 5, 6, 7, 4, 2)
}

// Funciones que reciben un numrto indeterminado de parametros

func foo(x string, y ...int) {
	fmt.Println("Hello,  " + x)
	for i := 0; i < len(y); i++ {
		fmt.Print(y[i])
	}
	for _, v := range y {
		fmt.Println(v)
	}
}

package main

import "fmt"

func main() {
	crandoStructs()
}

func crandoStructs() {
	// Un struct es un tipo de datos compuesto, es decir, contiene
	type persona struct {
		nombre string
		apellido string
		age int
	}

	p1 := persona {
		nombre: "axel",
		apellido: "leonardi",
	}

	fmt.Println(p1)

	fmt.Printf("p1: %v\n", p1)
}
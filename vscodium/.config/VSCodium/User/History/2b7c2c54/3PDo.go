package main

import "fmt"

func main() {

}

func crandoStructs() {
	// Un struct es un tipo de datos compuesto, es decir, contiene
	type persona struct {
		nombre string
		apellido string
	}

	p1 := persona {
		nombre: "axel",
		apellido: "leonardi",
	}

	fmt.Println(p1)
}
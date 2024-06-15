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
		age: 22,
	}

	p2 := persona {
		nombre: "fagarillo",
	}

	p3 := persona {
		nombre: "figarillo",
		age: 22,
	}

	fmt.Println(p1)
	fmt.Println(p2)
	fmt.Println(p3)

	fmt.Printf("p1: %v\n", p1)
	fmt.Printf("p2: %v\n", p2)
	fmt.Printf("p3: %v\n", p3)
}


func structsEmbebidos() {
	type persona struct {
		nombre string
		apellido string
		age int
	}

	type agenteSecreto struct {
		persona
		lpm bool
	}
	jamesB := agenteSecreto {
		persona: persona{
			nombre: "James",
			apellido: "Bond",
			age: 43,
		},
		lpm: true,
	}
	fmt.Println(jamesB)
}
package main

import "fmt"

func main() {
	exercise01()
}

func exercise01() {
	type persona struct {
		nombre           string
		apellido         string
		saboresDeHelados []string
	}

	p1 := persona{
		nombre:           "Axel",
		apellido:         "Leonardi",
		saboresDeHelados: []string{"chocolate", "dulce de leche", "creama americana"},
	}

	p2 := persona{
		nombre:           "Fabrizio",
		apellido:         "Leonardi",
		saboresDeHelados: []string{"creama oreo", "vainilla", "frutilla"},
	}

	fmt.Println(p1)
	fmt.Println(p2)
}

func exercise02
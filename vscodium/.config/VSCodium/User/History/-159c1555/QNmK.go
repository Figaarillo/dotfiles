package main

import "fmt"

func main() {
	exercise01()
	exercise02()
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

func exercise02() {
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
		apellido:         "Scursattone",
		saboresDeHelados: []string{"creama oreo", "vainilla", "frutilla"},
	}

	persons := map[string]persona{
		p1.apellido: p1,
		p2.apellido: p2,
	}

	fmt.Println(persons)
}

func exercise03() {
	type vehiculo struct {
		puertas int
		color   string
	}

	type camion struct {
		vehiculo
		cuatroRuedas bool
	}

	type sedan struct {
		vehiculo
		lujoso bool
	}

	c := camion {
		vehiculo: vehiculo{
			puertas: 2,
			color: "blanco",
		},
	}
}

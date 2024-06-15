package main

import "fmt"

// Declaracion de variables globales
var z = 41

// Tipos - Error de expresiones
// Todo expresion debe estar declarada en la misma linea de inicializacoin de la varible
// var w int
// w = 21 => da error


func main() {
	fmt.Println("Hello, Playground", 34, true)
 
  // Operador corto / declarar variables
	x := 42
	// Operador corto / expresion
	y := 2 + 4
	fmt.Println(x, y)

  numero()
  
  // Tipos
  // int := 'hola'
}

func numero()  {
  fmt.Println(z)
}

var a int

type dinero int

var b dinero

func conversion() {
	a = 42
	fmt.Println(a)
	fmt.Printf("%T\n", a)

	b = 1000
	fmt.Println(b)
	fmt.Printf("%T\n", b)

	a = int(b)
	fmt.Println(a)
	fmt.Printf("%T\n", a)
}
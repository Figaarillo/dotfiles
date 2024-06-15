package main

import "fmt"

func main() {
	arrays()
	compositeLiteral()
	sliceArrays()
	appendFunction()
	sliceMake()
	sliceMultidimensional()
	mapData()
}

func arrays() {
	// Declaracion de arreglos
	var x [5]int
	fmt.Println(x)
	fmt.Printf("%T\n", x)
	fmt.Println(len(x))

	y := [5]int{1, 2, 3, 4, 5}

	fmt.Printf("%v, %v, %v, %v, %v\n", y[0], y[1], y[2], y[3], y[4])
}

func compositeLiteral() {
	// tipo{elemento}
	x := []string{"uno", "dos", "tres", "cuatro"}
	for i, v := range x {
		fmt.Println(i, v)
	}
}

func sliceArrays() {
	x := []string{"uno", "dos", "tres", "cuatro"}
	y := x[1:3]
	fmt.Println(y)
}

func appendFunction() {
	x := []string{"uno", "dos", "tres", "cuatro"}
	y := append(x, "cinco", "seis")
	z := append(x, y...)
	fmt.Println(z)
}

func sliceMake() {
	x := make([]int, 10, 10)
	fmt.Println("longitud de x", len(x))
	fmt.Println("capacidad de x", cap(x))

	// Que pasa si agregamos un elemento por sobre la capacidad establecida?
	x = append(x, 21)
	x = append(x, 45)
	fmt.Println("longitud de x", len(x))
	fmt.Println("capacidad de x", cap(x))
}

func sliceMultidimensional() {
	num1 := []string{"uno", "dos", "tres", "cuatro"}
	num2 := []string{"cinco", "seis", "siete", "ocho"}
	num3 := [][]string{num1, num2}
	fmt.Println(num3)
}

func mapData() {
	m := map[string]int{
		"Batman": 32,
		"Robin":  27,
	}

	fmt.Println(m)

	fmt.Println(m["Batman"])
	fmt.Println(m["Robin"])

	fmt.Println(m["Superman"]) // El elemento no existe, asi que se esperaria que el valor sea nulo o se arroje un error, pero en realidad se devuelve 0, sin terminar de saber si el valor del elemento es 0 o no existe

	v, ok := m["Superman"] // Si el valor no exite, ok = false y si existe x = true
	fmt.Println(v, ok)

	if v, ok := m["Robin"]; ok {
		fmt.Println(v)
	}
}

func borrarElemeentosMap(){
	
}
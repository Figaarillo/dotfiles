package main

import "fmt"

func main() {
	arrays()
	compositeLiteral()
	sliceArrays()
	appendFunction()
	sliceMake()
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

package main

import "fmt"

func main() {
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
	x := string{"uno", "dos", "tres", "cuatro"}
	for _, v := range x {
		fmt.Println(x[v])
	}
}

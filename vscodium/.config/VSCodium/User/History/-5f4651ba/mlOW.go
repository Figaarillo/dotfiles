package main

import "fmt"

func main() {
	typebool()
}

var x1 bool
func typebool() {
	fmt.Println(x1)
	y := 3
	fmt.Printf("%T\n",x1)
}
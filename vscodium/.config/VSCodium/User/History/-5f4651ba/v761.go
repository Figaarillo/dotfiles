package main

import "fmt"

func main() {
	typebool()
}

var x1 bool
func typebool() {
	fmt.Println(x1)
	fmt.Printf("%T",x1)
}
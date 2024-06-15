package main

import "fmt"

func main() {
	exercise01()
	exercise02()
	exercise03()
	exercise04()
}

func exercise01() {
	fmt.Println("Exercise 01\a")
	const a int =  432

	fmt.Printf("D:%d\tB:%b\tH:%#x\n", a, a, a)
	fmt.Println("\v")
}


func exercise02() {
	fmt.Println("Exercise 02\a")

	x := 12
	y := 3
	fmt.Printf("x=%v y=%v\n",x,y)
	fmt.Println("x > y ",x > y)
	fmt.Println("x < y ", x < y)
	fmt.Println("x == y ", x == y)
	fmt.Println("x <= y ", x <= y)
	fmt.Println("x >= y ", x >= y)
	fmt.Println("x != y ", x != y)

	fmt.Println("\v")
}

func exercise03() {
	fmt.Println("Exercise 03\a")

	const a int = 1
	const b = "uno"

	fmt.Printf("%v\n%v", a, b)


	fmt.Println("\v")
}

func exercise04() {
	fmt.Println("Exercise 03\a")

	a := 22
	fmt.Printf("D:%d\tB:%b\t\tH:%#x\n", a, a, a)

	b := a << 1
	fmt.Printf("D:%d\tB:%b\tH:%#x\n", b, b, b)

	c := b << 1
	fmt.Printf("D:%d\tB:%b\tH:%#x\n", c, c, c)
	fmt.Println("\v")
}
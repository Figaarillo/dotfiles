package main

import "fmt"

func main2() {
	result := reverseString("hello")

	fmt.Println(result)
}

func reverseString(str string) string {
	reverseStr := ""

	for i := len(str) - 1; i >= 0; i-- {
		reverseStr += string(str[i])
	}

	return reverseStr
}

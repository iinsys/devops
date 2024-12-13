package main

import "fmt"

func main() {
	fmt.Println("Go" + "lang")

	var x int = 5
	fmt.Println("The value of x is", x)

	const pi float64 = 3.14159
	fmt.Println("The value of pi is", pi)

	var y string = "Hello, World!"
	fmt.Println(y)
	fmt.Println(len(y))
	fmt.Println(y[0], y[len(y)-1])

	var z bool = true
	fmt.Println(z)		
	var a [5]int
	fmt.Println(a)
	a[0] = 10
	var q = "abcdefghijklmnop"
	fmt.Println(q)
}
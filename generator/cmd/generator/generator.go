package main

import (
	"fmt"
	"generator"
)

// main function is where the action starts ans ends
func main() {
	if err := generator.Utility(); err != nil {
		fmt.Printf("generation failed: %v\n", err)
	}
}

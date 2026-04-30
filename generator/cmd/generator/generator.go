package main

import (
	"generator"

	"github.com/bruceesmith/logger"
)

// main function is where the action starts ans ends
func main() {
	if err := generator.Utility(); err != nil {
		logger.Error("generation failed: %v\n", err)
	}
}

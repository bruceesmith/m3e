package tests

import (
	"fmt"
	"generator/parser"
)

func Generate(definition *parser.Definition, destination string, version string, date string) (err error) {
	// Write out the unit tests for each Gleam wrapper module - one Gleam file for
	// each TypeScript Element defined in the manifest
	for modName, module := range definition.Modules {
		err = GenerateTests(destination, modName, module, version, date)
		if err != nil {
			return fmt.Errorf("failed to generate unit tests for %s: %w", modName, err)
		}
	}
	return
}

package tests

import (
	"fmt"
	"generator/parser"
)

// Generate generates all the unit test files
func Generate(definition *parser.Definition, destination string, version string, date string) (err error) {
	// Write out the unit tests for each Gleam wrapper module - one Gleam file for
	// each TypeScript Element defined in the manifest.
	for modName, module := range definition.Modules {
		err = generateTests(destination, &module, definition.Enumerations, version, date)
		if err != nil {
			return fmt.Errorf("failed to generate unit tests for %s: %w", modName, err)
		}
	}
	return
}

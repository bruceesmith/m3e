package code

import (
	"fmt"
	"generator/parser"
)

func Generate(definition *parser.Definition, destination string, version string, date string) (err error) {
	// Write out the code for each Gleam wrapper module - one Gleam file for
	// each TypeScript Element defined in the manifest
	for modName, module := range definition.Modules {
		err = generateModule(destination, &module, version, date)
		if err != nil {
			return fmt.Errorf("generation of code for module %s failed: %w", modName, err)
		}
	}

	// Write out the code for each enumerated type - one Gleam file for each, definition.Enumerations
	// TypeScript enum defined in the manifest
	err = generateEnums(destination, definition.Enumerations, version, date)
	if err != nil {
		return fmt.Errorf("generation of code for enumeration failed: %w", err)
	}
	return
}

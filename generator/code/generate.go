package code

import (
	"generator/parser"
)

func Generate(definition *parser.Definition, destination string, version string, date string) (err error) {
	// Write out the code for each Gleam wrapper module - one Gleam file for
	// each TypeScript Element defined in the manifest
	for modName, module := range definition.Modules {
		err = GenerateModule(destination, modName, module, version, date)
	}

	// Write out the code for each enumerated type - one Gleam file for each
	// TypeScript enum defined in the manifest
	err = GenerateEnums(destination, definition.Enumerations, version, date)
	return
}

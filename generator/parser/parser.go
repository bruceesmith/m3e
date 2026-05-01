/*
Package parser ingests a Custom Elements manifest and generates an internal representation of the elements
defined in the manifest. This generated representation is used by the code generator to emit Gleam modules for the elements,
and tests for each of the Gleam modules.
*/
package parser

import (
	"fmt"
	"generator/cem"
	"generator/metrics"
	"strings"
)

// Slot is an internal representation of a cem Slot
type Slot struct {
	Name        string
	Description string
	Attribute   string
}

// Enumeration is an internal representation of a cem Enumeration
type Enumeration struct {
	// Name is the CamelCase name of the enumeration
	Name string
	// Attribute is the text of the attribute that uses this enumeration
	Attribute string
}

// Module is an internal representation of a cem Module
type Module struct {
	// Description of the component that the module wraps
	Description string
	// HTML tag of the component
	Tag string
	// Attributes is a list of refined attributes for the module
	Attributes []Attribute
	// Slots is a list of refined slots for the module
	Slots []Slot
	// CamelCase name of the TS and Gleam module
	Name string
	// snake_case name of the TS and Gleam module
	SnakeName string
	// Set of all import strings for the Gleam code module
	// The key is the module name, e.g. "gleam/int" or "lustre/element"
	// The value is the remainder of the import line, e.g. for "lustre/element"
	// it would be ".{type Element}"
	Imports map[string]string
	// Set of all import strings for the Gleam unit test module
	// The key is the module name, e.g. "gleam/int" or "lustre/element"
	// The value is the remainder of the import line, e.g. for "lustre/element"
	// it would be ".{type Element}"
	TestImports map[string]string
}

// Parse extracts the module declarations and enumerated types from the manifest and M3e code
func Parse(manifest *cem.SchemaJson, m3eCode string) (definition Definition, err error) {

	// enumerations represents the set of externally defined enumerated types
	// used across all modules. "Externally defined" means that the type is
	// defined in a small TypeScript module (but not in a TypeScript module
	// which defines an M3E component)
	enumerations := make(map[string]struct{}, metrics.EstimatedEnumerations)
	definition = Definition{
		Modules: make(map[string]Module, len(manifest.Modules)),
	}

	// Extract attributes, slots and the names of enumerated types from the module declaration
	for _, module := range manifest.Modules {
		if len(module.Declarations) > 0 {
			declaration := module.Declarations[0]
			if declaration.Description != nil &&
				len(*declaration.Description) > 0 &&
				strings.Contains(declaration.Name, "M3e") &&
				strings.Contains(declaration.Name, "Element") {

				externalModules := definition.module(declaration)
				for _, moduleName := range externalModules {
					enumerations[moduleName] = struct{}{}
				}
			}
		}
	}

	// Extract the definitions of enumerated types from the M3e code
	err = definition.enumerations(m3eCode, enumerations)
	if err != nil {
		return definition, fmt.Errorf("failed to gather all enumerated types: %w", err)
	}

	// During module creation it is not possible to discover test values for external
	// enumeration types. So now set that up so that these can be added into
	// Attributes during test generation
	definition.EnumerationTestValues = make(map[string]string, len(definition.Enumerations))
	for externalType, enumeration := range definition.Enumerations {
		definition.EnumerationTestValues[externalType] = enumeration[1].Name
	}
	return
}

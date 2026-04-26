/*
Package parser ingests a Custom Elements manifest and generates an internal representation of the elements
defined in the manifest. This generated representation is used by the code generator to emit Gleam modules for the elements,
and tests for each of the Gleam modules.
*/
package parser

import (
	"fmt"
	"generator/cem"
	"strings"

	"github.com/bruceesmith/logger"
)

type RefinedAttribute struct {
	Name string
	// snake_case name of the attribute
	Enum string
	// CamelCase name of the enum type, if applicable
	Description string
	// Human-readable description of the attribute
	Default string
	// Gleam version of the TS default value
	QualifiedDefault string
	// Default value prefix by the modue name, used in test generation
	// Only used for semantic booleans in the same module
	Type string
	// CamelCase type name
	Imports map[string]string
	// snake_case import paths of any types used in the attribute ..
	// key is the snake_case import path, value is the optional CamelCase type name
	Standard bool
	// Is this a Gleam built-in attribute, e.g. Bool, Float...
	ModName string
	// CamelCase name of the TS and Gleam module
}
type Slot struct {
	Name        string
	Description string
	Attribute   string
}
type Enumeration struct {
	Name      string
	Attribute string
}
type Module struct {
	Description string
	TagName     string
	Attributes  []RefinedAttribute
	Slots       []Slot
}

type Definition struct {
	Modules      map[string]Module
	Enumerations map[string][]Enumeration
}

// Parse extracts the module declarations and enumerated types from the manifest and M3e code
func Parse(manifest *cem.SchemaJson, m3eCode string) (definition Definition, err error) {
	var (
		enumerations = make(map[string]struct{}, 0)
	)
	// Extract attributes, slots and the names of enumerated types from the module declaration
	for _, module := range manifest.Modules {
		if len(module.Declarations) > 0 {
			declaration := module.Declarations[0]
			if declaration.Description != nil &&
				len(*declaration.Description) > 0 &&
				strings.Contains(declaration.Name, "M3e") &&
				strings.Contains(declaration.Name, "Element") {

				if definition.Modules == nil {
					definition.Modules = make(map[string]Module)
				}
				name, mod, enumNames := handleModule(declaration)
				definition.Modules[name] = mod
				for _, enumName := range enumNames {
					enumerations[enumName] = struct{}{}
				}
			}
		}
	}

	// Extract the definitions of enumerated types from the M3e code
	definition.Enumerations, err = enumeratedTypes(m3eCode, enumerations)
	if err != nil {
		return definition, fmt.Errorf("failed to gather all enumerated types: %w", err)
	}
	return
}

// handleModule extracts the module name, attributes and slots from a single module declaration
func handleModule(declaration cem.JavaScriptModuleDeclarationsElem) (modName string, mod Module, enumNames []string) {
	modName = strings.TrimSuffix(strings.TrimPrefix(declaration.Name, "M3e"), "Element")
	if modName == "List" {
		modName = "MList"
	}
	var attributes []RefinedAttribute
	attributes, enumNames = MakeAttributes(modName, declaration.Attributes)
	mod = Module{
		Description: *declaration.Description,
		TagName:     *declaration.TagName,
		Attributes:  attributes,
		Slots:       MakeSlots(declaration.Slots),
	}
	logger.TraceID("module", fmt.Sprintf("Module %s: %s\n", modName, mod.Description))
	return modName, mod, enumNames
}

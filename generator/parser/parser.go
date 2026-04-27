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
	"github.com/iancoleman/strcase"
)

type RefinedAttribute struct {
	// snake_case name of the attribute
	Name string
	// CamelCase name of the enum type, if applicable
	Enum string
	// Human-readable description of the attribute
	Description string
	// Gleam version of the TS default value
	Default string
	// Name of the default value, if applicable
	DefaultName string
	// Default value prefixed by the module name, used in test generation
	// Only used for semantic booleans in the same module
	QualifiedDefault string
	// CamelCase type name
	Type string
	// snake_case import paths of any types used in the attribute ..
	// key is the snake_case import path, value is the optional CamelCase type name
	Imports map[string]string
	// Is this a Gleam built-in attribute, e.g. Bool, Float...
	Standard bool
	// CamelCase name of the TS and Gleam module
	ModName string
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
	Tag         string
	Attributes  []RefinedAttribute
	Slots       []Slot
	Name        string
	SnakeName   string
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
		modName = "Mlist"
	}
	mod = Module{
		Description: *declaration.Description,
		Tag:         *declaration.TagName,
		Slots:       MakeSlots(declaration.Slots),
		Name:        modName,
		SnakeName:   strcase.ToSnake(modName),
	}
	mod.Attributes, enumNames = MakeAttributes(modName, declaration.Attributes)
	logger.TraceID("module", fmt.Sprintf("Module %s: %s\n", modName, mod.Description))
	return modName, mod, enumNames
}

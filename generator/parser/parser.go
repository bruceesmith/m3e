package parser

import (
	"fmt"
	"generator/cem"
	"generator/metrics"
	"log/slog"
	"strings"

	"github.com/bruceesmith/logger"
)

const (
	// An educated guess as to the number of separately defined types
	estimatedEnumerations = 100
	// An educated guess as to the number of enumerations in a separately defined type module
	maxEnumTypeDefs = 5
)

// Slot is an internal representation of a cem Slot
type Slot struct {
	// CamelCase name of the Slot
	CamelName string
	// kebab-case name of the slot
	KebabName   string
	Description string
	// The attribute value for this slot
	Attribute string
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
	// HasChildren reflects whether the M3E component defines either default (unnamed)
	// or named Slots. When there are neither defined, the render() functions and
	// their tests should not have "children: List(Element(msg))" as a parameter
	HasChildren bool
}

// Parse extracts the module declarations and enumerated types from the manifest and M3e code
func Parse(manifest *cem.SchemaJson, m3eCode string, m *metrics.Metrics) (definition Definition, err error) {

	// enumerations represents the set of externally defined enumerated types
	// used across all modules. "Externally defined" means that the type is
	// defined in a small TypeScript module (but not in a TypeScript module
	// which defines an M3E component)
	enumerations := make(map[string]struct{}, estimatedEnumerations)
	definition = Definition{
		Modules: make(map[string]Module, len(manifest.Modules)),
	}

	// Extract attributes, slots and the names of enumerated types from the module declaration
	m.Start("parse-modules")
	for _, module := range manifest.Modules {
		if len(module.Declarations) > 0 {
			declaration := module.Declarations[0]
			if declaration.Description != nil &&
				len(*declaration.Description) > 0 &&
				strings.Contains(declaration.Name, "M3e") &&
				strings.Contains(declaration.Name, "Element") {

				externalModules := definition.module(declaration)
				for _, moduleName := range externalModules {
					logger.TraceID("external", "externals", "module", declaration.Name, "imports", moduleName)
					enumerations[moduleName] = struct{}{}
				}
			}
		}
	}
	err = m.End("parse-modules")
	if err != nil {
		slog.Warn("failed to close parse-modules metrics", "error", err)
	}
	slog.Info("Module parsing complete", "modules", len(definition.Modules))

	// Extract the definitions of enumerated types from the M3e code
	m.Start("parse-enums")
	err = definition.enumerations(m3eCode, enumerations)
	if err != nil {
		return definition, fmt.Errorf("failed to gather all enumerated types: %w", err)
	}
	err = m.End("parse-enums")
	if err != nil {
		slog.Warn("failed to close parse-enums metrics", "error", err)
	}
	if len(definition.Enumerations) > estimatedEnumerations {
		slog.Info(fmt.Sprintf("EstimatedEnumerations exceeded, new value should be at least %d", len(definition.Enumerations)+10))
	}
	slog.Info("Enumerated type parsing complete", "types", len(definition.Enumerations))

	return
}

package tests

import (
	"fmt"
	"generator/parser"
	"os"
	"path/filepath"
	"strings"

	"github.com/bruceesmith/logger"
	"github.com/iancoleman/strcase"
)

type GleamModule struct {
	header        *strings.Builder
	imports       *strings.Builder
	configuration *strings.Builder
	// constructor     *strings.Builder
	setters   *strings.Builder
	renderers *strings.Builder
	slots     *strings.Builder
}

func GenerateTests(directory string, module *parser.Module, enumerations map[string][]parser.Enumeration, version string, date string) (err error) {

	gleam := GleamModule{}
	logger.TraceID("tests", fmt.Sprintf("Module %s", module.Name))

	// Before proceeding it is necessary to fix up test values for enumerated types
	newMod := enumerationTestValues(module, enumerations)

	fileName := strcase.ToSnake(newMod.Name)
	file, err := os.Create(filepath.Join(directory, fileName+"_test.gleam"))
	if err != nil {
		return fmt.Errorf("failed to create file %s: %w", fileName+".gleam", err)
	}
	defer file.Close()

	gleam.header, err = header(newMod.Name, newMod.Description, version, date)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", newMod.Name, err)
	}

	gleam.imports, err = imports(newMod)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", newMod.Name, err)
	}
	// enumerations = append(enumerations, definers...)

	gleam.configuration, err = config(newMod)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", newMod.Name, err)
	}

	// gleam.constructor, err = constructors(modName, module.Attributes)
	// if err != nil {
	// 	return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	// }

	gleam.setters, err = setters(newMod)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", newMod.Name, err)
	}

	gleam.renderers, err = render(newMod)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", newMod.Name, err)
	}

	gleam.slots, err = slots(newMod)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", newMod.Name, err)
	}

	write(file, gleam)
	return
}

func write(file *os.File, gleam GleamModule) {
	fmt.Fprint(file, gleam.header.String())
	fmt.Fprint(file, gleam.imports.String())
	fmt.Fprint(file, gleam.configuration.String())
	// fmt.Fprint(file, gleam.constructor.String())
	fmt.Fprint(file, gleam.setters.String())
	fmt.Fprint(file, gleam.renderers.String())
	fmt.Fprint(file, gleam.slots.String())
}

// enumerationTestValues establishes a test value, and its corresponding HTML attribute value, for each
// attribute whose type is an externally defined enumeration. The test value chosen is intentionally
// different to the attribute's default, thus ensuring it is actually rendered in the HTML
func enumerationTestValues(module *parser.Module, enumerations map[string][]parser.Enumeration) (renderModule *parser.Module) {
	// During module creation it is not possible to discover test values for external
	// enumeration types. So now create these & add them into Attributes
	renderAttributes := make([]parser.Attribute, 0, len(module.Attributes))
	for _, v := range module.Attributes {
		attr := v
		if !v.IsStandard() && !v.IsOptional() && !v.IsSemBool() && v.Type != "Date" && v.Type != "number_string.NumberString" {
			parts := strings.Split(attr.Default, ".")
			if len(parts) != 2 {
				logger.Info(fmt.Sprintf("default value %s for attribute %s in module %s should be qualified", attr.Default, module.Name, attr.Name))
				continue
			}
			def := ""
			for _, v := range enumerations[attr.Type] {
				if v.Name != parts[1] {
					def = v.Name
					break
				}
			}
			if def == "" {
				logger.Info(fmt.Sprintf("default value %s for attribute %s in module %s cannot be extracted\n", attr.Default, module.Name, attr.Name))
			} else {
				attr.Test.Value = strcase.ToSnake(v.Type) + "." + def
				attr.Test.AttributeValue = strcase.ToSnake(v.Type) + ".to_string(" + attr.Test.Value + ")"
			}
		}
		renderAttributes = append(renderAttributes, attr)
	}
	renderModule = module
	renderModule.Attributes = renderAttributes
	return renderModule
}

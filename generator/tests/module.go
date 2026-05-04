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

type gleamModule struct {
	header        *strings.Builder
	imports       *strings.Builder
	configuration *strings.Builder
	constructor   *strings.Builder
	setters       *strings.Builder
	renderers     *strings.Builder
	slots         *strings.Builder
}

// generateTests creates all the unit test files
func generateTests(directory string, module *parser.Module, enumerations map[string][]parser.Enumeration, version string, date string) (err error) {

	gleam := gleamModule{}
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

	gleam.constructor, err = constructors(newMod)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

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

func write(file *os.File, gleam gleamModule) {
	fmt.Fprint(file, gleam.header.String())
	fmt.Fprint(file, gleam.imports.String())
	fmt.Fprint(file, gleam.configuration.String())
	fmt.Fprint(file, gleam.constructor.String())
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
		if !v.IsStandard() && !v.IsSemBool() && v.Type != "Date" && v.Type != "number_string.NumberString" {
			if attr.IsOptional() {
				if v.BaseType != "Date" {
					attr.Test.Value, attr.Test.AttributeValue = anyValue(attr.BaseType, enumerations)
				}
			} else {
				attr.Test.Value, attr.Test.AttributeValue = nonDefaultValue(attr.Type, attr.Default, enumerations)
			}
		}
		renderAttributes = append(renderAttributes, attr)
	}
	renderModule = module
	renderModule.Attributes = renderAttributes
	return renderModule
}

func anyValue(lookup string, enumerations map[string][]parser.Enumeration) (value, attribute string) {
	values, ok := enumerations[lookup]
	if !ok || len(values) == 0 {
		logger.Error("anyValue cannot find external type in enumerations", "type", lookup)
		return "Unknown", "unknown"
	}
	return "Some(" + strcase.ToSnake(lookup) + "." + values[0].Name + ")",
		strcase.ToSnake(lookup) + ".to_string(" + strcase.ToSnake(lookup) + "." + values[0].Name + ")"
}

func nonDefaultValue(lookup string, defawlt string, enumerations map[string][]parser.Enumeration) (value, attribute string) {
	values, ok := enumerations[lookup]
	if !ok || len(values) == 0 {
		logger.Error("nonDefaultValue cannot find external type in enumerations", "type", lookup)
		return "Unknown", "unknown"
	}
	parts := strings.Split(defawlt, ".")
	if len(parts) != 2 {
		logger.Info(fmt.Sprintf("default value %s should be qualified", defawlt))
	}
	for _, v := range values {
		if v.Name != parts[1] {
			value = v.Name
			break
		}
	}
	if value == "" {
		return "Unknown", "unknown"
	}
	return strcase.ToSnake(lookup) + "." + value,
		strcase.ToSnake(lookup) + ".to_string(" + strcase.ToSnake(lookup) + "." + value + ")"
}

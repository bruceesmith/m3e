package tests

import (
	"errors"
	"fmt"
	"generator/parser"
	"log/slog"
	"os"
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
func generateTests(root *os.Root, module *parser.Module, enumerations map[string][]parser.Enumeration) (err error) {

	gleam := gleamModule{}
	logger.TraceID("tests", fmt.Sprintf("Module %s", module.Name))

	// Before proceeding it is necessary to fix up test values for enumerated types
	newMod := enumerationTestValues(module, enumerations)

	fileName := strcase.ToSnake(newMod.Name)
	err = root.Remove(fileName + "_test.gleam")
	if err != nil && !errors.Is(err, os.ErrNotExist) {
		return fmt.Errorf("cannot remove test file %s: %w", fileName+"_test.gleam", err)
	}
	file, err := root.OpenFile(fileName+"_test.gleam", os.O_WRONLY|os.O_CREATE, 0644)
	if err != nil {
		return fmt.Errorf("failed to create file %s: %w", fileName+".gleam", err)
	}
	defer func() {
		if err := file.Close(); err != nil {
			slog.Error("error closing file", "filename", fileName+".gleam", "error", err)
		}
	}()

	gleam.header, err = header(newMod.Name)
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
	output := func(file *os.File, s string) {
		if _, err := fmt.Fprint(file, s); err != nil {
			slog.Error("error writing to file", "error", err)
		}
	}
	output(file, gleam.header.String())
	output(file, gleam.imports.String())
	output(file, gleam.configuration.String())
	output(file, gleam.constructor.String())
	output(file, gleam.setters.String())
	output(file, gleam.renderers.String())
	output(file, gleam.slots.String())
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
				if v.BaseType == "TimeParts" {
					attr.Test.Value, attr.Test.AttributeValue = "Some(time_parts.zero())", "time_parts.zero_string()"
				} else if v.BaseType != "Date" {
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
		slog.Error("anyValue cannot find external type in enumerations", "type", lookup)
		return "Unknown", "unknown"
	}
	return "Some(" + strcase.ToSnake(lookup) + "." + values[0].Name + ")",
		strcase.ToSnake(lookup) + ".to_string(" + strcase.ToSnake(lookup) + "." + values[0].Name + ")"
}

func nonDefaultValue(lookup string, defawlt string, enumerations map[string][]parser.Enumeration) (value, attribute string) {
	values, ok := enumerations[lookup]
	if !ok || len(values) == 0 {
		slog.Error("nonDefaultValue cannot find external type in enumerations", "type", lookup)
		return "Unknown", "unknown"
	}
	parts := strings.Split(defawlt, ".")
	if len(parts) != 2 {
		slog.Info(fmt.Sprintf("default value %s should be qualified", defawlt))
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

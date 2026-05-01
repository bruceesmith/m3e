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
	// setters         *strings.Builder
	renderers *strings.Builder
	slots     *strings.Builder
}

func GenerateTests(directory string, module *parser.Module, enumerationTestValues map[string]string, version string, date string) (err error) {

	// Enrich each Attribute with Test values for the render tests
	renderAttributes := make([]parser.Attribute, 0, len(module.Attributes))
	for _, v := range module.Attributes {
		attr := v
		if !v.IsStandard() && !v.IsOptional() && !v.IsSemBool() && v.Type != "Date" && v.Type != "Option(Date)" && v.Type != "number_string.NumberString" {
			attr.Test.Value = strcase.ToSnake(v.Type) + "." + enumerationTestValues[v.Type]
			attr.Test.AttributeValue = strcase.ToSnake(v.Type) + ".to_string(" + attr.Test.Value + ")"
		}
		renderAttributes = append(renderAttributes, attr)
	}
	renderModule := module
	renderModule.Attributes = renderAttributes

	gleam := GleamModule{}
	logger.TraceID("tests", fmt.Sprintf("Module %s", module.Name))

	fileName := strcase.ToSnake(module.Name)
	file, err := os.Create(filepath.Join(directory, fileName+"_test.gleam"))
	if err != nil {
		return fmt.Errorf("failed to create file %s: %w", fileName+".gleam", err)
	}
	defer file.Close()

	gleam.header, err = header(module.Name, module.Description, version, date)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	gleam.imports, err = imports(module)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}
	// enumerations = append(enumerations, definers...)

	gleam.configuration, err = config(module)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	// gleam.constructor, err = constructors(modName, module.Attributes)
	// if err != nil {
	// 	return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	// }

	// gleam.setters, err = setters(modName, module.Attributes)
	// if err != nil {
	// 	return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	// }

	gleam.renderers, err = render(renderModule)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	gleam.slots, err = slots(module)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	write(file, gleam)
	return
}

func write(file *os.File, gleam GleamModule) {
	fmt.Fprint(file, gleam.header.String())
	fmt.Fprint(file, gleam.imports.String())
	fmt.Fprint(file, gleam.configuration.String())
	// fmt.Fprint(file, gleam.constructor.String())
	// fmt.Fprint(file, gleam.setters.String())
	fmt.Fprint(file, gleam.renderers.String())
	fmt.Fprint(file, gleam.slots.String())
}

package code

import (
	"fmt"
	"generator/parser"
	"os"
	"path/filepath"
	"strings"

	"github.com/bruceesmith/logger"
)

type gleamModule struct {
	header        *strings.Builder
	imports       *strings.Builder
	slotDefs      *strings.Builder
	slotFn        *strings.Builder
	declaration   *strings.Builder
	configuration *strings.Builder
	constructor   *strings.Builder
	setters       *strings.Builder
	renderers     *strings.Builder
}

func generateModule(directory string, module *parser.Module, version string, date string) (err error) {
	gleam := gleamModule{}
	logger.TraceID("code", fmt.Sprintf("Module %s: %s\n", module.Name, module.Description))

	file, err := os.Create(filepath.Join(directory, module.SnakeName+".gleam"))
	if err != nil {
		return fmt.Errorf("failed to create file %s: %w", module.SnakeName+".gleam", err)
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

	gleam.declaration, err = declaration(module)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	gleam.slotDefs, gleam.slotFn, err = slots(module.Slots)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	gleam.configuration, err = config(module)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	gleam.constructor, err = constructors(module)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	gleam.setters, err = setters(module)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	gleam.renderers, err = render(module)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", module.Name, err)
	}

	write(file, gleam)
	return
}

func write(file *os.File, gleam gleamModule) {
	fmt.Fprint(file, gleam.header.String())
	fmt.Fprint(file, gleam.imports.String())
	fmt.Fprint(file, gleam.declaration.String())
	fmt.Fprint(file, gleam.slotDefs.String())
	fmt.Fprint(file, gleam.configuration.String())
	fmt.Fprint(file, gleam.constructor.String())
	fmt.Fprint(file, gleam.setters.String())
	fmt.Fprint(file, gleam.renderers.String())
	fmt.Fprint(file, gleam.slotFn.String())
}

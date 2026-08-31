package code

import (
	"errors"
	"fmt"
	"generator/parser"
	"log/slog"
	"os"
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

func generateModule(root *os.Root, module *parser.Module) (err error) {
	gleam := gleamModule{}
	logger.TraceID("code", fmt.Sprintf("Module %s: %s\n", module.Name, module.Description))

	err = root.Remove(module.SnakeName + ".gleam")
	if err != nil && !errors.Is(err, os.ErrNotExist) {
		return fmt.Errorf("cannot remove Gleam module %s: %w", module.SnakeName+".gleam", err)
	}
	file, err := root.OpenFile(module.SnakeName+".gleam", os.O_WRONLY|os.O_CREATE, 0644)
	if err != nil {
		return fmt.Errorf("failed to create file %s: %w", module.SnakeName+".gleam", err)
	}
	defer func() {
		if err := file.Close(); err != nil {
			slog.Error("error closing file", "filename", module.SnakeName+".gleam", "error", err)
		}
	}()

	gleam.header, err = header(module.Name, module.Description)
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
	output := func(file *os.File, s string) {
		if _, err := fmt.Fprint(file, s); err != nil {
			slog.Error("error writing to file", "error", err)
		}
	}
	output(file, gleam.header.String())
	output(file, gleam.imports.String())
	output(file, gleam.declaration.String())
	output(file, gleam.slotDefs.String())
	output(file, gleam.configuration.String())
	output(file, gleam.constructor.String())
	output(file, gleam.setters.String())
	output(file, gleam.renderers.String())
	output(file, gleam.slotFn.String())
}

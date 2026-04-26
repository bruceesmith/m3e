package code

import (
	"fmt"
	"generator/parser"
	"os"
	"path/filepath"
	"strings"

	"github.com/bruceesmith/logger"
	"github.com/iancoleman/strcase"
)

var (
	enumerations = make([]string, 0)
)

type GleamModule struct {
	header          *strings.Builder
	imports         *strings.Builder
	slotDefs        *strings.Builder
	slotFn          *strings.Builder
	viewDeclaration *strings.Builder
	configuration   *strings.Builder
	constructor     *strings.Builder
	setters         *strings.Builder
	renderers       *strings.Builder
}

func GenerateModule(directory string, modName string, module parser.Module, version string, date string) (err error) {
	gleam := GleamModule{}
	logger.TraceID("code", fmt.Sprintf("Module %s: %s\n", modName, module.Description))

	fileName := strcase.ToSnake(modName)
	file, err := os.Create(filepath.Join(directory, fileName+".gleam"))
	if err != nil {
		return fmt.Errorf("failed to create file %s: %w", fileName+".gleam", err)
	}
	defer file.Close()

	gleam.header, err = header(modName, module.Description, version, date)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", modName, err)
	}

	var definers []string
	gleam.imports, definers, err = imports(module.Attributes)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", modName, err)
	}
	enumerations = append(enumerations, definers...)

	gleam.viewDeclaration, err = declaration(modName, module.Attributes)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", modName, err)
	}

	gleam.slotDefs, gleam.slotFn, err = slots(module.Slots)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", modName, err)
	}

	gleam.configuration, err = config(module.Attributes)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", modName, err)
	}

	gleam.constructor, err = constructors(modName, module.Attributes)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", modName, err)
	}

	gleam.setters, err = setters(modName, module.Attributes)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", modName, err)
	}

	gleam.renderers, err = render(modName, module.TagName, module.Attributes)
	if err != nil {
		return fmt.Errorf("processing of %s failed: %w", modName, err)
	}

	write(file, gleam)
	return
}

func write(file *os.File, gleam GleamModule) {
	fmt.Fprint(file, gleam.header.String())
	if len(gleam.header.String()) < 10 {
		fmt.Println("empty header for", file.Name())
	}
	fmt.Fprint(file, gleam.imports.String())
	if len(gleam.imports.String()) < 10 {
		fmt.Println("empty imports for", file.Name())
	}
	fmt.Fprint(file, gleam.viewDeclaration.String())
	if len(gleam.viewDeclaration.String()) < 10 {
		fmt.Println("empty view for", file.Name())
	}
	fmt.Fprint(file, gleam.slotDefs.String())
	if len(gleam.slotDefs.String()) < 10 {
		fmt.Println("empty slots for", file.Name())
	}
	fmt.Fprint(file, gleam.configuration.String())
	if len(gleam.configuration.String()) < 10 {
		fmt.Println("empty config for", file.Name())
	}
	fmt.Fprint(file, gleam.constructor.String())
	if len(gleam.constructor.String()) < 10 {
		fmt.Println("empty constructor for", file.Name())
	}
	fmt.Fprint(file, gleam.setters.String())
	if len(gleam.setters.String()) < 10 {
		fmt.Println("empty setters for", file.Name())
	}
	fmt.Fprint(file, gleam.renderers.String())
	if len(gleam.renderers.String()) < 10 {
		fmt.Println("empty renderer for", file.Name())
	}
	fmt.Fprint(file, gleam.slotFn.String())
}

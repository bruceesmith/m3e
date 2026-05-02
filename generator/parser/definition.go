package parser

import (
	"fmt"
	"generator/cem"
	"os/exec"
	"strings"

	"github.com/bruceesmith/logger"
	"github.com/iancoleman/strcase"
)

// Definition is the internal representation of the entire CEM manifest for
// the Material 3 Expression components
type Definition struct {
	// Key is the CamelCase name of the module
	Modules map[string]Module
	// Key is the Camelcase name of the external enumeration type
	Enumerations map[string][]Enumeration
}

func (d *Definition) enumerations(m3eSource string, enumerations map[string]struct{}) (err error) {
	d.Enumerations = make(map[string][]Enumeration, len(enumerations))

	buf := make([]string, 0, 50)
	typeBuf := make([]tsTypeDef, 0, MaxEnumTypeDefs)
	for enum := range enumerations {
		cenum := strcase.ToCamel(enum)
		command := exec.Command("sh", "-c", `grep -r -l "export type `+cenum+`" `+m3eSource)
		stdoutStderr, err := command.CombinedOutput()
		if err != nil {
			return fmt.Errorf("failed to find enumeration declaration file for %s: %w", cenum, err)
		}
		fileName := strings.TrimSpace(string(stdoutStderr))
		if fileName == "" {
			return fmt.Errorf("failed to find enumeration declaration file for %s: %w", cenum, err)
		}
		var types []tsTypeDef
		types, err = typeDefinitions(fileName, cenum, typeBuf)
		if err != nil {
			return fmt.Errorf("failed to parse enumeration declaration file %s: %w", fileName, err)
		}
		for _, tipe := range types {
			def := make([]Enumeration, 0, len(tipe.Values))
			for _, value := range tipe.Values {
				value = strings.Trim(value, `"`)
				name := MapDigits(strcase.ToCamel(value), buf)
				def = append(def, Enumeration{
					Name:      name,
					Attribute: value,
				})
			}
			d.Enumerations[tipe.Name] = def
		}
	}
	return
}

// module extracts the module name, attributes and slots from a single module declaration
func (d *Definition) module(declaration cem.JavaScriptModuleDeclarationsElem) (externalModules []string) {
	name := strings.TrimSuffix(strings.TrimPrefix(declaration.Name, "M3e"), "Element")
	if name == "List" {
		name = "Mlist"
	}
	mod := Module{
		Tag:       *declaration.TagName,
		Slots:     MakeSlots(declaration.Slots),
		Name:      name,
		SnakeName: strcase.ToSnake(name),
		Imports:   make(map[string]string, maxImports),
	}
	desc := *declaration.Description
	first, remainder := desc[0], desc[1:]
	desc = strings.ToLower(string(first)) + string(remainder)
	desc = strings.ReplaceAll(desc, "\n", "\n//// ")
	mod.Description = desc

	mod.Attributes, mod.Imports, mod.TestImports, externalModules = MakeAttributes(name, declaration.Attributes)
	logger.TraceID("module", fmt.Sprintf("Module %s", name))
	d.Modules[name] = mod
	return externalModules
}

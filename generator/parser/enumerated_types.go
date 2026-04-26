package parser

import (
	"fmt"
	"os/exec"
	"strings"

	"github.com/iancoleman/strcase"
)

func enumeratedTypes(m3eSource string, enumerations map[string]struct{}) (defs map[string][]Enumeration, err error) {
	processed := make(map[string]struct{})
	defs = make(map[string][]Enumeration, len(enumerations))

	for enum := range enumerations {
		cenum := strcase.ToCamel(enum)
		command := exec.Command("sh", "-c", `grep -r -l "export type `+cenum+`" `+m3eSource)
		stdoutStderr, err := command.CombinedOutput()
		if err != nil {
			return nil, fmt.Errorf("failed to find enumeration declaration file for %s: %w", cenum, err)
		}
		fileName := strings.TrimSpace(string(stdoutStderr))
		if fileName == "" {
			return nil, fmt.Errorf("failed to find enumeration declaration file for %s: %w", cenum, err)
		}
		_, already := processed[fileName]
		if already {
			continue
		}
		processed[fileName] = struct{}{}
		var (
			types []tsTypeDef
		)
		types, err = typeDefinitions(fileName, cenum)
		if err != nil {
			return nil, fmt.Errorf("failed to parse enumeration declaration file %s: %w", fileName, err)
		}
		buf := make([]string, 0, 50)
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
			defs[tipe.Name] = def
		}
	}
	return
}

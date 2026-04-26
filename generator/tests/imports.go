package tests

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/iancoleman/strcase"
)

const importTemplate = `
{{ range $key, $value := .imports }}
import {{ $key }}
{{- end }}

`

var (
	importTmpl *template.Template = template.Must(template.New("imports").Parse(importTemplate))
)

func imports(attrs []parser.RefinedAttribute, modName string) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	imports := make(map[string]struct{}, 0)

	for _, attr := range attrs {
		for k, v := range attr.Imports {
			switch {
			case strings.HasPrefix(k, "gleam/") ||
				strings.HasPrefix(k, "lustre/") ||
				strings.HasPrefix(k, "m3e/"):
				if !strings.HasPrefix(k, "gleam/option") {
					imports[k+v] = struct{}{}
				}
			default:
				imports["m3e/"+k] = struct{}{}
			}
		}
	}
	if len(attrs) > 1 {
		imports["m3e/"+strcase.ToSnake(modName)+".{Config}"] = struct{}{}
	} else {
		imports["m3e/"+strcase.ToSnake(modName)] = struct{}{}
	}
	imports["gleam/list"] = struct{}{}
	imports["gleam/option.{None, Some} as opt"] = struct{}{}
	imports["gleeunit/should"] = struct{}{}
	imports["lustre/attribute"] = struct{}{}
	imports["lustre/element"] = struct{}{}
	imports["lustre/element/html"] = struct{}{}

	data := map[string]map[string]struct{}{
		"imports": imports,
	}
	err = importTmpl.Execute(builder, data)
	if err != nil {
		return nil, fmt.Errorf("imports failed to save result: %w", err)
	}
	return
}

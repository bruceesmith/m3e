package code

import (
	_ "embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed setters.tmpl
var settersTmplStr string
var settersTmpl *template.Template

func init() {
	var err error
	funcMap := template.FuncMap{
		"getSignature": func(count int, field, comp, t string) string {
			if count == 1 {
				return fmt.Sprintf("pub fn %s(_: %s, %s: %s) -> %s", field, comp, field, t, comp)
			}
			return fmt.Sprintf("pub fn %s(record: %s, %s: %s) -> %s", field, comp, field, t, comp)
		},
	}
	settersTmpl, err = template.New("setters").Funcs(funcMap).Parse(settersTmplStr)
	if err != nil {
		panic(err)
	}
}

func setters(module *parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	if err = settersTmpl.Execute(builder, module); err != nil {
		return nil, fmt.Errorf("setters failed to save result: %w", err)
	}

	return builder, nil
}

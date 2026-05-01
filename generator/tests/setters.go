package tests

import (
	"embed"
	"errors"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed setters*.tmpl
var settersTmplFS embed.FS
var settersTmpl *template.Template

func init() {
	var err error
	funcMap := template.FuncMap{
		"dict": func(values ...any) (map[string]any, error) {
			if len(values)%2 != 0 {
				return nil, errors.New("invalid dict call")
			}
			dict := make(map[string]any, len(values)/2)
			for i := 0; i < len(values); i += 2 {
				dict[values[i].(string)] = values[i+1]
			}
			return dict, nil
		},
	}
	settersTmpl, err = template.New("setters.tmpl").Funcs(funcMap).ParseFS(settersTmplFS, "setters*.tmpl")
	if err != nil {
		panic(err)
	}
}

func setters(module *parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}
	if len(module.Attributes) < 2 {
		return
	}

	if err = settersTmpl.Execute(builder, module); err != nil {
		return nil, fmt.Errorf("setters failed to save result: %w", err)
	}

	return builder, nil
}

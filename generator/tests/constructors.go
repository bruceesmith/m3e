package tests

import (
	"embed"
	"errors"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed constructors*.tmpl
var constructorFS embed.FS
var constructorTmpl *template.Template

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
	constructorTmpl, err = template.New("constructors.tmpl").Funcs(funcMap).ParseFS(constructorFS, "constructors*.tmpl")
	if err != nil {
		panic(err)
	}
}

func constructors(module *parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	if err = constructorTmpl.Execute(builder, module); err != nil {
		return nil, fmt.Errorf("constructors failed to save result: %w", err)
	}

	return builder, nil
}

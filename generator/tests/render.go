package tests

import (
	"embed"
	"errors"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed render*.tmpl
var renderTmplFS embed.FS
var renderTmpl *template.Template

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
	renderTmpl, err = template.New("render.tmpl").Funcs(funcMap).ParseFS(renderTmplFS, "render*.tmpl")
	if err != nil {
		panic(fmt.Errorf("render failed to parse its template: %w", err))
	}
}

func render(module *parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	err = renderTmpl.Execute(builder, module)
	if err != nil {
		return nil, fmt.Errorf("render failed to save result: %w", err)
	}
	return
}

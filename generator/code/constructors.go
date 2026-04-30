package code

import (
	"embed"
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
	constructorTmpl, err = template.ParseFS(constructorFS, "constructors*.tmpl")
	if err != nil {
		panic(err)
	}
}

func constructors(module parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	if err = constructorTmpl.Execute(builder, module); err != nil {
		return nil, fmt.Errorf("constructors failed to save result: %w", err)
	}

	return builder, nil
}

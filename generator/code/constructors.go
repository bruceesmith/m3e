package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

var constructorTmpl *template.Template

func init() {
	var err error
	constructorTmpl, err = template.ParseFiles(
		"code/constructors.tmpl",
		"code/constructors_from_config.tmpl",
		"code/constructors_new_zero.tmpl",
		"code/constructors_new_one.tmpl",
		"code/constructors_new_multi.tmpl",
	)
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

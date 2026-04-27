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
		"code/constructors_from_string.tmpl",
		"code/constructors_new_zero.tmpl",
		"code/constructors_new_one.tmpl",
		"code/constructors_new_multi.tmpl",
	)
	if err != nil {
		panic(err)
	}
}

func constructors(modName string, module parser.Module) (builder *strings.Builder, err error) {
	type Value struct {
		Name string
		Type string
	}

	type Configuration struct {
		Values  []Value
		ModName string
	}
	builder = &strings.Builder{}
	if modName == "List" {
		modName = "Mlist"
	}

	configuration := Configuration{
		ModName: modName,
	}

	for _, attr := range module.Attributes {
		configuration.Values = append(
			configuration.Values,
			Value{
				Name: attr.Name,
				Type: attr.Type,
			})
	}

	if err = constructorTmpl.Execute(builder, configuration); err != nil {
		return nil, fmt.Errorf("constructors failed to save result: %w", err)
	}

	return builder, nil
}

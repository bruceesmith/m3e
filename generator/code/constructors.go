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
	constructorTmpl, err = template.ParseFiles("code/constructors.tmpl")
	if err != nil {
		panic(err)
	}
}

func constructors(modName string, attributes []parser.RefinedAttribute) (builder *strings.Builder, err error) {
	type Configuration struct {
		Values  []string
		ModName string
	}
	builder = &strings.Builder{}
	if modName == "List" {
		modName = "MList"
	}

	configuration := Configuration{
		ModName: modName,
	}

	for _, attr := range attributes {
		configuration.Values = append(configuration.Values, attr.Name)
	}

	if err = constructorTmpl.Execute(builder, configuration); err != nil {
		return nil, fmt.Errorf("constructors failed to save result: %w", err)
	}

	return builder, nil
}

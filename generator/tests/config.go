package tests

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/iancoleman/strcase"
)

var configTmpl *template.Template

func init() {
	var err error
	configTmpl, err = template.ParseFiles("tests/config.tmpl")
	if err != nil {
		panic(fmt.Errorf("config failed to parse its template: %w", err))
	}
}

func config(attributes []parser.RefinedAttribute, modName string) (builder *strings.Builder, err error) {
	type Declaration struct {
		ModName string
		Values  map[string]string
	}
	builder = &strings.Builder{}
	if len(attributes) < 2 {
		return builder, nil
	}

	declaration := Declaration{
		ModName: strcase.ToSnake(modName),
		Values:  make(map[string]string, len(attributes)),
	}

	for _, attr := range attributes {
		if len(attr.Default) > 0 {
			if len(attr.QualifiedDefault) > 0 {
				declaration.Values[attr.Name] = attr.QualifiedDefault
			} else {
				declaration.Values[attr.Name] = attr.Default
			}
		}
	}
	err = configTmpl.Execute(builder, declaration)
	if err != nil {
		return nil, fmt.Errorf("config failed to save result: %w", err)
	}
	return
}

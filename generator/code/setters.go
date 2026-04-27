package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

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
	settersTmpl, err = template.New("setters.tmpl").Funcs(funcMap).ParseFiles("code/setters.tmpl")
	if err != nil {
		panic(err)
	}
}

func setters(modName string, module parser.Module) (builder *strings.Builder, err error) {
	type Value struct {
		Field string
		Type  string
	}
	type Setters struct {
		Module string
		Values []Value
	}
	builder = &strings.Builder{}
	if modName == "List" {
		modName = "Mlist"
	}
	if len(module.Attributes) == 0 {
		return builder, nil
	}

	setters := Setters{
		Module: modName,
		Values: make([]Value, 0, len(module.Attributes)),
	}

	for _, attr := range module.Attributes {
		setters.Values = append(setters.Values, Value{Field: attr.Name, Type: attr.Type})
	}

	if err = settersTmpl.Execute(builder, setters); err != nil {
		return nil, fmt.Errorf("setters failed to save result: %w", err)
	}

	return builder, nil
}

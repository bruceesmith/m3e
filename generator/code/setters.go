package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

const settersTemplate = `{{ $module := .Module }}{{ $count := len .Values }}
// --- Setters ---
{{ range $index, $val := .Values }}
{{- /* Add a blank line between functions */}}
{{- if $index }}{{ "\n" }}{{ end }}
/// {{ $val.Field }} sets the value of {{ $val.Field }} for this {{ $module }}.
///
{{ getSignature $count $val.Field $module $val.Type }} {
 {{- if gt $count 1 }}
 {{ $module }}(..record, {{ $val.Field }}: {{ $val.Field }})
 {{- else }}
 {{ $module }}({{ $val.Field }}: {{ $val.Field }})
 {{- end }}
}
{{- end }}
`

var ()

func setters(modName string, attributes []parser.RefinedAttribute) (builder *strings.Builder, err error) {
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
		modName = "MList"
	}

	if len(attributes) == 0 {
		return builder, nil
	}

	setters := Setters{
		Module: modName,
		Values: make([]Value, 0, len(attributes)),
	}

	for _, attr := range attributes {
		setters.Values = append(setters.Values, Value{Field: attr.Name, Type: attr.Type})
	}

	funcMap := template.FuncMap{
		"getSignature": func(count int, field, comp, t string) string {
			if count == 1 {
				return fmt.Sprintf("pub fn %s(_: %s, %s: %s) -> %s", field, comp, field, t, comp)
			}
			return fmt.Sprintf("pub fn %s(record: %s, %s: %s) -> %s", field, comp, field, t, comp)
		},
	}
	templ := template.New("setter")
	templ.Funcs(funcMap)
	settersTmpl := template.Must(templ.Parse(settersTemplate))
	if err = settersTmpl.Execute(builder, setters); err != nil {
		return nil, fmt.Errorf("setters failed to save result: %w", err)
	}

	return builder, nil
}

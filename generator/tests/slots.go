package tests

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/iancoleman/strcase"
)

const slotsTemplate = `
pub fn {{.ModName}}_slot_test() {
  // 1. Define the test cases in a list of tuples: #(input, expected)
  let cases = [
{{ range .Slots }}
    #({{$.ModName}}.{{ .Name }}, attribute.attribute("slot", "{{ .Attribute }}")),
{{- end }}
  ]

  // 2. Iterate over the list and run assertions for each
  list.each(cases, fn(c) {
    let #(s, expected) = c

    {{.ModName}}.slot(s)
    |> should.equal(expected)
  })
}`

// #(app_bar.Leading, attribute.attribute("slot", "leading")),
var (
	slotsFnTmpl *template.Template = template.Must(template.New("slots").Parse(slotsTemplate))
)

func slots(theSlots []parser.Slot, modName string) (builder *strings.Builder, err error) {
	type Slot struct {
		Name        string
		Description string
		Attribute   string
	}

	builder = &strings.Builder{}
	if len(theSlots) == 0 {
		return builder, nil
	}

	var slots []Slot = make([]Slot, 0, len(theSlots))
	for _, slot := range theSlots {
		if len(slot.Name) > 0 {
			slots = append(slots, Slot{Name: slot.Name, Description: slot.Description, Attribute: slot.Attribute})
		}
	}
	data := struct {
		Slots   []Slot
		ModName string
	}{
		Slots:   slots,
		ModName: strcase.ToSnake(modName),
	}

	err = slotsFnTmpl.Execute(builder, data)
	if err != nil {
		return nil, fmt.Errorf("slots failed to save result: %w", err)
	}
	return
}

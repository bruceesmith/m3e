package tests

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/iancoleman/strcase"
)

var slotsTmpl *template.Template

func init() {
	var err error
	slotsTmpl, err = template.ParseFiles("tests/slots.tmpl")
	if err != nil {
		panic(err)
	}
}

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

	err = slotsTmpl.Execute(builder, data)
	if err != nil {
		return nil, fmt.Errorf("slots failed to save result: %w", err)
	}
	return builder, nil
}

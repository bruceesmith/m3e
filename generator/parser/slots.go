package parser

import (
	"generator/cem"

	"github.com/iancoleman/strcase"
)

// makeSlots generates the slots() function in a Gleam module
func makeSlots(theSlots []cem.Slot) (slots []Slot) {

	if len(theSlots) == 0 {
		return
	}

	slots = make([]Slot, 0, len(theSlots))
	for _, slot := range theSlots {
		if len(slot.Name) > 0 {
			slots = append(slots, Slot{CamelName: strcase.ToCamel(slot.Name), KebabName: slot.Name, Description: *slot.Description, Attribute: slot.Name})
		}
	}
	return
}

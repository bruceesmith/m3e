package parser

import (
	"generator/cem"

	"github.com/iancoleman/strcase"
)

func MakeSlots(theSlots []cem.Slot) (slots []Slot) {

	if len(theSlots) == 0 {
		return
	}

	slots = make([]Slot, 0, len(theSlots))
	for _, slot := range theSlots {
		if len(slot.Name) > 0 {
			slots = append(slots, Slot{Name: strcase.ToCamel(slot.Name), Description: *slot.Description, Attribute: strcase.ToKebab(slot.Name)})
		}
	}
	return
}

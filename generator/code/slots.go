package code

import (
	_ "embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

var (
	//go:embed slots_def.tmpl
	slotsDefTmplStr string
	slotsDefTmpl    *template.Template
	//go:embed slots_fn.tmpl
	slotsFnTmplStr string
	slotsFnTmpl    *template.Template
)

func init() {
	var err error
	slotsDefTmpl, err = template.New("slots_def").Parse(slotsDefTmplStr)
	if err != nil {
		panic(err)
	}
	slotsFnTmpl, err = template.New("slots_fn").Parse(slotsFnTmplStr)
	if err != nil {
		panic(err)
	}
}

func slots(theSlots []parser.Slot) (defBuilder *strings.Builder, fnBuilder *strings.Builder, err error) {
	type Slot struct {
		Name        string
		Description string
		Attribute   string
	}

	defBuilder = &strings.Builder{}
	fnBuilder = &strings.Builder{}
	if len(theSlots) == 0 {
		return
	}

	var slots = make([]Slot, 0, len(theSlots))
	for _, slot := range theSlots {
		if len(slot.Name) > 0 {
			slots = append(slots, Slot{Name: slot.Name, Description: slot.Description, Attribute: slot.Attribute})
		}
	}
	data := map[string][]Slot{
		"slots": slots,
	}

	err = slotsDefTmpl.Execute(defBuilder, data)
	if err != nil {
		return nil, nil, fmt.Errorf("slots failed to save result: %w", err)
	}

	err = slotsFnTmpl.Execute(fnBuilder, data)
	if err != nil {
		return nil, nil, fmt.Errorf("slots failed to save result: %w", err)
	}
	return
}

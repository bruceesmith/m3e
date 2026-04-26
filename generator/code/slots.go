package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

const slotsDefTemplate = `
{{ if .slots }}
/// Slots are used in child elements to insert content into this component
///
pub type Slot {
{{- end }}
{{- range .slots }}
 {{ .Name }}
{{- if .Description }}
 // {{ .Description }}
{{- end }}
{{- end }}
{{- if .slots }}
}
{{- end }}
`

const slotsFnTemplate = `
{{- if .slots }}
/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
 case s {
{{- range .slots }}
   {{ .Name }} -> attribute.attribute("slot", "{{ .Attribute }}")
{{- end }}
 }
}
{{- end }}
`

var (
	slotsDefTmpl *template.Template = template.Must(template.New("slots").Parse(slotsDefTemplate))
	slotsFnTmpl  *template.Template = template.Must(template.New("slots").Parse(slotsFnTemplate))
)

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

	var slots []Slot = make([]Slot, 0, len(theSlots))
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

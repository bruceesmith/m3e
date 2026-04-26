package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

const declarationTemplate = `{{$count := len .Attributes}}
// --- Types ---

/// {{ .ModName }} is a View Model for this component
///
{{- if .Attributes }}
/// ## Fields:
///
{{- end }}
{{- range .Attributes }}
/// - {{ .Name }}: {{ .Description }}
{{- end }}
{{- if .Attributes }}
///
{{- end }}
pub opaque type {{ .ModName }} {
{{- if gt $count 0 }}
 {{ .ModName }}(
{{- range .Attributes }}
   {{ .Name }}: {{ .Type }},
{{- end }}
 )
}
{{- else }}
 {{ .ModName }}()
}
{{- end -}}
{{- range .Enumerations }}

/// {{ .Name }} is {{ .Description }}
///
pub type {{ .Name }} {
 Is{{ .Name }}
 IsNot{{ .Name }}
}
{{- end }}
{{- if .Defaults }}

// --- Defaults ---

{{- range $key, $value := .Defaults }}

pub const default_{{ $key }}: {{ $value.Type }} = {{ printf "%s" $value.Value }}
{{- end }}
{{- end }}`

var (
	declarationTmpl *template.Template = template.Must(template.New("view").Parse(declarationTemplate))
)

func declaration(modName string, attributes []parser.RefinedAttribute) (builder *strings.Builder, err error) {
	type Enum struct {
		Name        string
		Description string
	}
	type Default struct {
		Type  string
		Value string
	}
	type Declaration struct {
		Attributes   []parser.RefinedAttribute
		Defaults     map[string]Default
		Enumerations []Enum
		ModName      string
	}
	builder = &strings.Builder{}
	if modName == "List" {
		modName = "MList"
	}

	declaration := Declaration{
		Attributes:   attributes,
		Defaults:     make(map[string]Default, len(attributes)),
		Enumerations: make([]Enum, 0, len(attributes)),
		ModName:      modName,
	}

	for _, attr := range attributes {
		if len(attr.Enum) > 0 {
			first := string(attr.Description[0])
			desc := strings.ToLower(first) + strings.TrimPrefix(attr.Description, first)
			decl := Enum{
				Name:        attr.Enum,
				Description: desc,
			}
			declaration.Enumerations = append(declaration.Enumerations, decl)
		}
		if len(attr.Default) > 0 {
			declaration.Defaults[attr.Name] = Default{
				Type:  attr.Type,
				Value: attr.Default,
			}
		}
	}

	err = declarationTmpl.Execute(builder, declaration)
	if err != nil {
		return nil, fmt.Errorf("viewRecordDeclaration failed to save result: %w", err)
	}
	return
}

package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

const configTemplate = `{{$count := len .Attributes}}
// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
{{- if gt $count 0 }}
 Config(
{{- range .Attributes }}
   {{ .Name }}: {{ .Type }},
{{- end }}
 )
}
{{- else }}
 Config()
}
{{- end }}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
{{- if gt $count 0 }}
 Config(
{{- range $key, $value := .Values }}
   {{ $key }}: {{ $value }},
{{- end }}
 )
}
{{- else }}
 Config()
}
{{- end }}
`

var (
	configTmpl *template.Template = template.Must(template.New("config").Parse(configTemplate))
)

func config(attributes []parser.RefinedAttribute) (builder *strings.Builder, err error) {
	type Declaration struct {
		Attributes []parser.RefinedAttribute
		Values     map[string]string
	}
	builder = &strings.Builder{}
	if len(attributes) == 0 {
		return builder, nil
	}

	declaration := Declaration{
		Attributes: attributes,
		Values:     make(map[string]string, len(attributes)),
	}

	for _, attr := range attributes {
		if len(attr.Default) > 0 {
			declaration.Values[attr.Name] = "default_" + attr.Name
		}
	}

	err = configTmpl.Execute(builder, declaration)
	if err != nil {
		return nil, fmt.Errorf("config failed to save result: %w", err)
	}
	return
}

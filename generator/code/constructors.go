package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

const constructorTemplate = `{{$count := len .Values}}
// --- Constructors ---
{{ if gt $count 0 }}
/// from_config creates a new {{ .ModName}} from the given configuration.
///
pub fn from_config(config: Config) -> {{ .ModName }} {
 {{ .ModName }}(
{{- range .Values }}
   {{ . }}: config.{{ . }},
{{- end }}
 )
}
{{- end }}

/// new creates a new {{ .ModName}} with the default configuration.
///
pub fn new() -> {{ .ModName}} {
{{- if gt $count 0 }}
   from_config(default_config())
}
{{- else }}
 {{ .ModName }}
}
{{- end }}
`

var (
	constructorTmpl *template.Template = template.Must(template.New("constructor").Parse(constructorTemplate))
)

func constructors(modName string, attributes []parser.RefinedAttribute) (builder *strings.Builder, err error) {
	type Configuration struct {
		Values  []string
		ModName string
	}
	builder = &strings.Builder{}
	if modName == "List" {
		modName = "MList"
	}

	configuration := Configuration{
		ModName: modName,
	}

	for _, attr := range attributes {
		configuration.Values = append(configuration.Values, attr.Name)
	}

	if err = constructorTmpl.Execute(builder, configuration); err != nil {
		return nil, fmt.Errorf("constructors failed to save result: %w", err)
	}

	return builder, nil
}

package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/bruceesmith/logger"
	"github.com/iancoleman/strcase"
)

const renderTemplate = `{{$count := len .Values}}
// --- Renderers ---

/// render creates a Lustre Element for a {{.ModName}}
///
pub fn render(
{{- if gt $count 0 }}
 model: {{.ModName}},
{{- else -}}
 _: {{.ModName}},
{{- end -}}
 attributes: List(Attribute(msg)),
 children: List(Element(msg)),
) -> Element(msg) {
 element.element(
   "{{.TagName}}",
{{- if gt $count 0 }}
   list.flatten([
     [
{{- range .Values}}
       {{.}},
{{- end}}
     ],
     attributes,
   ])
     |> list.filter(fn(a) { a != attribute.none() }),
{{- else -}}
   attributes,
{{- end -}}
   children,
 )
}

{{- if gt $count 0 }}
/// render_config creates a Lustre Element from a {{.ModName}} Config
///
pub fn render_config(
 c: Config,
 attributes: List(Attribute(msg)),
 children: List(Element(msg)),
) -> Element(msg) {
 render(from_config(c), attributes, children)
}
{{- end }}
`

var (
	renderTmpl *template.Template = template.Must(template.New("render").Parse(renderTemplate))
)

func render(modName string, tagName string, attributes []parser.RefinedAttribute) (builder *strings.Builder, err error) {
	type Render struct {
		Values  []string
		ModName string
		TagName string
	}
	builder = &strings.Builder{}

	if len(tagName) == 0 {
		logger.Error(fmt.Sprintf("tagName for %s is empty, skipping renderers generation", modName))
		return builder, nil
	}

	data := Render{
		ModName: modName,
		TagName: tagName,
	}

	for _, attr := range attributes {
		switch {
		case len(attr.Enum) > 0:
			data.Values = append(data.Values, enumAttribute(attr))
		case strings.HasPrefix(attr.Type, "Option("):
			data.Values = append(data.Values, optionAttribute(attr))
		case strings.HasPrefix(attr.Type, "List("):
			data.Values = append(data.Values, listAttribute(attr))
		default:
			data.Values = append(data.Values, attributeWithDefault(attr))
		}
	}

	err = renderTmpl.Execute(builder, data)
	if err != nil {
		return nil, fmt.Errorf("config failed to save result: %w", err)
	}
	return
}

func attributeWithDefault(attr parser.RefinedAttribute) string {
	const format1 = `attr.with_default(
          "%s",
          model.%s,
          default_%s,
        )`
	const format2 = `attr.with_default(
          "%s",
          %s.to_string(model.%s),
          %s.to_string(default_%s),
        )`
	if attr.Type == "String" {
		return fmt.Sprintf(format1, attr.Name, attr.Name, attr.Name)
	}
	return fmt.Sprintf(format2, attr.Name, strcase.ToSnake(attr.Type), attr.Name, strcase.ToSnake(attr.Type), attr.Name)
}

func enumAttribute(attr parser.RefinedAttribute) string {
	return fmt.Sprintf("attr.boolean(\"%s\", model.%s == Is%s)", attr.Name, attr.Name, attr.Enum)
}

func listAttribute(attr parser.RefinedAttribute) string {
	const format = `attribute.attribute(
          "%s",
          list.fold(model.%s, "", fn(acc, s) { acc <> " " <> s }),
        )`
	return fmt.Sprintf(format, attr.Name, attr.Name)
}

func optionAttribute(attr parser.RefinedAttribute) string {
	const format1 = `attr.option(
          model.%s,
          fn(_) { "%s" },
          function.identity,
          default_%s,
        )`
	const format2 = `attr.option(
          model.%s,
          fn(_) { "%s" },
          %s.to_string,
          default_%s,
        )`
	if attr.Type == "Option(String)" {
		return fmt.Sprintf(format1, attr.Name, attr.Name, attr.Name)
	}
	module := strcase.ToSnake(strings.TrimSuffix(strings.TrimPrefix(attr.Type, "Option("), ")"))
	return fmt.Sprintf(format2, attr.Name, attr.Name, module, attr.Name)
}

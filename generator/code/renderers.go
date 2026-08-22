package code

import (
	"embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/bruceesmith/logger"
	"github.com/iancoleman/strcase"
)

//go:embed renderers*.tmpl
var renderersFS embed.FS
var renderTmpl *template.Template

func init() {
	var err error
	renderTmpl, err = template.ParseFS(renderersFS, "renderers*.tmpl")
	if err != nil {
		panic(err)
	}
}

func render(module *parser.Module) (builder *strings.Builder, err error) {
	type Render struct {
		Attributes  []string
		HasChildren bool
		Name        string
		Tag         string
	}
	builder = &strings.Builder{}

	if len(module.Tag) == 0 {
		logger.Error(fmt.Sprintf("tag for %s is empty, skipping renderers generation", module.Name))
		return builder, nil
	}

	data := Render{
		HasChildren: module.HasChildren,
		Name:        module.Name,
		Tag:         module.Tag,
	}

	for _, attr := range module.Attributes {
		switch {
		case attr.IsSemBool():
			data.Attributes = append(data.Attributes, semBoolAttribute(attr))
		case attr.IsOptional():
			data.Attributes = append(data.Attributes, optionAttribute(attr))
		case attr.IsList():
			data.Attributes = append(data.Attributes, listAttribute(attr))
		default:
			data.Attributes = append(data.Attributes, attributeWithDefault(attr))
		}
	}
	err = renderTmpl.Execute(builder, data)
	if err != nil {
		return nil, fmt.Errorf("config failed to save result: %w", err)
	}
	return
}

func attributeWithDefault(attr parser.Attribute) string {
	const format1 = `attr.with_default(
          "%s",
          model.%s,
          default_%s,
        )`
	const format2 = `attr.with_default(
                 "%s",
                 number_string.to_string(model.%s),
                 number_string.to_string(default_%s),
               )`

	const format3 = `attr.with_default(
          "%s",
          %s.to_string(model.%s),
          %s.to_string(default_%s),
        )`
	if attr.Type == "String" {
		return fmt.Sprintf(format1, attr.KebabName, attr.SnakeName, attr.SnakeName)
	}
	if attr.Type == "number_string.NumberString" {
		return fmt.Sprintf(format2, attr.KebabName, attr.SnakeName, attr.SnakeName)
	}
	return fmt.Sprintf(format3, attr.KebabName, strcase.ToSnake(attr.Type), attr.SnakeName, strcase.ToSnake(attr.Type), attr.SnakeName)
}

func listAttribute(attr parser.Attribute) string {
	const format = `attr.list_of_string("%s",model.%s)`
	return fmt.Sprintf(format, attr.SnakeName, attr.SnakeName)
}

func optionAttribute(attr parser.Attribute) string {
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
		return fmt.Sprintf(format1, attr.SnakeName, attr.KebabName, attr.SnakeName)
	}
	module := strcase.ToSnake(strings.TrimSuffix(strings.TrimPrefix(attr.Type, "Option("), ")"))
	return fmt.Sprintf(format2, attr.SnakeName, attr.KebabName, module, attr.SnakeName)
}

func semBoolAttribute(attr parser.Attribute) string {
	return fmt.Sprintf("attr.boolean(\"%s\", model.%s == Is%s)", attr.KebabName, attr.SnakeName, attr.SemBool)
}

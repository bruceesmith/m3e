package tests

import (
	"embed"
	"errors"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/bruceesmith/logger"
	"github.com/iancoleman/strcase"
)

//go:embed render*.tmpl
var renderTmplFS embed.FS
var renderTmpl *template.Template

func init() {
	var err error
	funcMap := template.FuncMap{
		"dict": func(values ...any) (map[string]any, error) {
			if len(values)%2 != 0 {
				return nil, errors.New("invalid dict call")
			}
			dict := make(map[string]any, len(values)/2)
			for i := 0; i < len(values); i += 2 {
				dict[values[i].(string)] = values[i+1]
			}
			return dict, nil
		},
	}
	renderTmpl, err = template.New("render.tmpl").Funcs(funcMap).ParseFS(renderTmplFS, "render*.tmpl")
	if err != nil {
		panic(fmt.Errorf("render failed to parse its template: %w", err))
	}
}

func render(module *parser.Module, enumerations map[string][]parser.Enumeration) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	err = renderTmpl.Execute(builder, enumerationTestValues(module, enumerations))
	if err != nil {
		return nil, fmt.Errorf("render failed to save result: %w", err)
	}
	return
}

func enumerationTestValues(module *parser.Module, enumerations map[string][]parser.Enumeration) (renderModule *parser.Module) {
	// During module creation it is not possible to discover test values for external
	// enumeration types. So now create these & add them into Attributes
	renderAttributes := make([]parser.Attribute, 0, len(module.Attributes))
	for _, v := range module.Attributes {
		attr := v
		if !v.IsStandard() && !v.IsOptional() && !v.IsSemBool() && v.Type != "Date" && v.Type != "number_string.NumberString" {
			parts := strings.Split(attr.Default, ".")
			if len(parts) != 2 {
				logger.Info(fmt.Sprintf("default value %s for attribute %s in module %s should be qualified", attr.Default, module.Name, attr.Name))
				continue
			}
			def := ""
			for _, v := range enumerations[attr.Type] {
				if v.Name != parts[1] {
					def = v.Name
					break
				}
			}
			if def == "" {
				logger.Info(fmt.Sprintf("default value %s for attribute %s in module %s cannot be extracted\n", attr.Default, module.Name, attr.Name))
			} else {
				attr.Test.Value = strcase.ToSnake(v.Type) + "." + def
				attr.Test.AttributeValue = strcase.ToSnake(v.Type) + ".to_string(" + attr.Test.Value + ")"
			}
		}
		renderAttributes = append(renderAttributes, attr)
	}
	renderModule = module
	renderModule.Attributes = renderAttributes
	return renderModule
}

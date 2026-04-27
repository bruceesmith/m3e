package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

var configTmpl *template.Template

func init() {
	var err error
	configTmpl, err = template.ParseFiles(
		"code/config.tmpl",
		"code/config_type.tmpl",
		"code/config_default.tmpl")
	if err != nil {
		panic(err)
	}
}

func config(module parser.Module) (builder *strings.Builder, err error) {
	type Declaration struct {
		Attributes []parser.RefinedAttribute
		Values     map[string]string
	}
	builder = &strings.Builder{}
	if len(module.Attributes) == 0 {
		return builder, nil
	}

	err = configTmpl.Execute(builder, module)
	if err != nil {
		return nil, fmt.Errorf("config failed to save result: %w", err)
	}
	return
}

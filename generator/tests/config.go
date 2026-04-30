package tests

import (
	_ "embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed config.tmpl
var configTmplStr string
var configTmpl *template.Template

func init() {
	var err error
	configTmpl, err = template.New("config").Parse(configTmplStr)
	if err != nil {
		panic(fmt.Errorf("config failed to parse its template: %w", err))
	}
}

func config(module parser.Module) (builder *strings.Builder, err error) {
	type Declaration struct {
		ModName string
		Values  map[string]string
	}
	builder = &strings.Builder{}
	if len(module.Attributes) < 2 {
		return builder, nil
	}

	err = configTmpl.Execute(builder, module)
	if err != nil {
		return nil, fmt.Errorf("config failed to save result: %w", err)
	}
	return
}

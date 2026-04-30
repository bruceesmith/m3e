package tests

import (
	_ "embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed slots.tmpl
var slotsTmplStr string
var slotsTmpl *template.Template

func init() {
	var err error
	slotsTmpl, err = template.New("slots").Parse(slotsTmplStr)
	if err != nil {
		panic(err)
	}
}

func slots(module *parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}
	if len(module.Slots) == 0 {
		return builder, nil
	}

	err = slotsTmpl.Execute(builder, module)
	if err != nil {
		return nil, fmt.Errorf("slots failed to save result: %w", err)
	}
	return builder, nil
}

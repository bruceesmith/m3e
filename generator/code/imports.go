package code

import (
	_ "embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed imports.tmpl
var importTmplStr string
var importTmpl *template.Template

func init() {
	var err error
	importTmpl, err = template.New("imports").Parse(importTmplStr)
	if err != nil {
		panic(err)
	}
}

func imports(module *parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	err = importTmpl.Execute(builder, module.Imports)
	if err != nil {
		return nil, fmt.Errorf("imports failed to save result: %w", err)
	}
	return
}

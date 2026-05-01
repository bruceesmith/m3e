package tests

import (
	_ "embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed imports.tmpl
var importsTmplStr string
var importTmpl *template.Template

func init() {
	var err error
	importTmpl, err = template.New("imports").Parse(importsTmplStr)
	if err != nil {
		panic(fmt.Errorf("imports failed to parse its template: %w", err))
	}
}

func imports(module *parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	err = importTmpl.Execute(builder, module.TestImports)
	if err != nil {
		return nil, fmt.Errorf("imports failed to save result: %w", err)
	}
	return
}

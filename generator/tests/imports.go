package tests

import (
	_ "embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/iancoleman/strcase"
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
	imports := module.Imports

	if len(module.Attributes) > 1 {
		imports["m3e/"+strcase.ToSnake(module.Name)] = ".{Config}"
	} else {
		imports["m3e/"+strcase.ToSnake(module.Name)] = ""
	}
	imports["gleam/list"] = ""
	imports["gleam/option"] = ".{None, Some} as opt"
	imports["gleeunit/should"] = ""
	imports["lustre/attribute"] = ""
	imports["lustre/element"] = ""
	imports["lustre/element/html"] = ""

	err = importTmpl.Execute(builder, imports)
	if err != nil {
		return nil, fmt.Errorf("imports failed to save result: %w", err)
	}
	return
}

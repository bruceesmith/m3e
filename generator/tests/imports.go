package tests

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/iancoleman/strcase"
)

var importTmpl *template.Template

func init() {
	var err error
	importTmpl, err = template.ParseFiles("tests/imports.tmpl")
	if err != nil {
		panic(fmt.Errorf("imports failed to parse its template: %w", err))
	}
}

func imports(module parser.Module, modName string) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	imports := make(map[string]struct{}, 0)

	for _, attr := range module.Attributes {
		for k, v := range attr.Imports {
			switch {
			case strings.HasPrefix(k, "gleam/") ||
				strings.HasPrefix(k, "lustre/") ||
				strings.HasPrefix(k, "m3e/"):
				if !strings.HasPrefix(k, "gleam/option") {
					imports[k+v] = struct{}{}
				}
			default:
				imports["m3e/"+k] = struct{}{}
			}
		}
	}
	if len(module.Attributes) > 1 {
		imports["m3e/"+strcase.ToSnake(modName)+".{Config}"] = struct{}{}
	} else {
		imports["m3e/"+strcase.ToSnake(modName)] = struct{}{}
	}
	imports["gleam/list"] = struct{}{}
	imports["gleam/option.{None, Some} as opt"] = struct{}{}
	imports["gleeunit/should"] = struct{}{}
	imports["lustre/attribute"] = struct{}{}
	imports["lustre/element"] = struct{}{}
	imports["lustre/element/html"] = struct{}{}

	data := map[string]map[string]struct{}{
		"imports": imports,
	}
	err = importTmpl.Execute(builder, data)
	if err != nil {
		return nil, fmt.Errorf("imports failed to save result: %w", err)
	}
	return
}

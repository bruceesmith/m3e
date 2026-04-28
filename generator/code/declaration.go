package code

import (
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

var declarationTmpl *template.Template

func init() {
	var err error
	funcMap := template.FuncMap{
		"getDescription": func(tipe, description string) string {
			first := strings.ToLower(description[:1])
			rest := description[1:]
			return fmt.Sprintf("%s is %s", tipe, first+rest)
		},
	}
	declarationTmpl, err = template.New("declaration.tmpl").Funcs(funcMap).ParseFiles(
		"code/declaration.tmpl",
		"code/declaration_type.tmpl",
		"code/declaration_enums.tmpl",
		"code/declaration_defaults.tmpl",
	)
	if err != nil {
		panic(err)
	}
}

func declaration(module parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	err = declarationTmpl.Execute(builder, module)
	if err != nil {
		return nil, fmt.Errorf("declaration failed to save result: %w", err)
	}
	return
}

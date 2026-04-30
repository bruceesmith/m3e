package code

import (
	"embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed declaration*.tmpl
var declarationFS embed.FS
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
	declarationTmpl, err = template.New("declaration.tmpl").Funcs(funcMap).ParseFS(declarationFS, "declaration*.tmpl")
	if err != nil {
		panic(err)
	}
}

func declaration(module *parser.Module) (builder *strings.Builder, err error) {
	builder = &strings.Builder{}

	err = declarationTmpl.Execute(builder, module)
	if err != nil {
		return nil, fmt.Errorf("declaration failed to save result: %w", err)
	}
	return
}

package code

import (
	"embed"
	"fmt"
	"generator/parser"
	"strings"
	"text/template"
)

//go:embed config*.tmpl
var configFS embed.FS
var configTmpl *template.Template

func init() {
	var err error
	configTmpl, err = template.ParseFS(configFS, "config*.tmpl")
	if err != nil {
		panic(err)
	}
}

func config(module *parser.Module) (builder *strings.Builder, err error) {
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

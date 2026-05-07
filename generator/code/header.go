package code

import (
	_ "embed"
	"fmt"
	"strings"
	"text/template"
)

//go:embed header.tmpl
var headerTmplStr string
var headerTmpl *template.Template

func init() {
	var err error
	headerTmpl, err = template.New("header").Parse(headerTmplStr)
	if err != nil {
		panic(err)
	}
}

func header(name, desc string) (builder *strings.Builder, err error) {
	type headerData struct {
		Name string
		Desc string
	}
	if len(desc) > 0 {
		first, remainder := desc[0], desc[1:]
		desc = strings.ToLower(string(first)) + string(remainder)
	}
	desc = strings.ReplaceAll(desc, "\n", "\n//// ")

	builder = &strings.Builder{}
	err = headerTmpl.Execute(builder, headerData{Name: name, Desc: desc})
	if err != nil {
		err = fmt.Errorf("header failed to save result: %w", err)
	}
	return builder, err
}

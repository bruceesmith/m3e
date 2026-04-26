package tests

import (
	"fmt"
	"strings"
	"text/template"
)

const headerTemplate = `//// {{.Name}} unit tests
////
//// This file was generated:
////    By: m3e/generator version {{.Version}}
////    At: {{.Date}}
////
////          DO NOT EDIT
////`

var (
	headerTmpl *template.Template = template.Must(template.New("header").Parse(headerTemplate))
)

func header(name, desc, version string, date string) (builder *strings.Builder, err error) {
	type data struct {
		Name    string
		Date    string
		Desc    string
		Version string
	}
	first, remainder := desc[0], desc[1:]
	desc = strings.ToLower(string(first)) + string(remainder)
	desc = strings.ReplaceAll(desc, "\n", "\n//// ")

	builder = &strings.Builder{}
	err = headerTmpl.Execute(builder, data{Name: name, Date: date, Desc: desc, Version: version})
	if err != nil {
		err = fmt.Errorf("header failed to save result: %w", err)
	}
	return builder, err
}

package tests

import (
	"fmt"
	"strings"
	"text/template"
)

var headerTmpl *template.Template

func init() {
	var err error
	headerTmpl, err = template.ParseFiles("tests/header.tmpl")
	if err != nil {
		panic(fmt.Errorf("header failed to parse its template: %w", err))
	}
}

func header(name, desc, version string, date string) (builder *strings.Builder, err error) {
	type data struct {
		Name    string
		Date    string
		Version string
	}

	builder = &strings.Builder{}
	err = headerTmpl.Execute(builder, data{Name: name, Date: date, Version: version})
	if err != nil {
		err = fmt.Errorf("header failed to save result: %w", err)
	}
	return builder, err
}

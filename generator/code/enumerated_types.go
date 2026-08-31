package code

import (
	_ "embed"
	"fmt"
	"generator/parser"
	"log/slog"
	"os"
	"text/template"

	"github.com/iancoleman/strcase"
)

func generateEnums(root *os.Root, enumerations map[string][]parser.Enumeration) (err error) {
	for name, enum := range enumerations {
		err = writeEnumFile(root, name, enum)
	}
	return
}

//go:embed enumerated_types.tmpl
var enumTmplStr string
var enumTmpl *template.Template

func init() {
	var err error
	enumTmpl, err = template.New("enumerated_types").Parse(enumTmplStr)
	if err != nil {
		panic(err)
	}
}

func writeEnumFile(root *os.Root, identifier string, enum []parser.Enumeration) error {
	type Data struct {
		Type    string
		Enums   []parser.Enumeration
		Version string
		Date    string
	}
	data := Data{
		Type:  identifier,
		Enums: enum,
	}
	fileName := strcase.ToSnake(identifier)
	err := root.Remove(fileName + ".gleam")
	if err != nil {
		return fmt.Errorf("cannot remove %s: %w", fileName+".gleam", err)
	}
	file, err := root.OpenFile(fileName+".gleam", os.O_WRONLY|os.O_CREATE, 0644)
	if err != nil {
		return fmt.Errorf("failed to create file %s: %w", fileName+".gleam", err)
	}
	defer func() {
		if err := file.Close(); err != nil {
			slog.Error("error closing file", "filename", fileName+".gleam", "error", err)
		}
	}()

	err = enumTmpl.Execute(file, data)
	if err != nil {
		return fmt.Errorf("enum failed to create file for %s: %w", identifier, err)
	}
	return nil
}

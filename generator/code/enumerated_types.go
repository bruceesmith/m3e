package code

import (
	"fmt"
	"generator/parser"
	"os"
	"path/filepath"
	"text/template"

	"github.com/iancoleman/strcase"
)

func GenerateEnums(destination string, enumerations map[string][]parser.Enumeration, version string, date string) (err error) {
	for name, enum := range enumerations {
		err = writeEnumFile(destination, name, enum, version, date)
	}
	return
}

var enumTmpl *template.Template

func init() {
	var err error
	enumTmpl, err = template.ParseFiles("code/enumerated_types.tmpl")
	if err != nil {
		panic(err)
	}
}

func writeEnumFile(directory string, identifier string, enum []parser.Enumeration, version string, date string) error {
	type Data struct {
		Type    string
		Enums   []parser.Enumeration
		Version string
		Date    string
	}
	data := Data{
		Type:    identifier,
		Enums:   enum,
		Version: version,
		Date:    date,
	}
	fileName := strcase.ToSnake(identifier)
	file, err := os.Create(filepath.Join(directory, fileName+".gleam"))
	if err != nil {
		return fmt.Errorf("failed to create file %s: %w", fileName+".gleam", err)
	}
	defer file.Close()

	err = enumTmpl.Execute(file, data)
	if err != nil {
		return fmt.Errorf("enum failed to create file for %s: %w", identifier, err)
	}
	return nil
}

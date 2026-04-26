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

func writeEnumFile(directory string, identifier string, enums []parser.Enumeration, version string, date string) error {
	type Value struct {
		TypeName string
		Value    string
	}

	type EnumValue struct {
		Type    string
		Names   []Value
		Version string
		Date    string
	}
	enum := EnumValue{
		Type:    identifier,
		Names:   make([]Value, 0, len(enums)),
		Version: version,
		Date:    date,
	}
	for _, val := range enums {
		enum.Names = append(enum.Names, Value{TypeName: val.Name, Value: val.Attribute})
	}

	fileName := strcase.ToSnake(identifier)
	file, err := os.Create(filepath.Join(directory, fileName+".gleam"))
	if err != nil {
		return fmt.Errorf("failed to create file %s: %w", fileName+".gleam", err)
	}
	defer file.Close()

	err = enumTmpl.Execute(file, enum)
	if err != nil {
		return fmt.Errorf("enum failed to create file for %s: %w", identifier, err)
	}
	return nil
}

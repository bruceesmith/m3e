package code

import (
	"fmt"
	"generator/internal"
	"generator/parser"
	"strings"
	"text/template"

	"github.com/iancoleman/strcase"
)

var importTmpl *template.Template

func init() {
	var err error
	importTmpl, err = template.ParseFiles("code/imports.tmpl")
	if err != nil {
		panic(err)
	}
}

func imports(attrs []parser.RefinedAttribute) (builder *strings.Builder, names []string, err error) {
	builder = &strings.Builder{}
	names = make([]string, 0)

	imports := make([]string, 0, len(attrs))
	imports = append(imports, "lustre/attribute.{type Attribute}")
	imports = append(imports, "lustre/element.{type Element}")
	if len(attrs) > 0 {
		imports = append(imports, "gleam/list")
		imports = append(imports, "m3e/attr")
	}
	for _, attr := range attrs {
		for impModule, impType := range attr.Imports {
			switch {
			case strings.HasPrefix(impModule, "gleam/") || strings.HasPrefix(impModule, "lustre/") || strings.HasPrefix(impModule, "m3e/"):
				imports = append(imports, impModule+impType)
			default:
				imports = append(imports, "m3e/"+impModule+".{type "+strcase.ToCamel(impModule)+"}")
				if attr.Type != "NumberString" {
					names = append(names, impModule)
				}
			}
		}
	}
	imports = internal.Unique(imports)
	names = internal.Unique(names)

	data := map[string][]string{
		"imports": imports,
	}
	err = importTmpl.Execute(builder, data)
	if err != nil {
		return nil, nil, fmt.Errorf("imports failed to save result: %w", err)
	}
	return
}

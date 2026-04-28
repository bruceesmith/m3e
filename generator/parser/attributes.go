package parser

import (
	"fmt"
	"generator/cem"
	"regexp"
	"strings"

	"github.com/bruceesmith/logger"
	"github.com/iancoleman/strcase"
)

var (
	gleamStandardTypes = map[string]string{
		"boolean": "Bool",
		"number":  "Float",
		"string":  "String",
	}
	numericRe = regexp.MustCompile(`[\d\.]+`)
	optionRe  = regexp.MustCompile(`Option\(([a-zA-Z]+)\)`)
	typeRe    = regexp.MustCompile(`^(\w+)((?:\s+\| null)?(?:\s+\| undefined)?)$`)
	typeRe1   = regexp.MustCompile(`^(\w+) \| (\(.+\))$`)
)

// MakeAttributes converts the M3E manifest into an internal representation that is
// optimised for code and unit test generation.
//
// In addition to returning the internal representation, it also returns a list of enum
// type names that are referenced by the attributes.
func MakeAttributes(modName string, attrs []cem.Attribute) (refined []RefinedAttribute, enumNames []string) {
	refined = make([]RefinedAttribute, 0, len(attrs))
	for _, attr := range attrs {
		attribute := RefinedAttribute{
			Imports: make(map[string]string),
		}

		// Extract & standardise the variable tyoe of this Attribute
		var isOption bool
		if attr.Type == nil {
			attribute.Type = "String"
			attribute.Standard = true
		} else {
			attribute.Type, attribute.Standard, isOption = varType((*attr.Type).Text, attr.Default)
		}

		// Adjust the attribute properties based on its type and options
		enums := attribute.imports(isOption)
		attribute.name(attr.Name)
		attribute.description(attr.Description)
		attribute.type_()
		attribute.defawlt(attr.Default, modName)
		refined = append(refined, attribute)
		enumNames = append(enumNames, enums...)
	}
	return
}

// defawlt computes the default value for the attribute
func (attr *RefinedAttribute) defawlt(adef *string, modName string) {
	attr.DefaultName = "default_" + attr.Name
	if adef != nil {
		attr.Default = attr.computeDefault(*adef)
	} else {
		attr.Default = attr.nilDefault(modName)
	}

	attr.QualifiedDefault = attr.Default
	if attr.Enum != "" {
		attr.QualifiedDefault = strcase.ToSnake(modName) + "." + attr.Default
	}
}

// nilDefault handles the case where the manifest does not define a default value for the attribute
func (attr *RefinedAttribute) nilDefault(modName string) string {
	if attr.Type == "String" {
		return `""`
	} else {
		logger.TraceID("defs", fmt.Sprintf("%s in %s has no def", attr.Name, modName))
		// Provoke a Gleam compile error in this case
		return "invalid-default"
	}
}

// TransformFunc is a function that transforms an attribute based on its default value.
type TransformFunc func(attr *RefinedAttribute, def string) (string, bool)

// transformationRules is the set of transformation rules for defaults
var transformationRules = []TransformFunc{
	func(a *RefinedAttribute, d string) (string, bool) {
		return "IsNot" + a.Enum, a.Enum != ""
	},
	func(a *RefinedAttribute, d string) (string, bool) {
		matched, _ := regexp.Match(`^(\d+)$`, []byte(d))
		return d + ".0", a.Type == "Float" && matched
	},
	func(a *RefinedAttribute, d string) (string, bool) {
		return "None", strings.HasPrefix(a.Type, "Option(")
	},
	func(a *RefinedAttribute, d string) (string, bool) { return "True", d == "true" },
	func(a *RefinedAttribute, d string) (string, bool) {
		if a.Type == "Bool" {
			return "False", d == "false"
		}
		return `"false"`, d == "false"
	},
	func(a *RefinedAttribute, d string) (string, bool) {
		return "date.default", d == "new Date()"
	},
	func(a *RefinedAttribute, d string) (string, bool) { return `""`, strings.HasPrefix(d, "(") },
	func(a *RefinedAttribute, d string) (string, bool) {
		if a.Type == "IconWeight" {
			buf := make([]string, 0, 50)
			return "icon_weight." + MapDigits(d, buf), true
		}
		return "", false
	},
}

// computeDefault computes the default value for the attribute when the manifest
// defines a value for the attribute, but that default must be transformed to be
// suitable for Gleam
func (attr *RefinedAttribute) computeDefault(def string) string {
	for _, rule := range transformationRules {
		if val, ok := rule(attr, def); ok {
			return val
		}
	}

	if def == "" || def == "[]" {
		return def
	}
	if numericRe.MatchString(def) {
		if attr.Type == "NumberString" {
			if strings.Contains(def, ".") {
				return "number_string.NumberVal(" + def + ")"
			}
			return "number_string.NumberVal(" + def + ".0)"
		}
		return def
	}

	if strings.HasPrefix(def, `"`) && strings.HasSuffix(def, `"`) {
		if attr.Type == "String" {
			return def
		}
		return strcase.ToSnake(attr.Type) + "." + strcase.ToCamel(strings.Trim(def, `"`))
	}

	logger.TraceID("defs", fmt.Sprintf("unhandled: %s", def))
	return def
}

// description enures that long descriptions are converted to valid Gleam comments
func (attr *RefinedAttribute) description(desc *string) {
	if desc != nil {
		descr := *desc
		descr = strings.ReplaceAll(descr, "\n", "\n///     ")
		attr.Description = descr
	}
}

// imports returns the list of imports required by the attribute
func (attr *RefinedAttribute) imports(isOption bool) (names []string) {
	names = make([]string, 0, len(attr.Imports))
	if isOption {
		attr.Imports["gleam/option"] = ".{type Option, None}"
		if attr.Type == "Option(String)" {
			attr.Imports["gleam/function"] = ""
		}
	}
	if attr.Type == "Float" || attr.Type == "Option(Float)" {
		attr.Imports["gleam/float"] = ""
	}
	if !attr.Standard {
		matches := optionRe.FindStringSubmatch(attr.Type)
		if len(matches) == 2 {
			imp := strcase.ToSnake(matches[1])
			attr.Imports[imp] = ""
		} else {
			imp := strcase.ToSnake(attr.Type)
			attr.Imports[imp] = ""
		}
	}
	for k := range attr.Imports {
		switch {
		case strings.HasPrefix(k, "gleam/") || strings.HasPrefix(k, "lustre/") || strings.HasPrefix(k, "m3e/"):
		default:
			if attr.Type != "NumberString" {
				names = append(names, k)
			}
		}
	}
	return
}

// name adjusts the name of the attribute to be suitable for Gleam
func (attr *RefinedAttribute) name(n string) {
	if n == "type" {
		attr.Name = "type_"
	} else {
		attr.Name = strcase.ToSnake(n)
	}
}

// type_ handle boolean attributes (replacing a simple Bool by a Gleam
// semantic enumeration to avoid "boolean blindness") and avoids
// the built-in Gleam List type
func (attr *RefinedAttribute) type_() {
	if attr.Type == "Bool" {
		attr.Enum = strcase.ToCamel(attr.Name)
		attr.Type = attr.Enum
	}
	if attr.Type == "List" {
		// "List" is a standard type in Gleam, but we use "Mlist" to avoid conflicts
		attr.Type = "Mlist"
	}
}

// varType determines the Gleam type for the attribute
func varType(text string, adef *string) (string, bool, bool) {
	if t, isStd, ok := checkOverrides(text, adef); ok {
		return t, isStd, false
	}

	if tx, ok := strings.CutSuffix(text, "[]"); ok {
		return handleListType(tx)
	}

	if strings.HasPrefix(text, "(") {
		return "String", true, false
	}

	if t, isStd, isOpt, ok := handleRegexTypes(text, adef); ok {
		return t, isStd, isOpt
	}

	logger.Debug("varType: unknown type: %s", text)
	return text, false, false
}

// checkOverrides handles certain cases where the manifest type must be changed
func checkOverrides(text string, adef *string) (string, bool, bool) {
	if text == `number | "all"` {
		return "NumberString", false, true
	}
	if text == "LinkTarget" && adef != nil && *adef == `""` {
		t, isStd, isOpt := formatGleamType(text, false, true)
		return t, isStd, isOpt
	}
	return "", false, false
}

// handleListType handles list types, replacing them with Gleam's List type
func handleListType(tx string) (string, bool, bool) {
	t, isStd := toGleamStandardType(tx)
	if isStd {
		return "List(" + t + ")", true, false
	}
	return "List(" + strcase.ToSnake(tx) + "." + tx + ")", false, false
}

// handleRegexTypes handles more complex manifest types
func handleRegexTypes(text string, adef *string) (string, bool, bool, bool) {
	if matches := typeRe.FindStringSubmatch(text); len(matches) == 3 {
		isOption := matches[2] != ""
		t, isStd := toGleamStandardType(matches[1])

		if !isStd && isOption && adef != nil && *adef != `""` && *adef != "null" && *adef != "undefined" {
			isOption = false
		}
		t, isStd, isOpt := formatGleamType(t, isStd, isOption)
		return t, isStd, isOpt, true
	}

	if matches1 := typeRe1.FindStringSubmatch(text); len(matches1) == 3 {
		t, isStd := toGleamStandardType(matches1[1])
		return t, isStd, false, true
	}

	return "", false, false, false
}

// formatGleamType wraps a type in Gleam's Option as required
func formatGleamType(t string, isStd, isOption bool) (string, bool, bool) {
	if isOption {
		return "Option(" + t + ")", isStd, true
	}
	return t, isStd, false
}

// toGleamStandardType maps manifest types to Gleam's standard types
func toGleamStandardType(text string) (string, bool) {
	if s, ok := gleamStandardTypes[text]; ok {
		return s, true
	}
	return text, false
}

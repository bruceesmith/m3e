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
	integerRe = regexp.MustCompile(`^(\d+)$`)
	numericRe = regexp.MustCompile(`[\d\.]+`)
	optionRe  = regexp.MustCompile(`Option\(([a-zA-Z]+)\)`)
	typeRe    = regexp.MustCompile(`^(\w+)((?:\s+\| null)?(?:\s+\| undefined)?)$`)
	typeRe1   = regexp.MustCompile(`^(\w+) \| (\(.+\))$`)
)

func MakeAttributes(modName string, attrs []cem.Attribute) (refined []RefinedAttribute, enumNames []string) {
	refined = make([]RefinedAttribute, 0, len(attrs))
	for _, attr := range attrs {
		attribute := RefinedAttribute{
			Imports: make(map[string]string),
			ModName: modName,
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
		attribute.defawlt(attr.Default)

		refined = append(refined, attribute)
		enumNames = append(enumNames, enums...)
	}
	return
}

func (attr *RefinedAttribute) defawlt(adef *string) {
	if adef != nil {
		attr.Default = attr.computeDefault(*adef)
	} else {
		attr.nilDefault()
	}
}

func (attr *RefinedAttribute) nilDefault() {
	if attr.Type == "String" {
		attr.Default = `""`
	} else {
		logger.TraceID("defs", fmt.Sprintf("%s in %s has no def", attr.Name, attr.ModName))
	}
}

type TransformFunc func(attr *RefinedAttribute, def string) (string, string, bool)

var transformationRules = []TransformFunc{
	func(a *RefinedAttribute, d string) (string, string, bool) {
		return "IsNot" + a.Enum, strcase.ToSnake(a.ModName), a.Enum != ""
	},
	func(a *RefinedAttribute, d string) (string, string, bool) {
		matched, _ := regexp.Match(`^(\d+)$`, []byte(d))
		return d + ".0", "", a.Type == "Float" && matched
	},
	func(a *RefinedAttribute, d string) (string, string, bool) {
		return "None", "", strings.HasPrefix(a.Type, "Option(")
	},
	func(a *RefinedAttribute, d string) (string, string, bool) { return "True", "", d == "true" },
	func(a *RefinedAttribute, d string) (string, string, bool) {
		if a.Type == "Bool" {
			return "False", "", d == "false"
		}
		return `"false"`, "", d == "false"
	},
	func(a *RefinedAttribute, d string) (string, string, bool) {
		return "date.default", "", d == "new Date()"
	},
	func(a *RefinedAttribute, d string) (string, string, bool) { return `""`, "", strings.HasPrefix(d, "(") },
	func(a *RefinedAttribute, d string) (string, string, bool) {
		if a.Type == "IconWeight" {
			buf := make([]string, 0, 50)
			return "icon_weight." + MapDigits(d, buf), "", true
		}
		return "", "", false
	},
}

func (attr *RefinedAttribute) computeDefault(def string) string {
	// 1. Check dynamic rules
	for _, rule := range transformationRules {
		if val, mod, ok := rule(attr, def); ok {
			if mod != "" {
				attr.QualifiedDefault = mod + "." + val
			}
			return val
		}
	}

	// 2. Check static/regex pass-throughs
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

	// 3. Handle complex strings
	if strings.HasPrefix(def, `"`) && strings.HasSuffix(def, `"`) {
		if attr.Type == "String" {
			return def
		}
		return strcase.ToSnake(attr.Type) + "." + strcase.ToCamel(strings.Trim(def, `"`))
	}

	// 4. Fallback
	logger.TraceID("defs", fmt.Sprintf("unhandled: %s", def))
	return def
}

func (attr *RefinedAttribute) description(desc *string) {
	if desc != nil {
		descr := *desc
		descr = strings.ReplaceAll(descr, "\n", "\n///     ")
		attr.Description = descr
	}
}

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

func (attr *RefinedAttribute) name(n string) {
	if n == "type" {
		attr.Name = "type_"
	} else {
		attr.Name = strcase.ToSnake(n)
	}
}

func (attr *RefinedAttribute) type_() {
	if attr.Type == "Bool" {
		attr.Enum = strcase.ToCamel(attr.Name)
		attr.Type = attr.Enum
	}
	if attr.Type == "List" {
		// "List" is a standard type in Gleam, but we use "MList" to avoid conflicts
		attr.Type = "MList"
	}
}

func varType(text string, adef *string) (type_ string, isStd bool, isOption bool) {
	// 1. Check for standard overrides (e.g., number | "all")
	if text == `number | "all"` {
		return "NumberString", false, false
	}
	if text == "LinkTarget" && adef != nil && *adef == `""` {
		return formatGleamType(text, false, true)
	}

	// 2. Handle Lists "[]"
	if tx, ok := strings.CutSuffix(text, "[]"); ok {
		t, isStd := toGleamStandardType(tx)
		if isStd {
			return "List(" + t + ")", true, false
		}
		return "List(" + strcase.ToSnake(tx) + "." + tx + ")", false, false
	}

	// 3. Handle specific pattern prefixes
	if strings.HasPrefix(text, "(") {
		return "String", true, false
	}

	// 4. Handle Regex patterns (Type | null/undefined or Type | (expr))
	if matches := typeRe.FindStringSubmatch(text); len(matches) == 3 {
		isOption := matches[2] != ""
		t, isStd := toGleamStandardType(matches[1])

		// If not standard, check if the presence of a default value forces it to NOT be an Option
		if !isStd && isOption && adef != nil && *adef != `""` && *adef != "null" && *adef != "undefined" {
			isOption = false
		}
		return formatGleamType(t, isStd, isOption)
	}

	if matches1 := typeRe1.FindStringSubmatch(text); len(matches1) == 3 {
		t, isStd := toGleamStandardType(matches1[1])
		return t, isStd, false
	}

	// 5. Fallback
	logger.Debug("varType: unknown type: %s", text)
	return text, false, false
}

// Helper to encapsulate formatting
func formatGleamType(t string, isStd, isOption bool) (string, bool, bool) {
	if isOption {
		return "Option(" + t + ")", isStd, true
	}
	return t, isStd, false
}
func toGleamStandardType(text string) (string, bool) {
	if s, ok := gleamStandardTypes[text]; ok {
		return s, true
	}
	return text, false
}

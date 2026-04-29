package parser

import (
	"fmt"
	"generator/cem"
	"generator/internal"
	"maps"
	"regexp"
	"strings"

	"github.com/bruceesmith/logger"
	"github.com/iancoleman/strcase"
)

// Attribute is an internal representation of a cem Attribute
type Attribute struct {
	// snake_case name of the attribute
	Name string
	// CamelCase name of the enum type, if applicable
	Enum string
	// Human-readable description of the attribute
	Description string
	// Gleam version of the TS default value
	Default string
	// Name of the default value, if applicable
	DefaultName string
	// Default value prefixed by the module name, used in test generation
	// Only used for semantic booleans in the same module
	QualifiedDefault string
	// CamelCase type name
	Type string
	// Is this a Gleam built-in attribute, e.g. Bool, Float...
	Standard bool
	// Is this a Gleam Option(*) attribute?
	Option bool
}

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
func MakeAttributes(modName string, attrs []cem.Attribute) (
	refined []Attribute,
	moduleImports map[string]string,
	externalModules []string) {

	refined = make([]Attribute, 0, len(attrs))
	moduleImports = make(map[string]string)

	for _, attr := range attrs {
		attribute := Attribute{Name: attr.Name}

		// Extract & standardise the variable tyoe of this Attribute
		if attr.Type == nil {
			attribute.Type = "String"
			attribute.Standard = true
		} else {
			attribute.varType(attr.Type.Text, attr.Default)
		}

		// Adjust the attribute properties based on its type and options
		var (
			attrImports    = make(map[string]string)
			externalModule string
		)
		attrImports, externalModule = attribute.imports()
		maps.Copy(moduleImports, attrImports)
		if externalModule != "" {
			externalModules = append(externalModules, externalModule)
		}
		attribute.name(attr.Name)
		attribute.description(attr.Description)
		attribute.defawlt(attr.Default, modName)
		refined = append(refined, attribute)
	}
	externalModules = internal.Unique(externalModules)
	return
}

// -----------------------------------------------------------
// --- Default, DefaultName, QualifiedDefault handling -------
// -----------------------------------------------------------

// defawlt computes the default values for the attribute
func (attr *Attribute) defawlt(adef *string, modName string) {
	attr.DefaultName = "default_" + attr.Name
	if adef != nil {
		attr.Default = attr.computeDefault(*adef)
	} else {
		attr.nilDefault(modName)
	}
	attr.qualifiedDefault(modName)
}

// defaultTransformFunc is a function that transforms an attribute based on its default value.
type defaultTransformFunc func(attr *Attribute, def string) (string, bool)

// defaultTransformRules is the set of transformation rules for defaults
var defaultTransformRules = []defaultTransformFunc{
	func(a *Attribute, d string) (string, bool) {
		return "IsNot" + a.Enum, a.Enum != ""
	},
	func(a *Attribute, d string) (string, bool) {
		matched, _ := regexp.Match(`^(\d+)$`, []byte(d))
		return d + ".0", a.Type == "Float" && matched
	},
	func(a *Attribute, d string) (string, bool) {
		return "None", strings.HasPrefix(a.Type, "Option(")
	},
	func(a *Attribute, d string) (string, bool) { return "True", d == "true" },
	func(a *Attribute, d string) (string, bool) {
		if a.Type == "Bool" {
			return "False", d == "false"
		}
		return `"false"`, d == "false"
	},
	func(a *Attribute, d string) (string, bool) {
		return "date.default", d == "new Date()"
	},
	func(a *Attribute, d string) (string, bool) { return `""`, strings.HasPrefix(d, "(") },
	func(a *Attribute, d string) (string, bool) {
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
func (attr *Attribute) computeDefault(def string) string {
	for _, rule := range defaultTransformRules {
		if val, ok := rule(attr, def); ok {
			return val
		}
	}

	if def == "" || def == "[]" {
		return def
	}
	if numericRe.MatchString(def) {
		if attr.Type == "number_string.NumberString" {
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

// nilDefault handles the case where the manifest does not define a default value for the attribute
func (attr *Attribute) nilDefault(modName string) {
	if attr.Type == "String" {
		attr.Default = `""`
	} else {
		logger.TraceID("defs", fmt.Sprintf("%s in %s has no def", attr.Name, modName))
		// Provoke a Gleam compile error in this case
		attr.Default = "invalid-default"
	}
}

// qualifiedDefault creates the possibly qualified default for use in tests
func (attr *Attribute) qualifiedDefault(modName string) {
	attr.QualifiedDefault = attr.Default
	if attr.Enum != "" {
		attr.QualifiedDefault = strcase.ToSnake(modName) + "." + attr.Default
	}
}

// -----------------------------------------------------------
// --- Description, Imports, Name handling ---
// -----------------------------------------------------------

// description enures that long descriptions are converted to valid Gleam comments
func (attr *Attribute) description(desc *string) {
	if desc != nil {
		descr := *desc
		descr = strings.ReplaceAll(descr, "\n", "\n///     ")
		attr.Description = descr
	}
}

// imports returns the list of imports required by the attribute
func (attr *Attribute) imports() (importStrings map[string]string, importedModule string) {
	importStrings = make(map[string]string)
	if attr.Option {
		importStrings["gleam/option"] = ".{type Option, None}"
		if attr.Type == "Option(String)" {
			importStrings["gleam/function"] = ""
		}
	}
	if attr.Type == "Float" || attr.Type == "Option(Float)" {
		importStrings["gleam/float"] = ""
	}
	if attr.Type == "number_string.NumberString" {
		importStrings["m3e/number_string"] = ""
	}
	if !attr.Standard && attr.Type != "number_string.NumberString" && attr.Enum == "" {
		matches := optionRe.FindStringSubmatch(attr.Type)
		if len(matches) == 2 {
			// example: Option(BadgePosition) - an optional externally defined type
			importStrings["m3e/"+strcase.ToSnake(matches[1])] = ".{type " + matches[1] + "}"
			importedModule = strcase.ToSnake(matches[1])
		} else {
			// example: AppBarSize - an externally defined type
			importStrings["m3e/"+strcase.ToSnake(attr.Type)] = ".{type " + attr.Type + "}"
			importedModule = strcase.ToSnake(attr.Type)
		}
	}
	return
}

// name adjusts the name of the attribute to be suitable for Gleam
func (attr *Attribute) name(n string) {
	if n == "type" {
		attr.Name = "type_"
	} else {
		attr.Name = strcase.ToSnake(n)
	}
}

// -----------------------------------------------------------
// --- Type, Standard, Option handling ---
// -----------------------------------------------------------

// boolean handle boolean attributes (replacing a simple Bool by a Gleam
// semantic enumeration to avoid "boolean blindness")
func (attr *Attribute) boolean(text string) (matched bool) {
	if text == "boolean" {
		attr.Enum = strcase.ToCamel(attr.Name)
		attr.Type = attr.Enum
		return true
	}
	return false
}

func (attr *Attribute) function(text string) (matched bool) {
	if strings.HasPrefix(text, "(") {
		attr.Type = "String"
		attr.Standard = true
		attr.Option = false
		return true
	}
	return false
}

func (attr *Attribute) linkTarget(text string, adef *string) (matched bool) {
	if text == "LinkTarget" && adef != nil && *adef == `""` {
		attr.Type = "Option(" + text + ")"
		attr.Standard = false
		attr.Option = true
		return true
	}
	return false
}

// list avoids the built-in Gleam List type
func (attr *Attribute) list() (matched bool) {
	if attr.Type == "List" {
		// "List" is a standard type in Gleam, but we use "Mlist" to avoid conflicts
		attr.Type = "Mlist"
		return true
	}
	return false
}

// listOf handles list types, replacing them with Gleam's List type
func (attr *Attribute) listOf(text string) (matched bool) {
	tx, ok := strings.CutSuffix(text, "[]")
	if !ok {
		return false
	}
	var type_ string
	type_, attr.Standard = attr.toGleamStandardType(tx)
	if attr.Standard {
		attr.Type = "List(" + type_ + ")"
	} else {
		attr.Type = "List(" + strcase.ToSnake(tx) + "." + tx + ")"
	}
	return true
}

// nullOrUndefined checks if the type in the manifest matches `something | null | undefined'
func (attr *Attribute) nullOrUndefined(text string, adef *string) (matched bool) {
	if matches := typeRe.FindStringSubmatch(text); len(matches) == 3 {
		attr.Option = matches[2] != ""
		attr.Type, attr.Standard = attr.toGleamStandardType(matches[1])

		if !attr.Standard && attr.Option && adef != nil && *adef != `""` && *adef != "null" && *adef != "undefined" {
			attr.Option = false
		}
		if attr.Option {
			attr.Type = "Option(" + attr.Type + ")"
		}
		return true
	}
	return false
}

func (attr *Attribute) number(text string) (matched bool) {
	if text == `number | "all"` {
		attr.Type = "number_string.NumberString"
		attr.Standard = false
		attr.Option = false
		return true
	}
	return false
}

type typeTransformFunction func(attr *Attribute, text string, adef *string) bool

var typeTransformRules = []typeTransformFunction{
	func(attr *Attribute, text string, _ *string) bool { return attr.boolean(text) },
	func(attr *Attribute, text string, _ *string) bool { return attr.function(text) },
	func(attr *Attribute, text string, adef *string) bool { return attr.linkTarget(text, adef) },
	func(attr *Attribute, _ string, _ *string) bool { return attr.list() },
	func(attr *Attribute, text string, _ *string) bool { return attr.listOf(text) },
	func(attr *Attribute, text string, adef *string) bool { return attr.nullOrUndefined(text, adef) },
	func(attr *Attribute, text string, _ *string) bool { return attr.number(text) },
	func(attr *Attribute, text string, adef *string) bool { return attr.handleRegexTypes(text, adef) },
}

// varType determines if the Gleam type for the attribute must be
// different to the value of the Type.Text field in the manifest
func (attr *Attribute) varType(text string, adef *string) {
	for _, rule := range typeTransformRules {
		matched := rule(attr, text, adef)
		if matched {
			return
		}
	}

	// No rule matched, so assume the type in the manifest can be translated
	// directly to a Gleam Type
	attr.Type = text
	attr.Standard = false
	attr.Option = false
}

// handleRegexTypes handles more complex manifest types
func (attr *Attribute) handleRegexTypes(text string, adef *string) (matched bool) {

	// Does the type in the manifest match 'something | somethingelse'
	if matches1 := typeRe1.FindStringSubmatch(text); len(matches1) == 3 {
		attr.Type, attr.Standard = attr.toGleamStandardType(matches1[1])
		return true
	}

	return false
}

// toGleamStandardType maps manifest types to Gleam's standard types
func (attr *Attribute) toGleamStandardType(text string) (tipe string, isStd bool) {
	if s, ok := gleamStandardTypes[text]; ok {
		return s, true
	}
	return text, false
}

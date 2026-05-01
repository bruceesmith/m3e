package parser

import (
	"fmt"
	"generator/cem"
	"generator/internal"
	"maps"
	"regexp"
	"strings"
	"unicode"

	"github.com/bruceesmith/logger"
	"github.com/bruceesmith/set"
	"github.com/iancoleman/strcase"
)

// Test represents each of the pieces of data required to generate unit tests
type Test struct {
	// Attribute string value for use in setter tests.
	AttributeValue string
	// Value used in setter unit tests. This must be different than
	// the default value. It needs to be qualified if the value comes
	// from an external module.
	Value string
}

type Property = uint8

const (
	External Property = iota
	List
	Optional
	SemanticBoolean
	Standard
)

// Attribute is an internal representation of a cem Attribute
type Attribute struct {
	// snake_case name of the attribute
	Name string
	// CamelCase name of the semantic boolean type, if applicable
	SemBool string
	// Human-readable description of the attribute
	Description string
	// Gleam version of the TS default value
	Default string
	// Name of the default value, if applicable
	DefaultName string
	// Default value prefixed by the module name for semantic booleans, used
	// in test generation. When the attribute is not a semantic boolean, this
	// field is populated with the (unqualified) Default value
	QualifiedDefault string
	// Unit test data
	Test Test
	// CamelCase type name
	Type string
	// Properties of an Attribute
	Properties *set.Set[Property]
}

var (
	commonImports = map[string]string{
		"lustre/attribute": ".{type Attribute}",
		"lustre/element":   ".{type Element}",
	}
	commonTestImports = map[string]string{
		"gleam/list":          "",
		"gleeunit/should":     "",
		"lustre/attribute":    "",
		"lustre/element":      "",
		"lustre/element/html": "",
	}
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
	testModuleImports map[string]string,
	externalModules []string) {

	refined = make([]Attribute, 0, len(attrs))
	moduleImports = make(map[string]string, len(commonImports)+10)
	maps.Copy(moduleImports, commonImports)
	testModuleImports = make(map[string]string, len(commonTestImports)+10)
	maps.Copy(testModuleImports, commonTestImports)

	for _, attr := range attrs {
		attribute := Attribute{Name: attr.Name, Properties: set.New[Property]()}

		// Extract & standardise the variable tyoe of this Attribute
		if attr.Type == nil {
			attribute.Type = "String"
			attribute.Properties.Add(Standard)
		} else {
			attribute.varType(attr.Type.Text, attr.Default)
		}

		// Adjust the attribute properties based on its type and options
		var (
			attrImports     = make(map[string]string)
			externalModule  string
			testAttrImports = make(map[string]string)
		)
		attrImports, testAttrImports, externalModule = attribute.imports()
		maps.Copy(moduleImports, attrImports)
		maps.Copy(testModuleImports, testAttrImports)
		if externalModule != "" {
			externalModules = append(externalModules, externalModule)
		}
		attribute.name(attr.Name)
		attribute.description(attr.Description)
		attribute.defawlt(attr.Default, modName)
		attribute.testValues(modName)
		refined = append(refined, attribute)
	}

	switch {
	case len(refined) == 0:
		testModuleImports["m3e/"+strcase.ToSnake(modName)] = ""
	case len(refined) == 1:
		moduleImports["gleam/list"] = ""
		moduleImports["m3e/attr"] = ""
		testModuleImports["m3e/"+strcase.ToSnake(modName)] = ""
	default:
		moduleImports["gleam/list"] = ""
		moduleImports["m3e/attr"] = ""
		testModuleImports["m3e/"+strcase.ToSnake(modName)] = ".{Config}"
	}

	externalModules = internal.Unique(externalModules)
	return
}

// -----------------------------------------------------------
// --- Default, DefaultName, QualifiedDefault, TestValue handling -------
// -----------------------------------------------------------

// defawlt computes the default values for the attribute
func (attr *Attribute) defawlt(adef *string, modName string) {
	attr.DefaultName = "default_" + attr.Name
	if adef != nil {
		attr.Default = attr.computeDefault(*adef)
	} else {
		attr.nilDefault(modName)
	}
	// Always must set a sensible default for test case generation of semantic booleans
	attr.qualifiedDefault(modName)
}

// defaultTransformFunc is a function that transforms an attribute based on its default value.
type defaultTransformFunc func(attr *Attribute, def string) (string, bool)

// defaultTransformRules is the set of transformation rules for defaults
var defaultTransformRules = []defaultTransformFunc{
	func(a *Attribute, d string) (string, bool) {
		return "IsNot" + a.SemBool, a.IsSemBool()
	},
	func(a *Attribute, d string) (string, bool) {
		if a.Type == "Float" {
			if strings.Contains(d, ".") {
				return d, true
			}
			return d + ".0", true
		}
		return d, false
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
		if a.Type == "number_string.NumberString" {
			if strings.Contains(d, ".") {
				return "number_string.NumberVal(" + d + ")", true
			}
			return "number_string.NumberVal(" + d + ".0)", true
		}
		return d, false
	},
	func(a *Attribute, d string) (string, bool) {
		if a.Type != "Float" && unicode.IsDigit(rune(d[0])) {
			buf := make([]string, 0, 50)
			return strcase.ToSnake(a.Type) + "." + MapDigits(d, buf), true
		}
		return d, false
	},
	func(a *Attribute, d string) (string, bool) {
		return d, d == "" || d == "[]"
	},
	func(a *Attribute, d string) (string, bool) {
		if strings.HasPrefix(d, `"`) && strings.HasSuffix(d, `"`) {
			if a.Type == "String" {
				return d, true
			}
			return strcase.ToSnake(a.Type) + "." + strcase.ToCamel(strings.Trim(d, `"`)), true
		}
		return d, false
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

	logger.Warn(fmt.Sprintf("unhandled default %s for %s of type %s", def, attr.Name, attr.Type))
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
	if attr.IsSemBool() {
		attr.QualifiedDefault = strcase.ToSnake(modName) + "." + attr.Default
	}
}

// testValues sets the TestValue field
func (attr *Attribute) testValues(modName string) {
	switch {
	case attr.Type == "Date":
		attr.Test = Test{
			Value:          `date.today_utc()`,
			AttributeValue: `date.to_string(date.today_utc())`,
		}
	case attr.Type == "Float":
		attr.Test = Test{
			Value:          `42.0`,
			AttributeValue: `"42.0"`,
		}
	case attr.Type == "List(String)":
		attr.Test = Test{
			Value:          `["test1", "test2"]`,
			AttributeValue: `"test1, test2"`,
		}
	case attr.Type == "number_string.NumberString":
		attr.Test = Test{
			Value:          `number_string.StringVal("10")`,
			AttributeValue: `"10"`,
		}
	case attr.Type == "Option(Date)":
		attr.Test = Test{
			Value:          `Some(date.today_utc())`,
			AttributeValue: `date.to_string(date.today_utc())`,
		}
	case attr.Type == "Option(ElevationLevel)":
		attr.Test = Test{
			Value:          `Some(elevation_level.Two)`,
			AttributeValue: `"2"`,
		}
	case attr.Type == "Option(Float)":
		attr.Test = Test{
			Value:          `Some(42.0)`,
			AttributeValue: `"42.0"`,
		}
	case attr.Type == "Option(HeadingLevel)":
		attr.Test = Test{
			Value:          `Some(heading_level.Three)`,
			AttributeValue: `"3"`,
		}
	case attr.Type == "Option(LinkTarget)":
		attr.Test = Test{
			Value:          `Some(link_target.Self)`,
			AttributeValue: `"_self"`,
		}
	case attr.Type == "Option(ShapeName)":
		attr.Test = Test{
			Value:          `Some(shape_name.FourLeafClover)`,
			AttributeValue: `"4-leaf-clover"`,
		}
	case attr.Type == "Option(String)":
		attr.Test = Test{
			Value:          `Some("test")`,
			AttributeValue: `"test"`,
		}
	case attr.IsOptional():
		logger.TraceID("testvalue", "missing test value setting for "+attr.Type)
		attr.Test = Test{
			Value:          `"None"`,
			AttributeValue: `"nothing"`,
		}
	case attr.Type == "String":
		attr.Test = Test{
			Value:          `"test"`,
			AttributeValue: `"test"`,
		}
	case attr.IsSemBool():
		attr.Test = Test{
			Value:          strcase.ToSnake(modName) + "." + "Is" + attr.SemBool,
			AttributeValue: `""`,
		}
	default:
		logger.TraceID("testvalue", "no way to set a test value for type "+attr.Type)
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
func (attr *Attribute) imports() (importStrings map[string]string, testImportStrings map[string]string, importedModule string) {
	importStrings = make(map[string]string)
	testImportStrings = make(map[string]string)
	if attr.IsOptional() {
		importStrings["gleam/option"] = ".{type Option, None}"
		if attr.Type == "Option(String)" {
			importStrings["gleam/function"] = ""
		}
		testImportStrings["gleam/option"] = ".{None, Some}"
	}
	if attr.Type == "Float" || attr.Type == "Option(Float)" {
		importStrings["gleam/float"] = ""
	}
	if attr.Type == "number_string.NumberString" {
		importStrings["m3e/number_string"] = ""
		testImportStrings["m3e/number_string"] = ""
	}
	if !attr.IsStandard() && attr.Type != "number_string.NumberString" && !attr.IsSemBool() {
		matches := optionRe.FindStringSubmatch(attr.Type)
		if len(matches) == 2 {
			// example: Option(BadgePosition) - an optional externally defined type
			importStrings["m3e/"+strcase.ToSnake(matches[1])] = ".{type " + matches[1] + "}"
			importedModule = strcase.ToSnake(matches[1])
			testImportStrings["m3e/"+strcase.ToSnake(matches[1])] = ""
		} else {
			// example: AppBarSize - an externally defined type
			importStrings["m3e/"+strcase.ToSnake(attr.Type)] = ".{type " + attr.Type + "}"
			importedModule = strcase.ToSnake(attr.Type)
			testImportStrings["m3e/"+strcase.ToSnake(attr.Type)] = ""
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

// boolean handles boolean attributes (replacing a simple Bool by a Gleam
// semantic boolean to avoid "boolean blindness")
func (attr *Attribute) boolean(text string) (matched bool) {
	if text == "boolean" {
		attr.SemBool = strcase.ToCamel(attr.Name)
		attr.Type = attr.SemBool
		attr.Properties.Add(SemanticBoolean)
		return true
	}
	return false
}

func (attr *Attribute) function(text string) (matched bool) {
	if strings.HasPrefix(text, "(") {
		attr.Type = "String"
		attr.Properties.Add(Standard)
		attr.Properties.Delete(Optional)
		return true
	}
	return false
}

func (attr *Attribute) linkTarget(text string, adef *string) (matched bool) {
	if text == "LinkTarget" && adef != nil && *adef == `""` {
		attr.Type = "Option(" + text + ")"
		attr.Properties.Delete(Standard)
		attr.Properties.Add(Optional)
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
	attr.toGleamStandardType(tx)
	if attr.IsStandard() {
		attr.Type = "List(" + attr.Type + ")"
	} else {
		attr.Type = "List(" + strcase.ToSnake(tx) + "." + tx + ")"
	}
	attr.Properties.Add(List)
	return true
}

// nullOrUndefined checks if the type in the manifest matches `something | null | undefined'
func (attr *Attribute) nullOrUndefined(text string, adef *string) (matched bool) {
	if matches := typeRe.FindStringSubmatch(text); len(matches) == 3 {
		if matches[2] != "" {
			attr.Properties.Add(Optional)
		}
		attr.toGleamStandardType(matches[1])
		if !attr.IsStandard() && attr.IsOptional() && adef != nil && *adef != `""` && *adef != "null" && *adef != "undefined" {
			attr.Properties.Delete(Optional)
		}
		if attr.IsOptional() {
			attr.Type = "Option(" + attr.Type + ")"
		}
		return true
	}
	return false
}

func (attr *Attribute) number(text string) (matched bool) {
	if text == `number | "all"` {
		attr.Type = "number_string.NumberString"
		attr.Properties.Delete(Standard)
		attr.Properties.Delete(Optional)
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
	attr.Properties.Delete(Standard)
	attr.Properties.Delete(Optional)
}

// handleRegexTypes handles more complex manifest types
func (attr *Attribute) handleRegexTypes(text string, adef *string) (matched bool) {

	// Does the type in the manifest match 'something | somethingelse'
	if matches1 := typeRe1.FindStringSubmatch(text); len(matches1) == 3 {
		attr.toGleamStandardType(matches1[1])
		return true
	}

	return false
}

// toGleamStandardType maps manifest types to Gleam's standard types
func (attr *Attribute) toGleamStandardType(text string) {
	if s, ok := gleamStandardTypes[text]; ok {
		attr.Properties.Add(Standard)
		attr.Type = s
	} else {
		attr.Properties.Delete(Standard)
		attr.Type = text
	}
}

// -----------------------------------------------------------
// --- Predicates to examine an Attribute -------
// -----------------------------------------------------------

// IsOptional returns true if the Attribute's type is Option(something)
func (attr *Attribute) IsOptional() bool {
	return attr.Properties.Contains(Optional)
}

// IsSemBool returns true if the Attribute is a semantic boolean
func (attr *Attribute) IsSemBool() bool {
	return attr.Properties.Contains(SemanticBoolean)
}

// IsStandard returns true if the Attribute's type is one of the Gleam intrinsic types
func (attr *Attribute) IsStandard() bool {
	return attr.Properties.Contains(Standard)
}

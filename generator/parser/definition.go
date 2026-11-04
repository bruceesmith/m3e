package parser

import (
	"fmt"
	"generator/cem"
	"generator/internal"
	"log/slog"
	"os"
	"strings"

	"github.com/bruceesmith/logger"
	"github.com/iancoleman/strcase"
)

// Definition is the internal representation of the entire CEM manifest for
// the Material 3 Expression components
type Definition struct {
	// Key is the CamelCase name of the module
	Modules map[string]Module
	// Key is the Camelcase name of the external enumeration type
	Enumerations map[string][]Enumeration
}

// enumerations tracks down each TypeScript module which defines an externally declared type
// and extract the enumerated values for it.
// The input enumerations are snake_case
func (d *Definition) enumerations(m3eSource string, enumerations map[string]struct{}) (err error) {
	d.Enumerations = make(map[string][]Enumeration, len(enumerations))

	buf := make([]string, 0, 50)
	typeBuf := make([]tsTypeDef, 0, maxEnumTypeDefs)
	root, err := os.OpenRoot(m3eSource)
	if err != nil {
		return fmt.Errorf("failed to open m3eSource %s: %w", m3eSource, err)
	}
	defer func() {
		if err := root.Close(); err != nil {
			slog.Error("failed to close m3eSource folder", "folder", m3eSource, "error", err)
		}
	}()

	var deferred = make(map[string][]string)

	// Extract the external declaration of each TypeScript union type
	for enum := range enumerations {
		types, err := d.getTSTypes(root, enum, typeBuf)
		if err != nil {
			return fmt.Errorf("failed to parse enumeration declaration file for %s: %w", enum, err)
		}
		for _, tipe := range types {
			if len(tipe.Values) == 0 {
				continue
			}
			def := make([]Enumeration, 0, len(tipe.Values))
			if tipe.Deferred != nil {
				for _, v := range tipe.Deferred {
					_, ok := deferred[v]
					if !ok {
						deferred[v] = []string{tipe.Name}
					} else {
						deferred[v] = append(deferred[v], tipe.Name)
					}
				}
			}
			for _, value := range tipe.Values {
				value = strings.Trim(value, `"`)
				name := internal.MapDigits(strcase.ToCamel(value), buf)
				def = append(def, Enumeration{
					Name:      name,
					Attribute: value,
				})
			}
			d.Enumerations[tipe.Name] = def
		}
	}

	// Some union types embed others, for example:
	// 		export type SwipeRevealDismiss = SwipeRevealSide | "both" | "none";
	// At this point the definition of the embedded union may or may not be known. If not
	// then try to discover it now. Once discovered, update the enumerations which embedded the union
	for name, embedees := range deferred {
		knownEnum, ok := d.Enumerations[name]
		if ok {
			/// The embedded union has already been discovered (it was used standalone in the TypeScript code)
			for _, embedee := range embedees {
				_, ok := d.Enumerations[embedee]
				if !ok {
					continue
				}
				d.Enumerations[embedee] = append(d.Enumerations[embedee], knownEnum...)
			}
			continue
		}
		// } else {
		/// We must discover the embedded union (it apparently is only referenced by embedding inside other unions)
		types, err := d.getTSTypes(root, name, typeBuf)
		if err != nil {
			slog.Warn("failed to parse enumeration declaration file", "enum", name, "error", err)
		}
		for _, tipe := range types {
			if len(tipe.Values) == 0 {
				continue
			}
			def := make([]Enumeration, 0, len(tipe.Values))
			if tipe.Deferred != nil {
				// TODO - handle the recursive case where a previously undiscovered union type itself
				// embeds another also-undiscovered union type
			}
			for _, value := range tipe.Values {
				value = strings.Trim(value, `"`)
				name := internal.MapDigits(strcase.ToCamel(value), buf)
				def = append(def, Enumeration{
					Name:      name,
					Attribute: value,
				})
			}
			// Include this union type in the known enumerations
			d.Enumerations[tipe.Name] = def
			// Add this union types values to the other union types which embed it
			for _, embedee := range embedees {
				d.Enumerations[embedee] = append(d.Enumerations[embedee], def...)
			}

			// }
		}
	}
	return
}

// module extracts the module name, attributes and slots from a single module declaration
func (d *Definition) module(declaration cem.JavaScriptModuleDeclarationsElem) (externalModules []string) {
	name := strings.TrimSuffix(strings.TrimPrefix(declaration.Name, "M3e"), "Element")
	if name == "List" {
		name = "Mlist"
	}
	mod := Module{
		Tag:         *declaration.TagName,
		Slots:       makeSlots(declaration.Slots),
		Name:        name,
		SnakeName:   strcase.ToSnake(name),
		Imports:     make(map[string]string, maxImports),
		HasChildren: len(declaration.Slots) > 0,
	}
	desc := *declaration.Description
	first, remainder := desc[0], desc[1:]
	desc = strings.ToLower(string(first)) + string(remainder)
	desc = strings.ReplaceAll(desc, "\n", "\n//// ")
	mod.Description = desc

	mod.Attributes, mod.Imports, mod.TestImports, externalModules = makeAttributes(name, declaration.Attributes)
	if mod.HasChildren {
		mod.TestImports["lustre/element/html"] = ""
	}
	logger.TraceID("module", fmt.Sprintf("Module %s", name))
	d.Modules[name] = mod
	return externalModules
}

func (d *Definition) getTSTypes(root *os.Root, name string, typeBuf []tsTypeDef) (types []tsTypeDef, err error) {
	cenum := strcase.ToCamel(name)
	foundIn, err := internal.GrepLR(root, "export type "+cenum)
	if err != nil {
		slog.Warn("did not find TypeScript declaration", "type", name, "error", err)
		return nil, fmt.Errorf("did not find TypeScript declaration %s: %w", name, err)
	}
	if foundIn == "" {
		slog.Warn("error extracing enumeration declaration filename", "type", name, "file", foundIn, "error", err)
		return nil, fmt.Errorf("error extracing enumeration declaration filename for %s from %s: %w", cenum, foundIn, err)
	}
	types, err = typeDefinitions(root, foundIn, cenum, typeBuf)
	if err != nil {
		slog.Warn("failed to parse enumeration declaration file", "file", foundIn, "error", err)
		return nil, fmt.Errorf("failed to parse enumeration declaration file %s for %s: %w", foundIn, cenum, err)
	}
	return types, nil
}

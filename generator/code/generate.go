package code

import (
	"fmt"
	"generator/parser"
	"log/slog"
	"os"
)

func Generate(definition *parser.Definition, destination string) (err error) {
	root, err := os.OpenRoot(destination)
	if err != nil {
		return fmt.Errorf("failed to create destination root filesystem: %w", err)
	}
	defer func() {
		if err := root.Close(); err != nil {
			slog.Error("failed to close test destination folder", "folder", destination, "error", err)
		}
	}()

	// Write out the code for each Gleam wrapper module - one Gleam file for
	// each TypeScript Element defined in the manifest
	for modName, module := range definition.Modules {
		err = generateModule(root, &module)
		if err != nil {
			return fmt.Errorf("generation of code for module %s failed: %w", modName, err)
		}
	}

	// Write out the code for each enumerated type - one Gleam file for each, definition.Enumerations
	// TypeScript enum defined in the manifest
	err = generateEnums(root, definition.Enumerations)
	if err != nil {
		return fmt.Errorf("generation of code for enumeration failed: %w", err)
	}
	return
}

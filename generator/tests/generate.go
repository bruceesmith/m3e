package tests

import (
	"fmt"
	"generator/parser"
	"log/slog"
	"os"
)

// Generate generates all the unit test files
func Generate(definition *parser.Definition, destination string) (err error) {
	// Write out the unit tests for each Gleam wrapper module - one Gleam file for
	// each TypeScript Element defined in the manifest.
	for modName, module := range definition.Modules {
		root, err := os.OpenRoot(destination)
		if err != nil {
			return fmt.Errorf("failed to create destination root filesystem: %w", err)
		}
		defer func() {
			if err := root.Close(); err != nil {
				slog.Error("failed to close test destination folder", "folder", destination, "error", err)
			}
		}()
		err = generateTests(root, &module, definition.Enumerations)
		if err != nil {
			return fmt.Errorf("failed to generate unit tests for %s: %w", modName, err)
		}
	}
	return
}

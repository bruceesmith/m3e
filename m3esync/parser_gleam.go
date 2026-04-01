package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

// Regex patterns for parsing Gleam files
var (
	// Matches typical Gleam record fields "field_name: Type"
	fieldRegex = regexp.MustCompile(`([a-z_][a-z0-9_]*):\s*([A-Z][A-Za-z0-9_]*)`)
	// Matches documentation lines for fields: "/// - field_name: description"
	docRegex = regexp.MustCompile(`^\s*///\s*-\s*([a-z_][a-z0-9_]*):\s*(.*)`)
)

// ParseGleam analyzes all Gleam files in the specified directory to extract
// component fields and documentation.
func ParseGleam(basePath string) (gcomponents, gdocs GComponents, err error) {
	fmt.Println("Parsing Gleam...")
	searchDir := filepath.Join(basePath, "src", "m3e")

	gcomponents = make(GComponents)
	gdocs = make(GComponents)

	files, err := os.ReadDir(searchDir)
	if err != nil {
		return nil, nil, fmt.Errorf("error reading Gleam directory: %w", err)
	}

	for _, f := range files {
		if f.IsDir() || !strings.HasSuffix(f.Name(), ".gleam") {
			continue
		}

		compName := normalizeComponentName(f.Name())
		path := filepath.Join(searchDir, f.Name())

		fields, docs, err := parseGleamFile(path)
		if err != nil {
			return nil, nil, err
		}

		gcomponents[compName] = fields
		gdocs[compName] = docs
	}

	return gcomponents, gdocs, nil
}

// normalizeComponentName converts a filename like "my_component.gleam" to "mycomponent"
func normalizeComponentName(filename string) string {
	name := strings.TrimSuffix(filename, ".gleam")
	name = strings.ReplaceAll(name, "_", "")
	return strings.ToLower(name)
}

// parseGleamFile opens a file and extracts fields and their documentation
func parseGleamFile(path string) (GFields, GFields, error) {
	fields := make(GFields)
	docs := make(GFields)

	file, err := os.Open(path)
	if err != nil {
		return nil, nil, fmt.Errorf("error opening Gleam file: %w", err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	inOpaqueBlock := false

	for scanner.Scan() {
		line := scanner.Text()

		// 1. Extract documentation (always active)
		if m := docRegex.FindStringSubmatch(line); len(m) >= 3 {
			docs[m[1]] = strings.TrimSuffix(strings.TrimSpace(m[2]), ".")
		}

		// 2. State transition: Enter opaque type block
		if strings.Contains(line, "pub opaque type") {
			inOpaqueBlock = true
			continue
		}

		// 3. Parse fields if within the block
		if inOpaqueBlock {
			extractFields(line, fields)

			// Exit condition: closing brace or start of next function
			if (strings.Contains(line, "}") || strings.HasPrefix(line, "pub fn")) && len(fields) > 0 {
				break
			}
		}
	}

	if err := scanner.Err(); err != nil {
		return nil, nil, fmt.Errorf("error reading Gleam file: %w", err)
	}

	return fields, docs, nil
}

// extractFields finds all field definitions in a line and adds them to the map
func extractFields(line string, fields GFields) {
	matches := fieldRegex.FindAllStringSubmatch(line, -1)
	for _, match := range matches {
		if len(match) >= 3 {
			fields[match[1]] = match[2]
		}
	}
}

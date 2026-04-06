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
	fieldRegex = regexp.MustCompile(`([a-z_][a-z0-9_]*):\s*([A-Za-z][A-Za-z0-9_\.\(\)]*)`)
	// Matches documentation lines for fields: "/// - field_name: description"
	docRegex = regexp.MustCompile(`^\s*///\s*-\s*([a-z_][a-z0-9_]*):\s*(.*)`)
	// Matches slot name line: "SlotName\n // description"
	slotRegex = regexp.MustCompile(` *([A-Z][a-zA-Z]+)$`)
)

// ParseGleam analyzes all Gleam files in the specified directory to extract
// component fields and documentation.
func ParseGleam(basePath string) (components M3E, err error) {
	fmt.Println("Parsing Gleam...")
	searchDir := filepath.Join(basePath, "src", "m3e")

	components = make(M3E)

	files, err := os.ReadDir(searchDir)
	if err != nil {
		return nil, fmt.Errorf("error reading Gleam directory: %w", err)
	}

	for _, f := range files {
		if f.IsDir() || !strings.HasSuffix(f.Name(), ".gleam") {
			continue
		}

		compName := normalizeComponentName(f.Name())
		path := filepath.Join(searchDir, f.Name())

		attributes, slots, err := parseGleamFile(path)
		if err != nil {
			return nil, err
		}

		components[compName] = Properties{
			attributes: attributes,
			slots:      slots,
		}
	}

	return components, nil
}

// normalizeComponentName converts a filename like "my_component.gleam" to "mycomponent"
func normalizeComponentName(filename string) string {
	name := strings.TrimSuffix(filename, ".gleam")
	name = strings.ReplaceAll(name, "_", "")
	return strings.ToLower(name)
}

// parseGleamFile opens a file and extracts fields and their documentation
func parseGleamFile(path string) (map[string]string, map[string]string, error) {
	attributes := make(map[string]string)
	docs := make(map[string]string)
	slots := make(map[string]string)
	slotlines := make([]string, 0)

	file, err := os.Open(path)
	if err != nil {
		return nil, nil, fmt.Errorf("error opening Gleam file: %w", err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	inOpaqueBlock := false
	inSlotBlock := false
	delarationParsed := false

	for scanner.Scan() {
		line := scanner.Text()

		// 1. Extract documentation for fields before parsing the declaration
		if !delarationParsed {
			if m := docRegex.FindStringSubmatch(line); len(m) >= 3 {
				docs[m[1]] = strings.TrimSuffix(strings.TrimSpace(m[2]), ".")
			}
		}

		// 2. State transition: Enter opaque type block or slot declaration
		if strings.Contains(line, "pub opaque type") {
			inOpaqueBlock = true
			continue
		} else if strings.Contains(line, "pub type Slot") {
			inSlotBlock = true
			continue
		}

		// 3. Parse fields if within the block
		if inOpaqueBlock {
			extractFields(line, attributes)
			// Exit condition: closing brace or start of next function
			if strings.Contains(line, "}") || strings.HasPrefix(line, "pub fn") {
				inOpaqueBlock = false
				delarationParsed = true
				continue
			}

		} else if inSlotBlock {
			// Exit condition: closing brace or start of next function
			if strings.Contains(line, "}") || strings.HasPrefix(line, "pub fn") {
				inSlotBlock = false
				break
			}
			slotlines = append(slotlines, line)
		}
	}

	if err := scanner.Err(); err != nil {
		return nil, nil, fmt.Errorf("error reading Gleam file: %w", err)
	}

	for k := range attributes {
		if doc, exists := docs[k]; exists {
			attributes[k] = doc
		}
	}
	extractSlots(slotlines, slots)

	return attributes, slots, nil
}

// extractFields finds all field definitions in a line and adds them to the map
func extractFields(line string, fields map[string]string) {
	matches := fieldRegex.FindAllStringSubmatch(line, -1)
	for _, match := range matches {
		if len(match) >= 3 {
			fields[match[1]] = strings.TrimSpace(match[2])
		}
	}
}

// extractSlots finds all slot definitions
func extractSlots(lines []string, slots map[string]string) {
	slot, desc := "", ""
	for _, line := range lines {
		matches := slotRegex.FindAllString(line, -1)

		if len(matches) == 1 {
			slot = strings.TrimSpace(strings.ToLower(matches[0]))

		} else if index := strings.Index(line, "// "); index != -1 {
			desc = strings.TrimSpace(line[index+3:])
		}
		slots[slot] = strings.TrimSpace(desc)
	}
}

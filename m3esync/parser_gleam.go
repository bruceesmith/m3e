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
	lines, err := readAllLines(path)
	if err != nil {
		return nil, nil, fmt.Errorf("error reading Gleam file: %w", err)
	}

	attributes, docs := parseAttributesAndDocs(lines)
	slots := parseSlots(lines)

	// Merge docs into attributes
	for k := range attributes {
		if doc, exists := docs[k]; exists {
			attributes[k] = doc
		}
	}

	return attributes, slots, nil
}

// readAllLines reads all lines from a file
func readAllLines(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, scanner.Err()
}

// parseAttributesAndDocs extracts attributes and their documentation from lines
func parseAttributesAndDocs(lines []string) (map[string]string, map[string]string) {
	attributes := make(map[string]string)
	docs := make(map[string]string)
	inOpaque := false
	declarationParsed := false

	for _, line := range lines {
		if !declarationParsed {
			if m := docRegex.FindStringSubmatch(line); len(m) >= 3 {
				docs[m[1]] = strings.TrimSuffix(strings.TrimSpace(m[2]), ".")
			}
		}

		if strings.Contains(line, "pub opaque type") {
			inOpaque = true
			continue
		}

		if inOpaque {
			extractAttributes(line, attributes)
			if strings.Contains(line, "}") || strings.HasPrefix(line, "pub fn") {
				inOpaque = false
				declarationParsed = true
			}
		}
	}

	return attributes, docs
}

// parseSlots extracts slots from lines
func parseSlots(lines []string) map[string]string {
	slots := make(map[string]string)
	var slotlines []string
	inSlot := false

	for _, line := range lines {
		if strings.Contains(line, "pub type Slot") {
			inSlot = true
			continue
		}

		if inSlot {
			if strings.Contains(line, "}") || strings.HasPrefix(line, "pub fn") {
				break
			}
			slotlines = append(slotlines, line)
		}
	}

	extractSlots(slotlines, slots)
	return slots
}

// extractAttributes finds all field definitions in a line and adds them to the map
func extractAttributes(line string, fields map[string]string) {
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

		} else if _, after, ok := strings.Cut(line, "// "); ok {
			desc = strings.TrimSpace(after)
		}
		slots[slot] = strings.TrimSpace(desc)
	}
}

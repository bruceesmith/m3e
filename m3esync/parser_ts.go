package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

// ParseTS analyises all the TypeScript files in M3E Expressive Components
func ParseTS(basePath string) (components M3E, err error) {
	fmt.Println("Parsing TypeScript...")
	searchDir := filepath.Join(basePath, "packages", "web", "src")
	attrRegex := regexp.MustCompile(`\* @attr ([a-z0-9-]+) - (.*)`)
	slotRegex := regexp.MustCompile(`\* @slot ([a-z0-9-]+) - (.*)`)
	components = make(M3E)

	err = filepath.WalkDir(searchDir, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return err
		}

		// Skip the core directory
		if d.IsDir() && d.Name() == "core" {
			return filepath.SkipDir
		}

		// Only process *.ts files containing "Element"
		if !d.IsDir() && strings.HasSuffix(d.Name(), "Element.ts") {
			compName := strings.TrimSuffix(d.Name(), "Element.ts")
			compName = strings.ToLower(compName)

			attributes := make(map[string]string)
			slots := make(map[string]string)
			file, err := os.Open(path)
			if err != nil {
				return err
			}
			defer file.Close()

			scanner := bufio.NewScanner(file)
			for scanner.Scan() {
				line := strings.TrimSpace(scanner.Text())
				matches := attrRegex.FindStringSubmatch(line)
				if len(matches) >= 3 {
					// matches[1] is the attribute name, matches[2] is the description
					key := strings.ReplaceAll(matches[1], "-", "_")
					description := strings.TrimSuffix(matches[2], ".")
					attributes[key] = description
				}
				matches = slotRegex.FindStringSubmatch(line)
				if len(matches) >= 3 {
					// matches[1] is the slot name, matches[2] is the description
					key := strings.ReplaceAll(matches[1], "-", "")
					description := strings.TrimSuffix(matches[2], ".")
					slots[key] = description
				}
			}

			if err := scanner.Err(); err != nil {
				return err
			}

			components[compName] = Properties{
				attributes: attributes,
				slots:      slots,
			}
		}

		return nil
	})
	return
}

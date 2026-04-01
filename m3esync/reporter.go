package main

import (
	"encoding/json"
	"fmt"
	"maps"
	"slices"
	"strings"
)

type Description struct {
	Name       string
	TypeScript string
	Gleam      string
}

type Field struct {
	Name        string
	Description string
}
type Difference struct {
	Attributes   []Field
	Descriptions []Description
}

type Discrepancies struct {
	Different map[string]Difference
	Missing   map[string]struct{}
}

// GenerateReport produces the detail of every discrepancy that has been discovered
func GenerateReport(flags Flags, tscomponents TSComponents, gcomponents, gdocs GComponents) {
	fmt.Println("\n--- M3E Sync Report ---")

	// Figure out the differenes between the TypeScript source of truth and the Gleam wrappers
	differences := analyse(flags, tscomponents, gcomponents, gdocs)

	// Report the findings
	if !flags.jason {
		textReport(differences, flags)
	} else {
		jsonReport(differences)
	}

	fmt.Println("\nCheck complete.")
}

func analyse(flags Flags, tscomponents TSComponents, gcomponents, gdocs GComponents) (differences Discrepancies) {
	differences = Discrepancies{
		Different: make(map[string]Difference, len(gcomponents)),
		Missing:   make(map[string]struct{}),
	}

	for tsCompName := range tscomponents {
		analyseComponent(tsCompName, flags, tscomponents, gcomponents, gdocs, &differences)
	}
	return differences
}

// analyseComponent checks a single component for missing status or attribute mismatches
func analyseComponent(name string, flags Flags, tsC TSComponents, gC, gD GComponents, diffs *Discrepancies) {
	gFields, exists := gC[name]
	if !exists {
		if flags.components {
			diffs.Missing[name] = struct{}{}
		}
		return
	}

	tsAttrs := tsC[name]
	gDocs := gD[name]

	for attrName, tsDesc := range tsAttrs {
		tsDescClean := strings.TrimSpace(tsDesc)

		if _, fieldExists := gFields[attrName]; !fieldExists {
			if !hasAlternative(attrName, gFields) && bool(flags.attributes) {
				addAttrMismatch(diffs, name, attrName, tsDescClean)
			}
			continue
		}

		if flags.descriptions {
			gDesc := strings.TrimSpace(gDocs[attrName])
			if tsDescClean != gDesc {
				addDescMismatch(diffs, name, attrName, tsDescClean, gDesc)
			}
		}
	}
}

// hasAlternative checks if an attribute is covered by a composite Gleam field
func hasAlternative(attrName string, gFields GFields) bool {
	switch attrName {
	case "download", "href", "rel", "target":
		_, exists := gFields["link"]
		return exists
	case "name", "value":
		_, exists := gFields["form_submission"]
		return exists
	default:
		return false
	}
}

// getDifference retrieves or initializes the Difference entry for a component
func getDifference(diffs *Discrepancies, compName string) Difference {
	d, exists := diffs.Different[compName]
	if !exists {
		d = Difference{
			Attributes:   make([]Field, 0),
			Descriptions: make([]Description, 0),
		}
	}
	return d
}

func addAttrMismatch(diffs *Discrepancies, comp, attr, desc string) {
	d := getDifference(diffs, comp)
	d.Attributes = append(d.Attributes, Field{attr, desc})
	diffs.Different[comp] = d
}

func addDescMismatch(diffs *Discrepancies, comp, attr, tsDesc, gDesc string) {
	d := getDifference(diffs, comp)
	d.Descriptions = append(d.Descriptions, Description{attr, tsDesc, gDesc})
	diffs.Different[comp] = d
}

func jsonReport(differences Discrepancies) {
	bites, err := json.MarshalIndent(differences, "", "  ")
	if err != nil {
		panic(err)
	}
	fmt.Println(string(bites))
}

func textReport(differences Discrepancies, flags Flags) {
	if flags.components {
		components := slices.Sorted(maps.Keys(differences.Missing))
		for _, component := range components {
			fmt.Printf("[!] Component missing in Gleam: %s\n", component)
		}
	}
	if bool(flags.attributes) || bool(flags.descriptions) {
		heading := false
		components := slices.Sorted(maps.Keys(differences.Different))
		for _, component := range components {
			if flags.attributes {
				for _, f := range differences.Different[component].Attributes {
					if !heading {
						fmt.Printf("[Δ] Attribute mismatch in Gleam: %s\n", component)
						heading = true
					}
					fmt.Printf("    - Missing field: %s (%s)\n", f.Name, f.Description)
				}
			}
			if flags.descriptions {
				for _, d := range differences.Different[component].Descriptions {
					if !heading {
						fmt.Printf("[Δ] Attribute mismatch in Gleam: %s\n", component)
						heading = true
					}
					fmt.Printf("    - Description mismatch for '%s':\n      TS: %s\n      G:  %s\n", d.Name, d.TypeScript, d.Gleam)
				}
			}
			heading = false
		}
	}
}

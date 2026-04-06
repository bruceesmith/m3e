package main

import (
	"encoding/json"
	"fmt"
	"maps"
	"slices"
	"strings"
)

// Description captures the name and differing descriptions of an attribute
type Description struct {
	Name       string
	TypeScript string
	Gleam      string
}

// Attribute captures the name and description of a missing attribute
type Attribute struct {
	Name        string
	Description string
}

// Slot captures the name and description of a missing slot
type Slot struct {
	Name        string
	Description string
}

// Difference captures all discrepancies for a component, including missing attributes, description mismatches,
// and missing slots
type Difference struct {
	Attributes   []Attribute
	Descriptions []Description
	Slots        []Slot
}

// Discrepancies captures the overall differences between the TypeScript source of truth and the Gleam wrappers,
// including both components that are entirely missing and those with specific attribute or description mismatches
type Discrepancies struct {
	Different map[string]Difference
	Missing   map[string]struct{}
}

// GenerateReport produces the detail of every discrepancy that has been discovered
func GenerateReport(flags Flags, tscomponents, gcomponents M3E) {
	fmt.Println("\n--- M3E Sync Report ---")

	// Figure out the differenes between the TypeScript source of truth and the Gleam wrappers
	differences := analyse(flags, tscomponents, gcomponents)

	// Report the findings
	if !flags.jason {
		textReport(differences, flags)
	} else {
		jsonReport(differences)
	}

	fmt.Println("\nCheck complete.")
}

// analyse compares the TypeScript source of truth with the Gleam wrappers and identifies discrepancies based
// on the provided flags
func analyse(flags Flags, tscomponents, gcomponents M3E) (differences Discrepancies) {
	differences = Discrepancies{
		Different: make(map[string]Difference, len(gcomponents)),
		Missing:   make(map[string]struct{}),
	}

	for tsCompName := range tscomponents {
		analyseComponent(tsCompName, flags, tscomponents, gcomponents, &differences)
	}
	return differences
}

// analyseComponent checks a single component for missing status or attribute mismatches
func analyseComponent(name string, flags Flags, tsC, gC M3E, diffs *Discrepancies) {
	gProperties, exists := gC[name]
	if !exists {
		if flags.components {
			diffs.Missing[name] = struct{}{}
		}
		return
	}

	tsProperties := tsC[name]
	// gDocs := gD[name]

	for attrName, tsDesc := range tsProperties.attributes {
		tsDescClean := strings.TrimSpace(tsDesc)

		if _, fieldExists := gProperties.attributes[attrName]; !fieldExists {
			if !hasAlternative(attrName, gProperties.attributes) && bool(flags.attributes) {
				addAttrMismatch(diffs, name, attrName, tsDescClean)
			}
			continue
		}

		if flags.descriptions {
			gDesc := strings.TrimSpace(gProperties.attributes[attrName])
			if tsDescClean != gDesc && bool(flags.descriptions) {
				addDescMismatch(diffs, name, attrName, tsDescClean, gDesc)
			}
		}
	}
	for slotName, slotDesc := range tsProperties.slots {
		if _, slotExists := gProperties.slots[slotName]; !slotExists && bool(flags.slots) {
			addSlotMismatch(diffs, name, slotName, slotDesc)
		}
	}
}

// hasAlternative checks if an attribute is covered by a composite Gleam field
func hasAlternative(attrName string, attributes map[string]string) bool {
	switch attrName {
	case "download", "href", "rel", "target":
		_, exists := attributes["link"]
		return exists
	case "name", "type", "value":
		_, exists := attributes["form_submission"]
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
			Attributes:   make([]Attribute, 0),
			Descriptions: make([]Description, 0),
			Slots:        make([]Slot, 0),
		}
	}
	return d
}

// addAttrMismatch records a missing attribute for a component in the discrepancies report
func addAttrMismatch(diffs *Discrepancies, comp, attr, desc string) {
	d := getDifference(diffs, comp)
	d.Attributes = append(d.Attributes, Attribute{attr, desc})
	diffs.Different[comp] = d
}

// addDescMismatch records a description mismatch for an attribute of a component in the discrepancies report
func addDescMismatch(diffs *Discrepancies, comp, attr, tsDesc, gDesc string) {
	d := getDifference(diffs, comp)
	d.Descriptions = append(d.Descriptions, Description{attr, tsDesc, gDesc})
	diffs.Different[comp] = d
}

// addSlotMismatch records a missing slot for a component in the discrepancies report
func addSlotMismatch(diffs *Discrepancies, comp, slotName, slotDesc string) {
	d := getDifference(diffs, comp)
	d.Slots = append(d.Slots, Slot{slotName, slotDesc})
	diffs.Different[comp] = d
}

// jsonReport outputs the discrepancies in a structured JSON format for easy consumption by other tools or scripts
func jsonReport(differences Discrepancies) {
	bites, err := json.MarshalIndent(differences, "", "  ")
	if err != nil {
		panic(err)
	}
	fmt.Println(string(bites))
}

// textReport outputs the discrepancies in a human-readable format, grouping issues by component and type of
// mismatch
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
	if flags.slots {
		heading := false
		components := slices.Sorted(maps.Keys(differences.Different))
		for _, component := range components {
			for _, s := range differences.Different[component].Slots {
				if !heading {
					fmt.Printf("[Δ] Slot mismatch in Gleam: %s\n", component)
					heading = true
				}
				fmt.Printf("    - Missing slot: %s (%s)\n", s.Name, s.Description)
			}
			heading = false
		}
	}
}

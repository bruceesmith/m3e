package main

import (
	"context"
	"fmt"

	"github.com/urfave/cli/v3"
)

// Report and the following uses of it are phantom types to avoid "boolean blindness"
// when calling reporter()
type Report[T any] bool

type Attributes Report[Attributes]

type Components Report[Components]

type Descriptions Report[Descriptions]

// Flags is used to pass commandline flags into the reportinf functions
type Flags struct {
	attributes   Attributes
	components   Components
	descriptions Descriptions
	jason        bool
}

// Utility is the function launched to actually perform all the work
func Utility(ctx context.Context, cmd *cli.Command) (err error) {
	fmt.Println("Starting sync check...")

	// Parse the TypeScript files in M3E Expressive Components
	tsComponents, err := ParseTS(cmd.String(tsFlag))
	if err != nil {
		return fmt.Errorf("error parsing TypeScript: %w", err)

	}

	// Parse the Gleam files in M3E wrapper l ibrary
	gComponents, gDocs, err := ParseGleam(cmd.String(gleamFlag))
	if err != nil {
		return fmt.Errorf("error parsing Gleam: %w", err)
	}

	flags := Flags{
		attributes:   Attributes(cmd.Bool(attributes)),
		components:   Components(cmd.Bool(components)),
		descriptions: Descriptions(cmd.Bool(descriptions)),
		jason:        cmd.Bool("json"),
	}

	// Report all the discrepancies
	GenerateReport(
		flags,
		tsComponents,
		gComponents,
		gDocs,
	)
	return
}

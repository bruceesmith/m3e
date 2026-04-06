package main

import (
	"context"
	"fmt"

	"github.com/urfave/cli/v3"
)

// Properties is the configuration of an M3E Expressive component - the HTML attributes
// and the slots
type Properties struct {
	// Attributes represents the HTML attributes associated with an M3E Expressive Component. In the TypeScript code
	// these attributes are each documented in a comment line of the form:
	//
	//	/*
	//	 * @attr disabled - Whether the element is disabled.
	//	*/
	//
	// There is one Attributes instance per M3E Expressive Component. The key is the attribute name, the value is its description
	attributes map[string]string
	// Slots represents the HTML 'slot' attributes associated with an M3E Expressive Component. In the TypeScript code
	// these 'slot' attributes are each documented in a comment line of the form:
	//
	//	/*
	//	 @slot icon - Renders an icon before the chip's label.
	//	*/
	//
	// There is one Slots instance per M3E Expressive Component. The key is the slot name, the value is its description
	slots map[string]string
}

// M3E represents the total set of M3E Expressive Components in matraic's library. The key is the standardised name of a
// component, the value is the set of associated HTML attributes and slots
type M3E = map[string]Properties

// Report and friends protect against "boolean blindness" - the problem of having multiple boolean parameters in a
// function and not being sure which is which. By defining distinct types for each of the boolean parameters, we
// can make the code more readable and less error-prone.
type Report[T any] bool

type Attributes Report[Attributes]
type Components Report[Components]
type Descriptions Report[Descriptions]
type Slots Report[Slots]

// Flags is used to pass commandline flags into the reporting functions
type Flags struct {
	attributes   Attributes
	components   Components
	descriptions Descriptions
	slots        Slots
	jason        bool
}

// Utility is the function launched to actually perform all the work
func Utility(ctx context.Context, cmd *cli.Command) (err error) {
	fmt.Println("Starting sync check...")

	// Parse the TypeScript files in M3E Expressive Components
	tsComponents, err := ParseTS(cfg.TS)
	if err != nil {
		return fmt.Errorf("error parsing TypeScript: %w", err)

	}

	// Parse the Gleam files in M3E wrapper l ibrary
	gComponents, err := ParseGleam(cfg.Gleam)
	if err != nil {
		return fmt.Errorf("error parsing Gleam: %w", err)
	}

	flags := Flags{
		attributes:   Attributes(cfg.Attributes),
		components:   Components(cfg.Components),
		descriptions: Descriptions(cfg.Descriptions),
		slots:        Slots(cfg.Slots),
		jason:        cmd.Bool("json"),
	}

	// Report all the discrepancies
	GenerateReport(
		flags,
		tsComponents,
		gComponents,
	)
	return
}

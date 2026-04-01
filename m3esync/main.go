package main

import (
	"context"

	"github.com/bruceesmith/echidna"
	"github.com/urfave/cli/v3"
)

// Names of the command line flags
const (
	attributes   = "attributes"
	components   = "components"
	descriptions = "descriptions"
	gleamFlag    = "gleam"
	tsFlag       = "ts"
)

// TSAttributes represents the HTML attributes associated with an M3E Expressive Component. In the TypeScript code
// these attributes are each documented in a comment line of the form:
//
//	/*
//	 * @attr disabled - Whether the element is disabled.
//	*/
//
// There is one TSAttributes instance per M3E Expressive Component. The key is the attribute name, the value is its description
type TSAttributes = map[string]string

// TSComponents represents the total set of M3E Expressive Components in matraic's library. The key is the standardised name of a
// component, the value is the set of associated HTML attributes
type TSComponents = map[string]TSAttributes

// GFields represents the record fields of a Gleam opaque record which wraps an M3E Expressive Component. The key is the
// name of a field and the value is it's Gleam type
//
// There is one GFields instance per Gleam "pub opaque type", i.e. one per wrapped M3E Expressive Component
type GFields = map[string]string

// GComponents represents the total set of Gleam opaque records which wrap M3E Expressive Components. The key is the standardised name
// of a component, the value is the set of associated fields
type GComponents = map[string]GFields

// main function is where the action starts ans ends
func main() {
	var cmd = &cli.Command{
		Name:        "m3esync",
		Action:      Utility,
		Description: "Sync tool for M3E Gleam/Lustre wrappers",
		Flags: []cli.Flag{
			&cli.StringFlag{
				Name:     tsFlag,
				Usage:    "Path to local M3E TypeScript library",
				Required: true,
			},
			&cli.StringFlag{
				Name:     gleamFlag,
				Usage:    "Path to local Gleam/Lustre project",
				Value:    ".",
				Required: true,
			},
			&cli.BoolFlag{
				Name:  attributes,
				Usage: "Report missing attributes",
				Value: false,
			},
			&cli.BoolFlag{
				Name:  components,
				Usage: "Report missing components",
				Value: false,
			},
			&cli.BoolFlag{
				Name:  descriptions,
				Usage: "Report differing descriptions of attributes",
				Value: false,
			},
		},
		Usage:   "M3E Sync Tool",
		Version: "1.0",
	}

	echidna.Run(
		context.Background(),
		cmd,
	)
}

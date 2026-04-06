package main

import (
	"context"
	"strings"

	"github.com/bruceesmith/echidna"
	"github.com/knadh/koanf"
	"github.com/knadh/koanf/parsers/yaml"
	"github.com/knadh/koanf/providers/file"
	"github.com/urfave/cli/v3"
)

// Names of the command line flags
const (
	attributes   = "attributes"
	components   = "components"
	descriptions = "descriptions"
	slots        = "slots"
	gleamFlag    = "gleam"
	tsFlag       = "ts"
)

// configuration holds the command line flags and configuration file values
type configuration struct {
	Attributes   bool   `desc:"Report missing attributes"`
	Components   bool   `desc:"Report missing components"`
	Descriptions bool   `desc:"Report differing descriptions of attributes"`
	Slots        bool   `desc:"Report missing slot attributes"`
	Gleam        string `desc:"Path to local Gleam/Lustre project"`
	TS           string `desc:"Path to local M3E TypeScript library"`
}

func (c configuration) Validate() error { return nil }

var cfg configuration

// main function is where the action starts ans ends
func main() {
	cmd := &cli.Command{
		Name:        "m3esync",
		Action:      Utility,
		Description: "Sync tool for M3E Gleam/Lustre wrappers",
		Usage:       "M3E Sync Tool",
		Version:     "1.1",
	}

	loaders := []echidna.Loader{
		{
			Provider: func(s string) koanf.Provider {
				return file.Provider(s)
			},
			Parser: yaml.Parser(),
			Match: func(s string) bool {
				return strings.HasSuffix(s, ".yml")
			},
		},
	}

	echidna.Run(
		context.Background(),
		cmd,
		echidna.Configuration(
			&cfg,
			loaders,
		),
		echidna.ConfigFlags(
			[]echidna.Configurator{&cfg},
			cmd,
		),
	)
}

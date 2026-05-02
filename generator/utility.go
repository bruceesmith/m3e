/*
Package generator provides the main entry point for the generator tool.
*/
package generator

import (
	"context"
	"encoding/json"
	"fmt"
	"generator/cem"
	"generator/code"
	"generator/metrics"
	"generator/parser"
	"generator/tests"
	"os"
	"path/filepath"
	"strings"
	"time"

	"github.com/bruceesmith/echidna"
	"github.com/bruceesmith/logger"
	"github.com/knadh/koanf"
	"github.com/knadh/koanf/parsers/yaml"
	"github.com/knadh/koanf/providers/file"
	"github.com/urfave/cli/v3"
)

// configuration holds the command line flags and configuration file values
type configuration struct {
	Destination string `desc:"Folder to output generated Gleam/Lustre wrappers" flag:"destination dest" env:"DESTINATION"`
	M3ESource   string `desc:"Folder containing M3E Expressive component source files" flag:"m3e-source m3e" env:"M3E_SOURCE"`
}

func (c configuration) Validate() error { return nil }

var cfg configuration = configuration{}

// Utility is the function launched to actually perform all the work
func Utility() (err error) {
	cmd := &cli.Command{
		Name:        "generator",
		Action:      run,
		Description: "Generate Gleam/Lustre wrappers for M3E Expressive components",
		Flags: []cli.Flag{
			&cli.BoolFlag{
				Name:  "no-code",
				Usage: "Do not generate the Gleam wrappers",
			},
			&cli.BoolFlag{
				Name:  "no-metrics",
				Usage: "Do not capture or report metrics",
			},
			&cli.BoolFlag{
				Name:  "no-tests",
				Usage: "Do not generate the unit tests",
			},
		},
		Usage:   "Generator Tool",
		Version: "0.1.0",
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
	return
}

func run(ctx context.Context, cmd *cli.Command) (err error) {
	var metrics = metrics.New()
	if cmd.Bool("no-metrics") {
		metrics.Disable()
	}

	logger.Info("Starting generation...")

	// If JSON output is requested (--json) then switch the loggers to JSON
	if cmd.Bool("json") {
		err = jsonLogging()
		if err != nil {
			logger.Warn("cannot set JSON logging", "error", err)
		}
	}
	// Parse the Custom Element Manifest into a SchemaJson struct
	var manifest cem.SchemaJson
	metrics.Start("cem")
	manifest, err = customManifest()
	if err != nil {
		return fmt.Errorf("failed to load custom manifest: %w", err)
	}
	err = metrics.End("cem")
	if err != nil {
		logger.Warn("failed to close cem metrics", "error", err)
	}
	logger.Info("CEM parsing complete ...")

	// Parse the SchemaJson into the internal format of a Definition struct
	var modules parser.Definition
	modules, err = parser.Parse(&manifest, cfg.M3ESource, metrics)
	if err != nil {
		return fmt.Errorf("failed to parse the custom manifest: %w", err)
	}

	// Generate Gleam/Lustre wrappers for the modules
	date := time.Now().Format(time.RFC3339)
	if !cmd.Bool("no-code") {
		metrics.Start("generate-code")
		if err := code.Generate(&modules, filepath.Join(cfg.Destination, "src/m3e/"), cmd.Version, date); err != nil {
			return fmt.Errorf("failed to generate wrappers: %w", err)
		}
		err = metrics.End("generate-code")
		if err != nil {
			logger.Warn("failed to close generate-code metrics", "error", err)
		}
		logger.Info("Module code generation complete ...")
	}

	// Generate unit tests for the wrappers

	if !cmd.Bool("no-tests") {
		metrics.Start("generate-tests")
		if err := tests.Generate(&modules, filepath.Join(cfg.Destination, "test/m3e/"), cmd.Version, date); err != nil {
			return fmt.Errorf("failed to generate tests: %w", err)
		}
		err = metrics.End("generate-tests")
		if err != nil {
			logger.Warn("failed to close generate-tests metrics", "error", err)
		}
		logger.Info("Unit test generation complete ...")
	}

	metrics.Report()
	return
}

func customManifest() (manifest cem.SchemaJson, err error) {
	customElements, err := os.ReadFile("./custom-elements.json")
	if err != nil {
		return manifest, fmt.Errorf("failed to read custom-elements.json: %w", err)
	}
	if err := json.Unmarshal(customElements, &manifest); err != nil {
		return manifest, fmt.Errorf("failed to unmarshal custom-elements.json: %w", err)
	}
	return manifest, nil
}

func jsonLogging() (err error) {
	err = logger.Configure(
		logger.ConfigSetting{
			AppliesTo: logger.Norm,
			Key:       logger.FormatSetting,
			Value:     logger.JSON,
		},
		logger.ConfigSetting{
			AppliesTo: logger.Tracy,
			Key:       logger.FormatSetting,
			Value:     logger.JSON,
		},
	)
	return err
}

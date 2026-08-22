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
	"generator/internal"
	"generator/metrics"
	"generator/parser"
	"generator/tests"
	"os"
	"path/filepath"

	"github.com/bruceesmith/echidna"
	"github.com/bruceesmith/logger"
	"github.com/urfave/cli/v3"
)

// Utility is the function launched to set up the environment and start the processing
func Utility() {
	cmd := &cli.Command{
		Name:        "generator",
		Action:      run,
		Description: "Generate Gleam/Lustre bindings for M3E Expressive components",
		Flags: []cli.Flag{
			&cli.StringFlag{
				Name:    "destination",
				Aliases: []string{"dest"},
				Sources: cli.EnvVars("DESTINATION"),
				Usage:   "Folder to output generated Gleam/Lustre bindings",
			},
			&cli.StringFlag{
				Name:    "m3e-source",
				Aliases: []string{"m3e"},
				Sources: cli.EnvVars("M3E_SOURCE"),
				Usage:   "Folder containing M3E Expressive component source files",
			},
			&cli.BoolFlag{
				Name:  "no-code",
				Usage: "Do not generate the Gleam bindings",
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
		Version: "0.2.0",
	}

	echidna.Run(
		context.Background(),
		cmd,
	)
	// return
}

// run is the controlling function for the generator program. It
// - converts the M3E manifest to a cem.SchemaJSON struct
// - parses the SchemaJson into the internal format of a Definition struct
// - generates Gleam/Lustre bindings for the modules
// - generates unit tests for the bindings
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
	if manifest, err = processManifest(metrics); err != nil {
		logger.Error("error ingesting the Custom Element Manifest", internal.ErrorAttr(err))
		return fmt.Errorf("failed - refer to previous error messages")
	}

	// Parse the SchemaJson into the internal format of a Definition struct
	var modules parser.Definition
	if modules, err = parser.Parse(&manifest, cmd.String("m3e-source"), metrics); err != nil {
		logger.Error("error parsing the custom manifest", internal.ErrorAttr(err))
		return fmt.Errorf("failed - refer to previous error messages")
	}

	// Generate Gleam/Lustre bindings for the modules
	if err = generateModules(!cmd.Bool("no-code"), cmd.String("destination"), &modules, metrics); err != nil {
		logger.Error("error generating the Gleam modules", internal.ErrorAttr(err))
		return fmt.Errorf("failed - refer to previous error messages")
	}

	// Generate unit tests for the bindings,
	if err = generateTests(!cmd.Bool("no-tests"), cmd.String("destination"), &modules, metrics); err != nil {
		logger.Error("error generating the Gleam unit tests", internal.ErrorAttr(err))
		return fmt.Errorf("failed - refer to previous error messages")
	}

	metrics.Report()
	return
}

// customManifest reads the M3E manifest and unmarshals it into a cem.SchemJSON
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

func generateModules(generate bool, destination string, modules *parser.Definition, metrics *metrics.Metrics) (err error) {
	if generate {
		metrics.Start("generate-code")
		if err := code.Generate(modules, filepath.Join(destination, "src/m3e/")); err != nil {
			return fmt.Errorf("failed to generate bindings: %w", err)
		}
		err = metrics.End("generate-code")
		if err != nil {
			logger.Warn("failed to close generate-code metrics", "error", err)
		}
		logger.Info("Module code generation complete ...")
	}
	return nil
}

func generateTests(generate bool, destination string, modules *parser.Definition, metrics *metrics.Metrics) (err error) {
	if generate {
		metrics.Start("generate-tests")
		if err := tests.Generate(modules, filepath.Join(destination, "test/m3e/")); err != nil {
			return fmt.Errorf("failed to generate tests: %w", err)
		}
		err = metrics.End("generate-tests")
		if err != nil {
			logger.Warn("failed to close generate-tests metrics", "error", err)
		}
		logger.Info("Unit test generation complete ...")
	}
	return nil
}

// jsonLogging switches both the regular and tracing loggers to emit JSON
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

// manifest parses the Custom Element Manifest into a SchemaJson struct
func processManifest(metrics *metrics.Metrics) (manifest cem.SchemaJson, err error) {
	metrics.Start("cem")
	manifest, err = customManifest()
	if err != nil {
		return manifest, fmt.Errorf("failed to load custom manifest: %w", err)
	}
	err = metrics.End("cem")
	if err != nil {
		logger.Warn("failed to close cem metrics", "error", err)
	}
	logger.Info("CEM parsing complete ...")
	return manifest, nil
}

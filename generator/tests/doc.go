// Package tests is responsible for creating the Gleam files that contain unit tests of the Gleam
// bindings.
//
// # For each module there is a test of the render() function
//
// In addition, for every module that has a Config record, there is also
//   - a test of the default_config() constructor
//   - a test of the new() constructor
//   - a test for each setter function
//
// Finally, for every module which defines one or more Slots, there is a test
// of the slots() function
//
//go:generate bash -c "go tool -modfile=../tools/go.mod gomarkdoc . > doc.md"
package tests

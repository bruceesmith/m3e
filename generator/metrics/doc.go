// Package metrics provides a type and supporting methods for simplistic monitoring
// of memory allocations and garbage collector activity
//
// To use this package:
//
//	met := metrics.New()
//	met.Start("some-identifier")
//	... perform some processing ...
//	met.End("some-identifier")
//	... more code that is not measured
//	met.Report()
//
// Multiple sampling sets can be started by calling Start() with a unique identifier. The
// same identifier must be used to call End(). Once all sampling sets have been ended,
// the Report() method can be called to output the results.
//
// A call to Disable() can be triggered off, for example, a command line flag or a
// configuration setting, to stop the collection of metrics without needing to
// wrap every call to Start(), End() and Report() in an if statement.
//
// The output from Report() is intended to be human-readable and can be piped into
// tools like `less`, `grep`, or, if JSON logging is enabled, `jq` for further processing.
//
//go:generate bash -c "go tool gomarkdoc . > doc.md"
package metrics

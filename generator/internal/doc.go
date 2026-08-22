// Package internal holds several internal functions used by various other packages.
//
// This package is not intended to be imported directly by users of the library. It is only used internally by the library's own codebase.
//
// Functions included are:
//   - ErrorAttr - converts a series of wrapped (with %w) error messages into a slog.Attr
//   - Unique - removes duplicates from a slice, and returns the sorted result
//
//go:generate bash -c "go tool -modfile=../tools/go.mod gomarkdoc . > doc.md"
package internal

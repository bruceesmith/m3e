// Package cem contains the Go types for the [Custom Element Manifest]
// schema.
//
// # Overview
//
// The schema itself can be found in the [custom element manifest repository].
//
// This package uses a local copy of the schema, downloaded from the [raw file] in Github.
//
// # Generation of types from the schema
//
// Once the latest JSON version of the CEM schema is downloaded, it is processed by [github.com/atombender/go-jsonschema] to generate the
// Go types that can be found in this package.
//
//	go tool go-jsonschema -o cem.go --only-models -p generator schema.json
//
// [Custom Element Manifest]: https://custom-elements-manifest.open-wc.org/
// [custom element manifest repository]: https://github.com/webcomponents/custom-elements-manifest
// [raw file]: https://github.com/webcomponents/custom-elements-manifest/blob/main/schema.json
//
//go:generate bash -c "go tool gomarkdoc . > doc.md"
package cem

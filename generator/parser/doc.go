// Package parser is the beating heart of the gernerator program. It is responsible for
// converting the marshaled cem.SchemaJSON into a detailed internal struct which contains
// all information required for code and unit test generation.
//
// An initial pass is made through every TypeScript module defined in the cem.SchemaJSON structure. If
// the TS module's name is of the form "M3E***Element" then it represents a Material 3 Expressive custom HTML
// component, and so will lead to a generated Gleam module and a set of Gleam unit tests.
//
// During the processing of the "M3E***Element" modules, the parser detects imported enumerated constants, which
// in the TypeScript are defined in tiny TS files that declare a TypeScript String Literal Union type. Each of these
// types is converted to a Gleam equivalent in its own Gleam file. Each string literal in the TS type becomes a
// Gleam variant in the resulting Glean type.
//
// Several TS types deserve special mention.
//   - Dates are  handled by a bespoke Gleam Date type intended to be a straighforward mapping of the ISO8601
//     formats supported by the M3E TypeScript code
//   - a union type of the form "number | all" is handled by a bespoke NumberString module that has record
//     constructors NumberVal() and StringVal()
//   - the M3E type List clashes with the intrinsic Gleam type List, so in the bindings it is called MList instea
//
//go:generate bash -c "go tool gomarkdoc . > doc.md"
package parser

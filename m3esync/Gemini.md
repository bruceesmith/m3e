# Sync tool for M3E Gleam/Lustre wrappers

## Overview

This is the GCA prompt that led to the original creation of this m3esync program. Gemini got it 95% correct first go, which is pretty decent
considering I missed a couple of design quirks and also got the TypeScript attribute regex incorrect

## Prompt

I want to create a CLI to assist me to keep my M3E Gleam/Lustre library up to date with developments in the TypeScript library that 
it wraps ([M3E Expressive Components](https://github.io/matraic/m3e)). Here are the requirements:

- written in Go
- CLI using my [Echidna library](https://github.com/bruceesmith/echidna)
- a command-line parameter taking a path to a local copy of the M3E TypeScript library
- a command-line parameter taking a path to a local copy of my Gleam/Lustre project
- declare a type TSAttribute as follows:
```go
type TSAttributes = map[string]string  
```
- declare a type TSComponents and a variable as follows:
```go
type TSComponents = map[string]TSAttributes
var tsComponents = make(TSComponents)
```
- declare a type GFields as follows:
```go
type GFields = map[string]string
```
- declare a type GComponents and a variable as follows:
```go
type GComponents = map[string]GFields
var gComponents = make(GComponents)
```
- search the TypeScript folder _packages/web/src/_ and its sub-folders (except the _core/_ sub-folder) and find all 
TypeScript files (*.ts) whose name contains the string "Element". For each such file:
    - take the filename, remove the ".ts" extension and the "Element" suffix, lowercase what remains, initialise a new empty map entry 
    in the variable _tsComponents_ with that name
    - locate every line matching the regex "^\* attr ([a-z0-9-]+) - (.*)"
    - for the first match on that line, replace - with an underscore
    - create a TSAttribute using the updated first match as the key, and the second match as the value
- for every .gleam file in the Gleam/Lustre folder _src/m3e/_
    - take the filename, remove the ".gleam" extension, lowercase what remains, initialise a new empty map entry in the variable _gComponents_ with that name
    - locate the first "pub opaque type" and for each record field
        - create a GField using the field name as the key and the field type as the value
- once the two structures _tsComponents and gComponents_ have been populated, produce a report that
    - lists any top-level key in _tsComponents_ that does not have a matching top-level key in _gComponents_
    - for each key in _tsComponents_ that has a matching key in _gComponents_, lists any field in the tsAttributes that does not have a matching field in the gFields

Describe the overall structure of this CLI
# Generator for Gleam/Lustre bindings to Material 3 Expressive components

## Overview

[matraic](https://github.com/matraic) created an [excellent TypeScript library](https://github.com/matraic/m3e) that provides
*a unified collection of robust, customizable Web Components built with the latest Material Design 3 guidelines*.

Out of the box that library provides platform‑native M3E Web Components and React bindings for the M3E Web Components.

_generator_ constructs [Gleam](https://gleam.run) bindings to the M3E Web Components, intended for use in conjunction with the 
[Lustre](https://github.com/lustre-labs/lustre) web framework *for building HTML templates, single page applications, and real-time 
server components*.

## Setup

_generator_ requires two resources from the Internet
 1) the Custom Element Manifest (`custom-elements.json`) that is provided with each M3E release
 2) a local clone of the M3E Github repository

To get started, if you have not already done so, clone
[this repository](https://github.com/bruceesmith/m3e.git) and `cd` 
into the `generator` folder:

```bash
git clone https://github.com/bruceesmith/m3e.git
cd m3e/generator/
```

Then download a fresh copy of the Custom Element Manifest and clone the [M3E repository](https://github.com/matraic/m3e)

```bash
wget https://cdn.jsdelivr.net/npm/@m3e/web@latest/dist/custom-elements.json
pushd /tmp/
git clone https://github.com/matraic/m3e.git
popd
```

Set environment variables for _generator_

```bash
cd ..
export DESTINATION=${PWD}/
cd generator/
export M3E_SOURCE=/tmp/m3e/
```

## Build _generator_

**NOTE:** This step requires a locally installed verion of [Go](https://go.dev).

```bash
go get all
go mod tidy
make build
```

If successful, this will create a `generator` binary in the current folder.

## Creation of Gleam code and unit test modules

**NOTE:** This step requires a locally installed version of Gleam.

Following successful setup, simply execute _generator_ then check,
format and test the resulting Gleam modules.\

```bash
./generator
pushd ..; gleam check; gleam format; gleam test; popd
```

## Full _generator_ help

```bash
  NAME:
    generator - Generator Tool
  
  USAGE:
    generator [global options] [command [command options]]
  
  VERSION:
    1.0.0
  
  DESCRIPTION:
    Generate Gleam/Lustre wrappers for M3E Expressive components
  
  COMMANDS:
    version, v  print the version
    help, h     Shows a list of commands or help for one command
  
  GLOBAL OPTIONS:
    --no-code                                                        Do not generate the Gleam wrappers
    --no-metrics                                                     Do not capture or report metrics
    --no-tests                                                       Do not generate the unit tests
    --destination value, --dest value                                Folder to output generated Gleam/Lustre wrappers [$DESTINATION]
    --m3e-source value, --m3e value                                  Folder containing M3E Expressive component source files [$M3E_SOURCE]
    --trace string [ --trace string ]                                comma-separated list of trace areas ["all" for every possible area]
    --verbose, -V                                                    verbose output
    --config string, --cfg string [ --config string, --cfg string ]  comma-separated list of path(s) to configuration file(s)
    --json, -J                                                       output should be JSON format
    --log loglevel                                                   logging level (slog values plus LevelTrace) (default: TRACE)
    --help, -h                                                       show help
    --version, -v                                                    print the version
```

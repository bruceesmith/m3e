# m3e

[![Package Version](https://img.shields.io/hexpm/v/m3e)](https://hex.pm/packages/m3e)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/m3e/)

**m3e** is a set of Gleam/Lustre wrappers for [M3E — Material 3 Expressive components](https://matraic.github.io/m3e/#/getting-started/overview.html)

Currently m3e provides Gleam functions for a small subset of the M3E components
- Button
- Button Group
- Card
- Checkbox
- Chip
- Chip Set
- Divider
- Form Field
- Heading
- Icon
- Progress Indicator
- Switch
- Theme
- Tooltip

Each M3E component is represented by a Gleam type, has at least
- a validating constructor function (lowercased type name) - for example _button.button(...)_
- an _element_ function which creates a Lustre Element from the Gleam type

In many cases there is also a _basic(..)_ function which creates a type instance using default values.

Every type has helper functions which take an existing type instance, and return a new instance with one of the fields of the input updated. As such, these functions are designed to be used with Gleam's pipe operator, e.g.
```gleam
  import m3e/button

  let b = button.basic("Press me", button.Filled) |> button.shape(button.Square)
```

Further documentation can (_eventually_) be found at <https://hexdocs.pm/m3e>.

## Installation into a Gleam/Lustre project

```sh
gleam add m3e@1
mkdir -p dist
cd dist
npm i @m3e/all
```

## Development

### index.html

### Examples

The _examples/_ folder contains a showcase application which attempts to replicate each of the M3E demonstration cases in the Gleam/Lustre context.

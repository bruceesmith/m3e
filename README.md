# m3e

[![Package Version](https://img.shields.io/hexpm/v/m3e)](https://hex.pm/packages/m3e)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/m3e/)

**m3e** is a set of Gleam/Lustre wrappers for [M3E — Material 3 Expressive components](https://matraic.github.io/m3e/#/getting-started/overview.html)

Currently m3e provides Gleam functions for a small subset of the M3E components
- Accordion
- App Bar
- Auto Complete
- Button
- Button Group
- Card
- Checkbox
- Chip
- Chip Set
- Dialog
- Divider
- Drawer Container
- Expansion Panel
- Form Field
- Heading
- Icon
- Icon Button
- Nav Menu
- Option
- Progress Indicator
- Switch
- Theme
- Tooltip

Each M3E component is represented by a Gleam type, has
- a constructor function _new(...), or, in special cases, bespoke constructors (such as _circular()_ and _linear()_ in ProgressIndicator)
- a _render()_ function which creates a Lustre Element from the Gleam type
- setter functions which return a new record with one of the fields of the input record updated. As such, these functions are designed to be used in the
Builder Pattern with Gleam's pipe operator, e.g.
```gleam
  import m3e/button

  let b = button.new("Press me", button.Filled) |> button.shape(button.Square)
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

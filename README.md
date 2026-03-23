# m3e

[![Package Version](https://img.shields.io/hexpm/v/m3e)](https://hex.pm/packages/m3e)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/m3e/)

## Overview

**m3e** is a set of Gleam/Lustre wrappers for [M3E — Material 3 Expressive components](https://matraic.github.io/m3e/#/getting-started/overview.html)


**m3e** provides Gleam functions for all of the M3E components

Each M3E component is represented by a Gleam type, has
- a constructor function _new(...)_, or, in special cases, bespoke constructors (such as _circular()_ and _linear()_ in ProgressIndicator)
- a _render()_ function which creates a Lustre Element from the Gleam type
- setter functions which return a new record with one of the fields of the input record updated. As such, these functions are designed to be used in the [Builder Pattern](https://dev.to/mrcaidev/design-patterns-in-functional-programming-4aah) with Gleam's pipe operator
- where there are 3 or more fields in the opaque record of each component (and hence 3 or more setter functions), support is
provided for the [Config Record](https://tour.gleam.run/data-types/records/) pattern, i.e. a _Config_ type, and _default_config()_, _from_config()_, and _render_config()_ functions

## Builder Pattern example:

```gleam
  import m3e/button

  let b = button.new("Press me", button.Filled) |> button.shape(button.Square)
```

## Config Record example

```gleam
  import lustre/element
  import m3e/card

  card.render_config(
    card.Config(..card.default_config(), variant: card.Outlined),
    [card.slot(card.Content)],
    [element.text("This is a card")],
  )

````

Further documentation can be found at <https://hexdocs.pm/m3e>.

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

The _examples/_ folder contains a showcase application which will _eventually_ replicate each of the M3E demonstration cases in the Gleam/Lustre context.

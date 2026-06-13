# m3e

[![Package Version](https://img.shields.io/hexpm/v/m3e)](https://hex.pm/packages/m3e)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/m3e/)

Version 2.3.4 of this software is aligned with v2.5.11 of [M3E](https://github.com/matraic/m3e).

### 2.3.4
- Theme now has a ThemeVariant 
- added ThemeIcon

### 2.3.3
- no API changes

### 2.3.2
- no API changes

### 2.3.1
- no API changes

### 2.3.0
- Tabs: disable_pagination changed from boolean to string

### 2.2.0
- DatePicker: add `range` - Whether a range of dates can be selected

### 2.1.0
- Collapsible: updated with the new attributes `orientation` and `no_animate`

## Overview

**m3e** is a set of Gleam/Lustre wrappers for [M3E — Material 3 Expressive components](https://matraic.github.io/m3e/#/getting-started/overview.html)

**m3e** provides Gleam functions for all of the M3E components

Each M3E component is represented by a Gleam type, has
- a constructor function _new(...)_
- a _render()_ function which creates a Lustre Element from the Gleam type
- setter functions which return a new record with one of the fields of the input record updated. As such, these functions are designed to be used in the [Builder Pattern](https://dev.to/mrcaidev/design-patterns-in-functional-programming-4aah) with Gleam's pipe operator
- where there are 2 or more fields in the opaque record of each component (and hence 2 or more setter functions), support is
provided for the [Config Record](https://tour.gleam.run/data-types/records/) pattern, i.e. a _Config_ type, and _default_config()_, _from_config()_, and _render_config()_ functions

## Builder Pattern example:

```gleam
  import m3e/button

  let b = button.new()
    |> button.size(button_size.ExtraSmall)
    |> button.variant(button_variant.Tonal)
    |> button.render([], [element.text("Extra Small")]),
```

## Config Record example

```gleam
  import lustre/element
  import m3e/card

  card.render_config(
    card.Config(..card.default_config(), variant: card_variant.Outlined),
    [],
    [html.div([card.slot(card.Content)], [element.text("This is a card")])],

  )

````
## Breaking changes from version 1.*

Version 1.* of this software was hand-written. Version 2.* is machine generated from a Custom
Element Manifest supplied with each new release of [Material 3 Expressive](https://github.com/matraic/m3e). As such, the Gleam
API more closely follows the Manifest (and hence the documented M3E components) than did version 1.*

## Further documentation 

<https://hexdocs.pm/m3e>

## Installation into a Gleam/Lustre project

```sh
gleam add m3e@2
```

### Examples

The _examples/_ folder contains a showcase application which will _eventually_ replicate each of the M3E demonstration cases in the Gleam/Lustre context.

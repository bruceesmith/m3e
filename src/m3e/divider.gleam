//// divider provides Lustre support for the [M3E Divider component](https://matraic.github.io/m3e/#/components/divider.html)

import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}
import m3e/types.{type Orientation, Vertical, default_orientation}

// --- Types ---

/// Divider holds all the values necessary to construct am M3E Divider
///
pub opaque type Divider {
  Divider(inset: Option(Inset), vertical: Orientation)
}

/// Inset determines if one or both ends of the divder are inset
///
pub type Inset {
  Both
  End
  Start
}

pub const default_inset: Option(Inset) = None

//
// --- CONFIGURATION ---

// --- CONSTRUCTORS ---

/// new creates a new Divider
///
pub fn new() -> Divider {
  Divider(inset: default_inset, vertical: default_orientation)
}

// --- SETTERS ---

/// inset sets the `inset` field
///
pub fn inset(divider: Divider, inset: Option(Inset)) -> Divider {
  Divider(..divider, inset: inset)
}

// vertical sets the `vertical` field
pub fn vertical(divider: Divider, vertical: Orientation) -> Divider {
  Divider(..divider, vertical: vertical)
}

// --- RENDERING ---

/// render creates an HTML m3e-divider component
///
pub fn render(
  divider: Divider,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  element(
    "m3e-divider",
    list.append(
      [
        option_attribute(divider.inset, inset_to_string, fn(_) { "" }, None),
        boolean_attribute("vertical", divider.vertical == Vertical),
      ]
        |> list.filter(fn(a) { a != none() }),
      attributes,
    ),
    [],
  )
}

// --- PRIVATE HELPER FUNCTIONS ---

fn inset_to_string(inset: Inset) -> String {
  case inset {
    Both -> "inset"
    End -> "inset-end"
    Start -> "inset-start"
  }
}

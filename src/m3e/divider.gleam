//// divider provides Lustre support for the [M3E Divider component](https://matraic.github.io/m3e/#/components/divider.html)
///// inset_end sets the `inset_end` field
////

import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/layout.{type Orientation}

// --- Types ---

/// Divider holds all the values necessary to construct am M3E Divider
///
/// ## Fields:
/// - inset: Whether the divider is indented with equal padding on both sides
/// - inset_start: Whether the divider is indented with padding on the leading side
/// - inset_end: Whether the divider is indented with padding on the trailing side
/// - vertical: Whether the divider is vertically aligned with adjacent content
///
pub opaque type Divider {
  Divider(
    inset: Option(Inset),
    inset_start: Indentation,
    inset_end: Indentation,
    vertical: Orientation,
  )
}

/// Inset determines if one or both ends of the divder are inset
///
pub type Inset {
  Both
  End
  Start
}

pub const default_inset: Option(Inset) = None

pub type Indentation {
  Indented
  NotIndented
}

pub const default_indentation: Indentation = NotIndented

//
// --- CONFIGURATION ---

// --- CONSTRUCTORS ---

/// new creates a new Divider
///
pub fn new() -> Divider {
  Divider(
    inset: default_inset,
    inset_start: default_indentation,
    inset_end: default_indentation,
    vertical: layout.default_orientation,
  )
}

// --- SETTERS ---

/// inset sets the `inset` field
///
pub fn inset(divider: Divider, inset: Option(Inset)) -> Divider {
  Divider(..divider, inset: inset)
}

pub fn inset_end(divider: Divider, inset_end: Indentation) -> Divider {
  Divider(..divider, inset_end: inset_end)
}

/// inset_start sets the `inset_start` field
///
pub fn inset_start(divider: Divider, inset_start: Indentation) -> Divider {
  Divider(..divider, inset_start: inset_start)
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
  element.element(
    "m3e-divider",
    list.append(
      [
        helpers.option_attribute(
          divider.inset,
          inset_to_string,
          fn(_) { "" },
          None,
        ),
        helpers.boolean_attribute(
          "inset-start",
          divider.inset_start == Indented,
        ),
        helpers.boolean_attribute("inset-end", divider.inset_end == Indented),
        helpers.boolean_attribute(
          "vertical",
          divider.vertical == layout.Vertical,
        ),
      ]
        |> list.filter(fn(a) { a != attribute.none() }),
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

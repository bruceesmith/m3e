//// button provides Lustre support for the [M3E Divider component](https://matraic.github.io/m3e/#/components/divider.html)

import gleam/option.{type Option, None}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// Inset determines if one or both ends of the divder are inset
///
pub type Inset {
  Both
  End
  Start
}

fn inset_to_string(inset: Inset) -> String {
  case inset {
    Both -> "inset"
    End -> "inset-end"
    Start -> "inset-start"
  }
}

/// Divider holds all the values necessary to construct am M3E Divider
///
pub type Divider {
  Divider(inset: Option(Inset), vertical: Bool)
}

/// divider creates a new Divider
///
pub fn divider(inset: Option(Inset), vertical: Bool) -> Divider {
  Divider(inset: inset, vertical: vertical)
}

/// element creates an HTML m3e-divider component
///
pub fn element(divider: Divider) -> Element(msg) {
  element.element(
    "m3e-divider",
    [
      option_attribute(divider.inset, inset_to_string, fn(_) { "" }, None),
      boolean_attribute("vertical", divider.vertical),
    ],
    [],
  )
}

/// inset sets the `inset` field
///
pub fn inset(divider: Divider, inset: Option(Inset)) -> Divider {
  Divider(..divider, inset: inset)
}

// vertical sets the `vertical` field
pub fn vertical(divider: Divider, vertical: Bool) -> Divider {
  Divider(..divider, vertical: vertical)
}

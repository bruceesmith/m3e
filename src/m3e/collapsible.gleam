//// Collapsible is a container used to expand and collapse content.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr

// --- Types ---

/// Collapsible is a View Model for this component
///
/// ## Fields:
///
/// - open: Whether content is visible.
///
pub opaque type Collapsible {
  Collapsible(open: Open)
}

/// Open is whether content is visible.
///
pub type Open {
  IsOpen
  IsNotOpen
}

// --- Defaults ---

pub const default_open: Open = IsNotOpen

// --- Constructors ---

/// new creates a new Collapsible with the default configuration.
///
pub fn new(open: Open) -> Collapsible {
  Collapsible(open: open)
}

// --- Setters ---

/// open sets the value of open for this Collapsible.
///
pub fn open(_: Collapsible, open: Open) -> Collapsible {
  Collapsible(open: open)
}

// --- Renderers ---

/// render creates a Lustre Element for a Collapsible
///
pub fn render(
  model: Collapsible,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-collapsible",
    list.flatten([
      [
        attr.boolean("open", model.open == IsOpen),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

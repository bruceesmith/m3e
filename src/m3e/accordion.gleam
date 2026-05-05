//// Accordion is combines multiple expansion panels in to an accordion.
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

/// Accordion is a View Model for this component
///
/// ## Fields:
///
/// - multi: Whether multiple expansion panels can be open at the same time.
///
pub opaque type Accordion {
  Accordion(multi: Multi)
}

/// Multi is whether multiple expansion panels can be open at the same time.
///
pub type Multi {
  IsMulti
  IsNotMulti
}

// --- Defaults ---

pub const default_multi: Multi = IsNotMulti

// --- Constructors ---

/// new creates a new Accordion with the default configuration.
///
pub fn new(multi: Multi) -> Accordion {
  Accordion(multi: multi)
}

// --- Setters ---

/// multi sets the value of multi for this Accordion.
///
pub fn multi(_: Accordion, multi: Multi) -> Accordion {
  Accordion(multi: multi)
}

// --- Renderers ---

/// render creates a Lustre Element for a Accordion
///
pub fn render(
  model: Accordion,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-accordion",
    list.flatten([
      [
        attr.boolean("multi", model.multi == IsMulti),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

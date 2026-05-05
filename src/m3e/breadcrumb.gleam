//// Breadcrumb is displays a hierarchical navigation path and identifies the user's
//// //// current location within an application.
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

/// Breadcrumb is a View Model for this component
///
/// ## Fields:
///
/// - wrap: Whether items wrap to a new line.
///
pub opaque type Breadcrumb {
  Breadcrumb(wrap: Wrap)
}

/// Wrap is whether items wrap to a new line.
///
pub type Wrap {
  IsWrap
  IsNotWrap
}

// --- Defaults ---

pub const default_wrap: Wrap = IsNotWrap

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Separator
  // Renders a custom separator between breadcrumb items.
}

// --- Constructors ---

/// new creates a new Breadcrumb with the default configuration.
///
pub fn new(wrap: Wrap) -> Breadcrumb {
  Breadcrumb(wrap: wrap)
}

// --- Setters ---

/// wrap sets the value of wrap for this Breadcrumb.
///
pub fn wrap(_: Breadcrumb, wrap: Wrap) -> Breadcrumb {
  Breadcrumb(wrap: wrap)
}

// --- Renderers ---

/// render creates a Lustre Element for a Breadcrumb
///
pub fn render(
  model: Breadcrumb,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-breadcrumb",
    list.flatten([
      [
        attr.boolean("wrap", model.wrap == IsWrap),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Separator -> attribute.attribute("slot", "separator")
  }
}

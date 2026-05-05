//// TextOverflow is an inline container which presents an ellipsis when content overflows.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

// --- Types ---

/// TextOverflow is a View Model for this component
///
pub opaque type TextOverflow {
  TextOverflow
}

// --- Defaults ---

// --- Constructors ---

/// new creates a new TextOverflow with the default configuration.
///
pub fn new() -> TextOverflow {
  TextOverflow
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a TextOverflow
///
pub fn render(
  _: TextOverflow,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-text-overflow", attributes, children)
}

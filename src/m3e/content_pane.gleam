//// ContentPane is a shaped surface for vertically scrollable content.
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

/// ContentPane is a View Model for this component
///
pub opaque type ContentPane {
  ContentPane
}

// --- Defaults ---

// --- Constructors ---

/// new creates a new ContentPane with the default configuration.
///
pub fn new() -> ContentPane {
  ContentPane
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a ContentPane
///
pub fn render(
  _: ContentPane,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-content-pane", attributes, children)
}

//// NavMenu is a hierarchical menu, typically used on larger devices, that allows a user to switch between views.
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

/// NavMenu is a View Model for this component
///
pub opaque type NavMenu {
  NavMenu
}

// --- Defaults ---

// --- Constructors ---

/// new creates a new NavMenu with the default configuration.
///
pub fn new() -> NavMenu {
  NavMenu
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a NavMenu
///
pub fn render(
  _: NavMenu,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-nav-menu", attributes, children)
}

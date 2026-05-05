//// MenuItemGroup is groups related items (such a radios) in a menu.
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

/// MenuItemGroup is a View Model for this component
///
pub opaque type MenuItemGroup {
  MenuItemGroup
}

// --- Defaults ---

// --- Constructors ---

/// new creates a new MenuItemGroup with the default configuration.
///
pub fn new() -> MenuItemGroup {
  MenuItemGroup
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a MenuItemGroup
///
pub fn render(
  _: MenuItemGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-menu-item-group", attributes, children)
}

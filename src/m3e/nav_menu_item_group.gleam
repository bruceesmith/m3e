//// NavMenuItemGroup is a top-level semantic grouping of items in a navigation menu.
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

/// NavMenuItemGroup is a View Model for this component
///
pub opaque type NavMenuItemGroup {
  NavMenuItemGroup
}

// --- Defaults ---

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Label
  // Renders the label of the group.
}

// --- Constructors ---

/// new creates a new NavMenuItemGroup with the default configuration.
///
pub fn new() -> NavMenuItemGroup {
  NavMenuItemGroup
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a NavMenuItemGroup
///
pub fn render(
  _: NavMenuItemGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-nav-menu-item-group", attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Label -> attribute.attribute("slot", "label")
  }
}

//// OptGroup is groups options under a subheading.
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

/// OptGroup is a View Model for this component
///
pub opaque type OptGroup {
  OptGroup
}

// --- Defaults ---

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Label
  // Renders the label of the group.
}

// --- Constructors ---

/// new creates a new OptGroup with the default configuration.
///
pub fn new() -> OptGroup {
  OptGroup
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a OptGroup
///
pub fn render(
  _: OptGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-optgroup", attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Label -> attribute.attribute("slot", "label")
  }
}

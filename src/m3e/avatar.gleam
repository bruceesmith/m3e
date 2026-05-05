//// Avatar is an image, icon or textual initials representing a user or other identity.
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

/// Avatar is a View Model for this component
///
pub opaque type Avatar {
  Avatar
}

// --- Defaults ---

// --- Constructors ---

/// new creates a new Avatar with the default configuration.
///
pub fn new() -> Avatar {
  Avatar
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a Avatar
///
pub fn render(
  _: Avatar,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-avatar", attributes, children)
}

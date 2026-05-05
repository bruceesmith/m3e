//// NavRailToggle is an element, nested within a clickable element, used to toggle the expanded state of a navigation rail.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr

// --- Types ---

/// NavRailToggle is a View Model for this component
///
/// ## Fields:
///
/// - for: The identifier of the interactive control to which this element is attached.
///
pub opaque type NavRailToggle {
  NavRailToggle(for: Option(String))
}

// --- Defaults ---

pub const default_for: Option(String) = None

// --- Constructors ---

/// new creates a new NavRailToggle with the default configuration.
///
pub fn new(for: Option(String)) -> NavRailToggle {
  NavRailToggle(for: for)
}

// --- Setters ---

/// for sets the value of for for this NavRailToggle.
///
pub fn for(_: NavRailToggle, for: Option(String)) -> NavRailToggle {
  NavRailToggle(for: for)
}

// --- Renderers ---

/// render creates a Lustre Element for a NavRailToggle
///
pub fn render(
  model: NavRailToggle,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-nav-rail-toggle",
    list.flatten([
      [
        attr.option(model.for, fn(_) { "for" }, function.identity, default_for),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

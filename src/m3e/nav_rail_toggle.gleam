//// nav_rail_toggle provides Lustre support for the [M3E Nav Rail Toggle component](https://matraic.github.io/m3e/#/components/nav-rail.html)

import lustre/attribute
import lustre/element.{type Element, element}

// --- Types ---

/// NavRailToggle is an element, nested within a clickable element, used to toggle the expanded state of a navigation rail.
///
/// ## Fields:
/// - for: the identifier of the interactive control to which this element is attached
///
pub opaque type NavRailToggle {
  NavRailToggle(for: String)
}

// --- CONSTRUCTORS ---

/// new creates a NavRailToggle
///
pub fn new(for: String) -> NavRailToggle {
  NavRailToggle(for: for)
}

// --- SETTERS ---

/// for sets the for field
///
pub fn for(_: NavRailToggle, for: String) -> NavRailToggle {
  NavRailToggle(for: for)
}

// --- RENDERERING ---

/// render creates a Lustre Element from a NavRailToggle
///
pub fn render(m: NavRailToggle) -> Element(msg) {
  element("m3e-nav-rail-toggle", [attribute.for(m.for)], [])
}

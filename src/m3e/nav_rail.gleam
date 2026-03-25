//// nav_rail provides Lustre support for the [M3E Nav Rail component](https://matraic.github.io/m3e/#/components/nav-rail.html)

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}

// --- Types ---

/// Mode is the mode in which items in the rail are presented
/// 
pub type Mode {
  Auto
  Compact
  Expanded
}

pub const default_mode = Auto

/// NavRail extends NavBar to provide a vertical navigation rail and interactive items for switching 
/// between primary destinations in an application
/// 
/// ## Fields:
/// - mode: The mode in which items in the rail are presented
/// 
pub opaque type NavRail {
  NavRail(mode: Mode)
}

// --- CONSTRUCTORS ---

/// new creates a NavRail
///
pub fn new() -> NavRail {
  NavRail(mode: default_mode)
}

// --- SETTERS ---

/// mode sets the mode field
/// 
pub fn mode(_: NavRail, mode: Mode) -> NavRail {
  NavRail(mode: mode)
}

// --- RENDERING ---

/// render creates a Lustre Element from a NavRail
/// 
pub fn render(
  m: NavRail,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-nav-rail",
    [attribute("mode", mode_to_string(m.mode)), ..attributes],
    children,
  )
}

// --- PRIVATE HELPER FUNCTIONS ---

fn mode_to_string(mode: Mode) -> String {
  case mode {
    Auto -> "auto"
    Compact -> "compact"
    Expanded -> "expanded"
  }
}

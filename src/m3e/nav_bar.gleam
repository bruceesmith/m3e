//// nav_bar provides Lustre support for the [M3E Nav Bar component](https://matraic.github.io/m3e/#/components/nav-bar.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

// --- Types ---

/// Mode specifies the possible modes in which to present items in a navigation bar
pub type Mode {
  Auto
  Compact
  Expanded
}

/// NavBar provides Lustre support for the [M3E Nav Bar component](https://matraic.github.io/m3e/#/components/nav-bar.html)
/// 
/// ## Fields:
/// - mode: the possible modes in which to present items in a navigation bar
///
pub opaque type NavBar {
  NavBar(mode: Mode)
}

// --- CONSTRUCTORS ---

/// new creates a new NavBar
/// 
pub fn new() -> NavBar {
  NavBar(mode: Compact)
}

// --- SETTERS ---

/// mode sets the mode field
/// 
pub fn mode(_: NavBar, mode: Mode) -> NavBar {
  NavBar(mode: mode)
}

// --- RENDERERING ---

/// render creates a Lustre Element(msg) from a NavBar
/// 
/// ## Parameters:
/// - bar: a NavBar
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  bar: NavBar,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-nav-bar",
    flatten([
      [
        attribute("mode", mode_to_string(bar.mode)),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != attribute.none() }),
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

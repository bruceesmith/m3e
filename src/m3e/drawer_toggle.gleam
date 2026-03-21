//// drawer_toggle provides Lustre support for the [M3E Drawer Toggle component](https://matraic.github.io/m3e/#/components/drawer_container.html)

import gleam/list
import lustre/attribute.{type Attribute, for, none}
import lustre/element.{type Element, element}

// --- Types ---

/// DrawerToggle toggles the opened state of a drawer
/// 
/// ## Fields:
/// - for: the id of the drawer to toggle
/// 
pub opaque type DrawerToggle {
  DrawerToggle(for: String)
}

// --- CONSTRUCTORS ---

/// new creates a DrawerToggle
/// 
/// ## Parameters:
/// - for: the id of the drawer to toggle
/// 
pub fn new(for: String) -> DrawerToggle {
  DrawerToggle(for: for)
}

// --- RENDERING ---

/// render creates a Lustre Element from a DrawerToggle
///
/// ## Parameters:
/// - c: a DrawerToggle
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn render(
  c: DrawerToggle,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-drawer-toggle",
    [for(c.for), ..attributes]
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

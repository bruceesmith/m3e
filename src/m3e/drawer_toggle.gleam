//// drawer_container provides Lustre support for the [M3E Drawer Toggle component](https://matraic.github.io/m3e/#/components/drawer_container.html)

import gleam/list
import lustre/attribute.{type Attribute, for, none}
import lustre/element.{type Element}

/// DrawerToggle toggles the opened state of a drawer
/// 
/// ## Fields:
/// - for: the id of the drawer to toggle
/// 
pub opaque type DrawerToggle {
  DrawerToggle(for: String)
}

/// drawer_toggle creates a DrawToggle
/// 
/// ## Parameters:
/// - for: the id of the drawer to toggle
/// 
pub fn drawer_toggle(for: String) -> DrawerToggle {
  DrawerToggle(for: for)
}

/// render creates a Lustre Element from a DrawToggle
///
/// ## Parameters:
/// - c: a DrawToggle
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn render(
  c: DrawerToggle,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-drawer-toggle",
    [for(c.for), ..attributes]
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

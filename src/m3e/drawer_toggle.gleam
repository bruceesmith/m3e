//// drawer_container provides Lustre support for the [M3E Drawer Toggle component](https://matraic.github.io/m3e/#/components/drawer_container.html)

import lustre/attribute.{type Attribute, for}
import lustre/element.{type Element}

/// DrawToggle toggles the opened state of a drawer
/// 
/// ## Fields:
/// - for: the id of the drawer to toggle
/// 
pub type DrawToggle {
  DrawToggle(for: String)
}

/// draw_toggle creates a DrawToggle
/// 
/// ## Parameters:
/// - for: the id of the drawer to toggle
/// 
pub fn draw_toggle(for: String) -> DrawToggle {
  DrawToggle(for: for)
}

/// element creates a Lustre Element from a DrawToggle
///
/// ## Parameters:
/// - c: a DrawToggle
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn element(
  c: DrawToggle,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-drawer-toggle", [for(c.for), ..attributes], children)
}

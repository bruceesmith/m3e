//// nav_menu_item_group provides Lustre support for the [M3E Nav Menu Item Group component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

import m3e/heading

// --- Types ---

/// nav_menu_item_group
/// 
/// ## Fields:
/// - heading: Renders the label of the group
/// 
pub opaque type NavMenuItemGroup {
  NavMenuItemGroup(heading: String)
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Label
  // Renders the label of the group
}

// --- CONSTRUCTORS ---

/// new creates a nav-menu-item-group
///
/// ## Parameters:
/// - heading: Renders the label of the group
/// 
pub fn new(heading: String) -> NavMenuItemGroup {
  NavMenuItemGroup(heading: heading)
}

// --- SETTERS ---

/// heading sets the heading of the group
///
pub fn heading(_group: NavMenuItemGroup, heading: String) -> NavMenuItemGroup {
  NavMenuItemGroup(heading: heading)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a NavMenuItemGroup
///
/// ## Parameters:
/// - group: a NavMenuItemGroup
/// - attributes: additional attributes
/// - children: nested nav_menu_items and possible one or more dividers
/// 
pub fn render(
  group: NavMenuItemGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element("m3e-nav-menu-item-group", attributes, [
    heading.new(group.heading)
      |> heading.size(heading.Large)
      |> heading.variant(heading.Label)
      |> heading.render([slot(Label)]),
    ..children
  ])
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Label -> attribute("slot", "group-label")
  }
}

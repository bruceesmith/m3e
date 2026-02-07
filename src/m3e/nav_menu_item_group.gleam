//// nav_menu_item_group provides Lustre support for the [M3E Nav Menu Item Group component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import lustre/attribute.{type Attribute}
import lustre/element.{type Element, element}

import m3e/heading
import m3e/helpers.{slot}

/// nav_menu_item_group
/// 
/// ## Fields:
/// - heading: Renders the label of the group
/// 
pub opaque type NavMenuItemGroup {
  NavMenuItemGroup(heading: String)
}

/// new creates a nav-menu-item-group
///
/// ## Parameters:
/// - heading: Renders the label of the group
/// 
pub fn new(heading: String) -> NavMenuItemGroup {
  NavMenuItemGroup(heading: heading)
}

/// heading sets the heading of the group
///
pub fn heading(_group: NavMenuItemGroup, heading: String) -> NavMenuItemGroup {
  NavMenuItemGroup(heading: heading)
}

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
      |> heading.render([slot("label")]),
    ..children
  ])
}

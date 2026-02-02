//// nav_menu_item_group provides Lustre support for the [M3E Nav Menu Item Group component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}

import m3e/heading

/// nav_menu_item_group
/// 
/// ## Fields:
/// - heading: Renders the label of the group
/// 
pub opaque type NavMenuItemGroup {
  NavMenuItemGroup(heading: String)
}

/// nav_menu_item_group creates a nav-menu-item-group
///
/// ## Parameters:
/// - heading: Renders the label of the group
/// 
pub fn nav_menu_item_group(heading: String) -> NavMenuItemGroup {
  NavMenuItemGroup(heading: heading)
}

/// heading sets the heading of the group
///
pub fn heading(_group: NavMenuItemGroup, heading: String) -> NavMenuItemGroup {
  NavMenuItemGroup(heading: heading)
}

/// element creates a Lustre Element(msg) from a NavMenuItemGroup
///
/// ## Parameters:
/// - group: a NavMenuItemGroup
/// - attributes: additional attributes
/// - children: nested nav_manu_items and possible one or more dividers
/// 
pub fn element(
  group: NavMenuItemGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-nav-menu-item-group", attributes, [
    heading.basic(group.heading)
      |> heading.size(heading.Large)
      |> heading.variant(heading.Label)
      |> heading.element([attribute("slot", "label")]),
    ..children
  ])
}

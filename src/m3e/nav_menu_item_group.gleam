//// nav_menu_item_group provides Lustre support for the [M3E Nav Menu Item Group component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

/// nav_menu_item_group
/// 
pub type NavMenuItemGroup {
  NavMenuItemGroup
}

/// nav_menu_item_group creates a nav-menu-item-group
///
pub fn nav_menu_item_group() -> NavMenuItemGroup {
  NavMenuItemGroup
}

/// element creates a Lustre Element(msg) from a NavMenuItemGroup
///
pub fn element(
  _group: NavMenuItemGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-nav-menu-item-group", attributes, children)
}

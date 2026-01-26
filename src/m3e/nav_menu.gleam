//// nav_menu provides Lustre support for the [M3E Nav Menu component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

/// NavMenu provides Lustre support for the [M3E Nav Menu component](https://matraic.github.io/m3e/#/components/navmenu.html)
/// 
pub type NavMenu {
  NavMenu
}

/// nav_menu creates an HTML m3e-nav-menu component
///
pub fn nav_menu() -> NavMenu {
  NavMenu
}

/// element creates an HTML m3e-nav-menu component from a NavMenu
///
pub fn element(
  _nav_menu: NavMenu,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-nav-menu", attributes, children)
}

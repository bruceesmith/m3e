//// nav_menu provides Lustre support for the [M3E Nav Menu component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import lustre/attribute.{type Attribute}
import lustre/element.{type Element, element}

/// NavMenu provides Lustre support for the [M3E Nav Menu component](https://matraic.github.io/m3e/#/components/navmenu.html)
/// 
pub opaque type NavMenu {
  NavMenu
}

/// new creates an HTML m3e-nav-menu component
///
pub fn new() -> NavMenu {
  NavMenu
}

/// render creates an HTML m3e-nav-menu component from a NavMenu
///
pub fn render(
  _nav_menu: NavMenu,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element("m3e-nav-menu", attributes, children)
}

//// menu_item_group provides Lustre support for the [M3E Menu Item Group component](https://matraic.github.io/m3e/#/components/menu.html)

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

// --- Types ---

/// MenuIteMGroup groups related items (such a radios) in a menu
/// 
pub opaque type MenuItemGroup {
  MenuItemGroup
}

// -- CONSTRUCTORS ---

/// new creates a new MenuItemGroup
/// 
pub fn new() -> MenuItemGroup {
  MenuItemGroup
}

// --- RENDERING ---

/// render creates a Lustre Element from a MenuItemGroup
///
pub fn render(
  _: MenuItemGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-menu-item-group", attributes, children)
}

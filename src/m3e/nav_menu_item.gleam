//// nav_menu_item provides Lustre support for the [M3E Nav Menu Item component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}

/// nav_menu_item provides Lustre support for the [M3E Nav Menu Item component](https://matraic.github.io/m3e/#/components/nav-menu.html)
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - open: Whether the item is expanded
/// - selected: Whether the element is selected
///
pub type NavMenuItem {
  NavMenuItem(disabled: Bool, open: Bool, selected: Bool)
}

/// nav_menu_item creates a nav-menu-item
///
/// ## Parameters:
/// - disabled: Whether the element is disabled
/// - open: Whether the item is expanded
/// - selected: Whether the element is selected
/// 
pub fn nav_menu_item(disabled: Bool, open: Bool, selected: Bool) -> NavMenuItem {
  NavMenuItem(disabled: disabled, open: open, selected: selected)
}

/// element creates a Lustre Element(msg) from a NavMenuItem
///
pub fn element(
  item: NavMenuItem,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-nav-menu-item",
    [
      boolean_attribute("disabled", item.disabled),
      boolean_attribute("open", item.open),
      boolean_attribute("selected", item.selected),
      ..attributes
    ],
    children,
  )
}

//// loading_indicator provides Lustre support for the [M3E Menu Trigger component](https://matraic.github.io/m3e/#/components/menu.html)

import lustre/attribute
import lustre/element.{type Element, element}

/// MenuTrigger is an element, nested within a clickable element, used to open a menu
/// 
/// ## Fields:
/// - for: the id of the associated m3e-menu element
/// 
pub opaque type MenuTrigger {
  MenuTrigger(for: String)
}

/// new creates a new MenuTrigger
/// 
pub fn new(for: String) -> MenuTrigger {
  MenuTrigger(for: for)
}

/// render creates a Lustre Element from a MenuTrigger
///
pub fn render(m: MenuTrigger) -> Element(msg) {
  element("m3e-menu-trigger", [attribute.for(m.for)], [])
}

/// for sets the for field
///
pub fn for(_: MenuTrigger, for: String) -> MenuTrigger {
  MenuTrigger(for: for)
}

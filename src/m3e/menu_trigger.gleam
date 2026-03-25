//// menu_trigger provides Lustre support for the [M3E Menu Trigger component](https://matraic.github.io/m3e/#/components/menu.html)

import lustre/attribute
import lustre/element.{type Element}

// --- Types ---

/// MenuTrigger is an element, nested within a clickable element, used to open a menu
/// 
/// ## Fields:
/// - for: the id of the associated m3e-menu element
/// 
pub opaque type MenuTrigger {
  MenuTrigger(for: String)
}

// --- CONSTRUCTORS ---

/// new creates a new MenuTrigger
/// 
pub fn new(for: String) -> MenuTrigger {
  MenuTrigger(for: for)
}

// --- SETTERS ---

/// for sets the for field
///
pub fn for(_: MenuTrigger, for: String) -> MenuTrigger {
  MenuTrigger(for: for)
}

// --- RENDERERING ---

/// render creates a Lustre Element from a MenuTrigger
///
pub fn render(m: MenuTrigger) -> Element(msg) {
  element.element("m3e-menu-trigger", [attribute.for(m.for)], [])
}

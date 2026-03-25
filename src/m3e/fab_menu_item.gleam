/// fab_menu_item provides Lustre support for the [M3E FAB Menu Item component](https://matraic.github.io/m3e/#/components/fab-menu.html)
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/link.{type Link}

// --- Types ---

/// FabMenuItem is an item of a floating action button (FAB) menu
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - link: Whether the Item acts as a Link
/// 
pub opaque type FabMenuItem {
  FabMenuItem(disabled: Bool, link: Option(Link))
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders an icon before the items's label 
}

// --- CONSTRUCTORS ---

/// new creates a new FabMenuItem
/// 
pub fn new() -> FabMenuItem {
  FabMenuItem(disabled: False, link: None)
}

// --- SETTERS ---

/// disabled sets the disabled field
///
pub fn disabled(f: FabMenuItem, disabled: Bool) -> FabMenuItem {
  FabMenuItem(..f, disabled: disabled)
}

/// link sets the link field
///
pub fn link(f: FabMenuItem, link: Option(Link)) -> FabMenuItem {
  FabMenuItem(..f, link: link)
}

// --- RENDERING ---

/// render creates a Lustre Element from a FabMenuItem
///
pub fn render(
  f: FabMenuItem,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-fab-menu-item",
    list.flatten([
      [
        boolean_attribute("disabled", f.disabled),
      ],
      link.attributes(f.link),
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Icon -> attribute("slot", "icon")
  }
}

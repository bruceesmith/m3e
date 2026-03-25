//// menu_item provides Lustre support for the [M3E Menu Item component](https://matraic.github.io/m3e/#/components/menu.html)

import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/link.{type Link}

// --- Types ---

/// MenuItem is an item of a menu
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - link: Whether the element is a link
/// 
pub opaque type MenuItem {
  MenuItem(disabled: Bool, link: Option(Link))
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders an icon before the items's label 
  TrailingIcon
  // Renders an icon after the item's label 
}

// --- CONSTRUCTORS ---

/// new creates a new MenuItem
/// 
pub fn new() -> MenuItem {
  MenuItem(disabled: False, link: None)
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(m: MenuItem, disabled: Bool) -> MenuItem {
  MenuItem(..m, disabled: disabled)
}

/// link sets the link field
///
/// ## Parameters:
/// - m: a MenuItem
/// - link: a Link
///
pub fn link(m: MenuItem, link: Option(Link)) -> MenuItem {
  MenuItem(..m, link: link)
}

// --- RENDERING ---

/// render creates a Lustre Element from a MenuItem
/// 
pub fn render(
  m: MenuItem,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-menu-item",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", m.disabled),
      ],
      link.attributes(m.link),
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Icon -> attribute.attribute("slot", "icon")
    TrailingIcon -> attribute.attribute("slot", "trailing-icon")
  }
}

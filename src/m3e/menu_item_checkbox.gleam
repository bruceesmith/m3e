//// menu_item_checkbox provides Lustre support for the [M3E Menu Item Checkbox component](https://matraic.github.io/m3e/#/components/menu.html)

import gleam/list.{filter}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// MenuItemCheckbox is an item of a menu which supports a checkable state
/// 
/// ## Fields:
/// - checked: Whether the element is checked
/// - disabled: Whether the element is disabled
///
pub opaque type MenuItemCheckbox {
  MenuItemCheckbox(checked: Bool, disabled: Bool)
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

/// new creates a new MenuItemCheckbox
///
pub fn new() -> MenuItemCheckbox {
  MenuItemCheckbox(checked: False, disabled: False)
}

// --- SETTERS ---

/// checked sets the checked field
///
pub fn checked(m: MenuItemCheckbox, checked: Bool) -> MenuItemCheckbox {
  MenuItemCheckbox(..m, checked: checked)
}

/// disabled sets the disabled field
///
pub fn disabled(m: MenuItemCheckbox, disabled: Bool) -> MenuItemCheckbox {
  MenuItemCheckbox(..m, disabled: disabled)
}

// --- RENDERING ---

/// render creates a Lustre Element from a MenuItemCheckbox
///
pub fn render(
  m: MenuItemCheckbox,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-menu-item-checkbox",
    [
      boolean_attribute("checked", m.checked),
      boolean_attribute("disabled", m.disabled),
      ..attributes
    ]
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Icon -> attribute("slot", "icon")
    TrailingIcon -> attribute("slot", "trailing-icon")
  }
}

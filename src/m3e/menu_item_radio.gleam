//// menu_item_radio provides Lustre support for the [M3E Menu Item Radio component](https://matraic.github.io/m3e/#/components/menu.html)

import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}
import m3e/state.{type CheckedState, Checked}

// --- Types ---

/// MenuItemRadio is an item of a menu which supports a mutually exclusive checkable state
/// 
/// ## Fields:
/// - checked: Whether the element is checked
/// - disabled: Whether the element is disabled
/// 
pub opaque type MenuItemRadio {
  MenuItemRadio(checked: CheckedState, disabled: Bool)
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

/// new creates a new MenuItemRadio
///
pub fn new() -> MenuItemRadio {
  MenuItemRadio(checked: state.default_checked_state, disabled: False)
}

// --- SETTERS ---

/// checked sets the checked field
///
pub fn checked(m: MenuItemRadio, checked: CheckedState) -> MenuItemRadio {
  MenuItemRadio(..m, checked: checked)
}

/// disabled sets the disabled field
///
pub fn disabled(m: MenuItemRadio, disabled: Bool) -> MenuItemRadio {
  MenuItemRadio(..m, disabled: disabled)
}

// --- RENDERING ---

/// render creates a Lustre Element from a MenuItemRadio
///
pub fn render(
  m: MenuItemRadio,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-menu-item-radio",
    [
      boolean_attribute("checked", m.checked == Checked),
      boolean_attribute("disabled", m.disabled),
      ..attributes
    ]
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

//// menu_item_group provides Lustre support for the [M3E Menu Item Group component](https://matraic.github.io/m3e/#/components/menu.html)

import gleam/list.{filter}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

/// MenuItemRadio is an item of a menu which supports a mutually exclusive checkable state
/// 
/// ## Fields:
/// - checked: Whether the element is checked
/// - disabled: Whether the element is disabled
/// 
pub opaque type MenuItemRadio {
  MenuItemRadio(checked: Bool, disabled: Bool)
}

/// new creates a new MenuItemRadio
///
pub fn new() -> MenuItemRadio {
  MenuItemRadio(checked: False, disabled: False)
}

/// render creates a Lustre Element from a MenuItemRadio
///
pub fn render(
  m: MenuItemRadio,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-menu-item-radio",
    [
      boolean_attribute("checked", m.checked),
      boolean_attribute("disabled", m.disabled),
      ..attributes
    ]
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// checked sets the checked field
///
pub fn checked(m: MenuItemRadio, checked: Bool) -> MenuItemRadio {
  MenuItemRadio(..m, checked: checked)
}

/// disabled sets the disabled field
///
pub fn disabled(m: MenuItemRadio, disabled: Bool) -> MenuItemRadio {
  MenuItemRadio(..m, disabled: disabled)
}

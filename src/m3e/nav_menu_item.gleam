//// nav_menu_item provides Lustre support for the [M3E Nav Menu Item component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

import m3e/helpers.{boolean_attribute, slot}
import m3e/icon as ico

/// nav_menu_item provides Lustre support for the [M3E Nav Menu Item component](https://matraic.github.io/m3e/#/components/nav-menu.html)
/// 
/// ## Fields:
/// - badge: Renders the badge of the item
/// - disabled: Whether the element is disabled
/// - icon: Renders the icon of the item
/// - label: Renders the label of the item
/// - open: Whether the item is expanded
/// - selected: Whether the element is selected
///
pub opaque type NavMenuItem {
  NavMenuItem(
    badge: Option(String),
    disabled: Bool,
    icon_name: Option(String),
    label: String,
    open: Bool,
    selected: Bool,
  )
}

/// nav_menu_item creates a nav-menu-item
///
/// ## Parameters:
/// - badge: Renders the badge of the item
/// - disabled: Whether the element is disabled
/// - icon: Renders the icon of the item
/// - label: Renders the label of the item
/// - open: Whether the item is expanded
/// - selected: Whether the element is selected
/// 
pub fn nav_menu_item(
  badge: Option(String),
  disabled: Bool,
  icon_name: Option(String),
  label: String,
  open: Bool,
  selected: Bool,
) -> NavMenuItem {
  NavMenuItem(
    badge: badge,
    disabled: disabled,
    icon_name: icon_name,
    label: label,
    open: open,
    selected: selected,
  )
}

/// badge sets the badge field
/// 
pub fn badge(item: NavMenuItem, badge: Option(String)) -> NavMenuItem {
  NavMenuItem(..item, badge: badge)
}

fn badge_elt(badge: Option(String)) -> Element(msg) {
  case badge {
    None -> element.none()
    Some(s) -> html.span([slot("badge")], [html.text(s)])
  }
}

/// disabled sets the disabled field
/// 
pub fn disabled(item: NavMenuItem, disabled: Bool) -> NavMenuItem {
  NavMenuItem(..item, disabled: disabled)
}

/// icon_name sets the icon_name field
/// 
pub fn icon_name(item: NavMenuItem, icon_name: Option(String)) -> NavMenuItem {
  NavMenuItem(..item, icon_name: icon_name)
}

fn icon_elt(icon_name: Option(String)) -> Element(msg) {
  case icon_name {
    None -> element.none()
    Some(s) -> ico.basic(s) |> ico.element([], [])
  }
}

/// label sets the label field
/// 
pub fn label(item: NavMenuItem, label: String) -> NavMenuItem {
  NavMenuItem(..item, label: label)
}

///  open sets the open field
/// 
pub fn open(item: NavMenuItem, open: Bool) -> NavMenuItem {
  NavMenuItem(..item, open: open)
}

/// selected sets the selected field
/// 
pub fn selected(item: NavMenuItem, selected: Bool) -> NavMenuItem {
  NavMenuItem(..item, selected: selected)
}

/// element creates a Lustre Element(msg) from a NavMenuItem
///
/// ## Parameters:
/// - item: a NavMenuItem
/// - attributes: additional attributes
/// 
pub fn element(
  item: NavMenuItem,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  element.element(
    "m3e-nav-menu-item",
    [
      boolean_attribute("disabled", item.disabled),
      boolean_attribute("open", item.open),
      boolean_attribute("selected", item.selected),
      ..attributes
    ],
    [
      badge_elt(item.badge),
      icon_elt(item.icon_name),
      html.span([slot("label")], [html.text(item.label)]),
    ],
  )
}

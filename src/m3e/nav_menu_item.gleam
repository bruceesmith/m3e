//// nav_menu_item provides Lustre support for the [M3E Nav Menu Item component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element, element, none}
import lustre/element/html

import m3e/helpers.{boolean_attribute, slot}
import m3e/icon

/// nav_menu_item provides Lustre support for the [M3E Nav Menu Item component](https://matraic.github.io/m3e/#/components/nav-menu.html)
/// 
/// ## Fields:
/// - badge: Renders the badge of the item
/// - disabled: Whether the element is disabled
/// - leading_icon_name: Renders the icon of the item
/// - label: Renders the label of the item
/// - open: Whether the item is expanded
/// - selected: Whether the element is selected
/// - selected_icon_name: Renders the icon of the item when selected
/// - toggle_icon_name: Renders the toggle icon
///
pub opaque type NavMenuItem {
  NavMenuItem(
    badge: Option(String),
    disabled: Bool,
    leading_icon_name: Option(String),
    label: String,
    open: Bool,
    selected: Bool,
    selected_icon_name: Option(String),
    toggle_icon_name: Option(String),
  )
}

/// nav_menu_item creates a nav-menu-item
///
/// ## Parameters:
/// - badge: Renders the badge of the item
/// - disabled: Whether the element is disabled
/// - leading_icon_name: Renders the icon of the item
/// - label: Renders the label of the item
/// - open: Whether the item is expanded
/// - selected: Whether the element is selected
/// - selected_icon_name: Renders the icon of the item when selected
/// - toggle_icon_name: Renders the toggle icon
/// 
pub fn nav_menu_item(
  badge: Option(String),
  disabled: Bool,
  leading_icon_name: Option(String),
  label: String,
  open: Bool,
  selected: Bool,
  selected_icon_name: Option(String),
  toggle_icon_name: Option(String),
) -> NavMenuItem {
  NavMenuItem(
    badge: badge,
    disabled: disabled,
    leading_icon_name: leading_icon_name,
    label: label,
    open: open,
    selected: selected,
    selected_icon_name: selected_icon_name,
    toggle_icon_name: toggle_icon_name,
  )
}

/// badge sets the badge field
/// 
pub fn badge(item: NavMenuItem, badge: Option(String)) -> NavMenuItem {
  NavMenuItem(..item, badge: badge)
}

fn badge_elt(badge: Option(String)) -> Element(msg) {
  case badge {
    None -> none()
    Some(s) -> html.span([slot("badge")], [html.text(s)])
  }
}

/// disabled sets the disabled field
/// 
pub fn disabled(item: NavMenuItem, disabled: Bool) -> NavMenuItem {
  NavMenuItem(..item, disabled: disabled)
}

/// leading_icon_name sets the icon_name field
/// 
pub fn leading_icon_name(
  item: NavMenuItem,
  leading_icon_name: Option(String),
) -> NavMenuItem {
  NavMenuItem(..item, leading_icon_name: leading_icon_name)
}

fn leading_icon_elt(leading_icon_name: Option(String)) -> Element(msg) {
  case leading_icon_name {
    None -> none()
    Some(s) -> icon.new(s) |> icon.purpose(icon.Default) |> icon.render([], [])
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

/// selected_icon_name sets the selected_icon_name field
/// 
pub fn selected_icon_name(
  item: NavMenuItem,
  selected_icon_name: Option(String),
) -> NavMenuItem {
  NavMenuItem(..item, selected_icon_name: selected_icon_name)
}

fn selected_icon_elt(selected_icon_name: Option(String)) -> Element(msg) {
  case selected_icon_name {
    None -> none()
    Some(s) ->
      icon.new(s) |> icon.purpose(icon.SelectedIcon) |> icon.render([], [])
  }
}

/// toggle_icon_name sets the toggle_icon_name field
///
pub fn toggle_icon_name(
  item: NavMenuItem,
  toggle_icon_name: Option(String),
) -> NavMenuItem {
  NavMenuItem(..item, toggle_icon_name: toggle_icon_name)
}

fn toggle_icon_elt(toggle_icon_name: Option(String)) -> Element(msg) {
  case toggle_icon_name {
    None -> none()
    Some(s) ->
      icon.new(s) |> icon.purpose(icon.ToggleIcon) |> icon.render([], [])
  }
}

/// render creates a Lustre Element(msg) from a NavMenuItem
///
/// ## Parameters:
/// - item: a NavMenuItem
/// - attributes: additional attributes
/// 
pub fn render(
  item: NavMenuItem,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  element(
    "m3e-nav-menu-item",
    [
      boolean_attribute("disabled", item.disabled),
      boolean_attribute("open", item.open),
      boolean_attribute("selected", item.selected),
      ..attributes
    ],
    [
      badge_elt(item.badge),
      leading_icon_elt(item.leading_icon_name),
      html.span([slot("label")], [html.text(item.label)]),
      selected_icon_elt(item.selected_icon_name),
      toggle_icon_elt(item.toggle_icon_name),
    ],
  )
}

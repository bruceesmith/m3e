//// nav_menu_item provides Lustre support for the [M3E Nav Menu Item component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element, none}
import lustre/element/html

import m3e/helpers.{boolean_attribute}
import m3e/icon

// --- Types ---

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

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Badge
  // Renders the badge of the item 
  Icon
  // Renders the icon of the item 
  Label
  // Renders the label of the item
  SelectedIcon
  // Renders the icon of the item when selected 
  ToggleIcon
  // Renders the toggle icon 
}

// --- CONSTRUCTORS ---

/// new creates a nav-menu-item
///
/// ## Parameters:
/// - label: Renders the label of the item
/// 
pub fn new(label: String) -> NavMenuItem {
  NavMenuItem(
    badge: None,
    disabled: False,
    leading_icon_name: None,
    label: label,
    open: False,
    selected: False,
    selected_icon_name: None,
    toggle_icon_name: None,
  )
}

// --- SETTERS ---

/// badge sets the badge field
/// 
pub fn badge(item: NavMenuItem, badge: Option(String)) -> NavMenuItem {
  NavMenuItem(..item, badge: badge)
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

/// toggle_icon_name sets the toggle_icon_name field
///
pub fn toggle_icon_name(
  item: NavMenuItem,
  toggle_icon_name: Option(String),
) -> NavMenuItem {
  NavMenuItem(..item, toggle_icon_name: toggle_icon_name)
}

// --- RENDERING ---

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
      html.span([slot(Label)], [html.text(item.label)]),
      selected_icon_elt(item.selected_icon_name),
      toggle_icon_elt(item.toggle_icon_name),
    ],
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Badge -> attribute("slot", "badge")
    Icon -> attribute("slot", "icon")
    Label -> attribute("slot", "label")
    SelectedIcon -> attribute("slot", "selected-icon")
    ToggleIcon -> attribute("slot", "toggle-icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn badge_elt(badge: Option(String)) -> Element(msg) {
  case badge {
    None -> none()
    Some(s) -> html.span([slot(Badge)], [html.text(s)])
  }
}

fn leading_icon_elt(leading_icon_name: Option(String)) -> Element(msg) {
  case leading_icon_name {
    None -> none()
    Some(s) -> icon.new(s) |> icon.purpose(slot(Icon)) |> icon.render([], [])
  }
}

fn selected_icon_elt(selected_icon_name: Option(String)) -> Element(msg) {
  case selected_icon_name {
    None -> none()
    Some(s) ->
      icon.new(s) |> icon.purpose(slot(SelectedIcon)) |> icon.render([], [])
  }
}

fn toggle_icon_elt(toggle_icon_name: Option(String)) -> Element(msg) {
  case toggle_icon_name {
    None -> none()
    Some(s) ->
      icon.new(s) |> icon.purpose(slot(ToggleIcon)) |> icon.render([], [])
  }
}

//// nav_menu_item provides Lustre support for the [M3E Nav Menu Item component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element, none}
import lustre/element/html

import m3e/helpers.{boolean_attribute}
import m3e/icon
import m3e/types.{
  type Interaction, type SelectionState, Disabled, Selected, default_interaction,
  default_selection_state,
}

// --- Types ---

/// Expansion specifies if an item is open or closed
pub type Expansion {
  Open
  Closed
}

pub const default_expansion: Expansion = Closed

/// NavMenuItem represents a navigation menu item
/// 
/// ## Fields:
/// - badge: Renders the badge of the item
/// - interaction: Whether the element is enabled or disabled
/// - leading_icon_name: Renders the icon of the item
/// - label: Renders the label of the item
/// - expansion: Whether the item is expanded
/// - selection: Whether the element is selected
/// - selected_icon_name: Renders the icon of the item when selected
/// - toggle_icon_name: Renders the toggle icon
///
pub opaque type NavMenuItem {
  NavMenuItem(
    badge: Option(String),
    interaction: Interaction,
    leading_icon_name: Option(String),
    label: String,
    expansion: Expansion,
    selection: SelectionState,
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

// --- CONFIGURATION ---

/// Config holds the configuration for a NavMenuItem
/// 
pub type Config {
  Config(
    badge: Option(String),
    interaction: Interaction,
    leading_icon_name: Option(String),
    label: String,
    expansion: Expansion,
    selection: SelectionState,
    selected_icon_name: Option(String),
    toggle_icon_name: Option(String),
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config(label: String) -> Config {
  Config(
    badge: None,
    interaction: default_interaction,
    leading_icon_name: None,
    label: label,
    expansion: default_expansion,
    selection: default_selection_state,
    selected_icon_name: None,
    toggle_icon_name: None,
  )
}

// --- CONSTRUCTORS ---

/// new creates a nav-menu-item with default values
///
/// ## Parameters:
/// - label: Renders the label of the item
/// 
pub fn new(label: String) -> NavMenuItem {
  from_config(default_config(label))
}

/// from_config creates a NavMenuItem from a Config record
/// 
pub fn from_config(c: Config) -> NavMenuItem {
  NavMenuItem(
    badge: c.badge,
    interaction: c.interaction,
    leading_icon_name: c.leading_icon_name,
    label: c.label,
    expansion: c.expansion,
    selection: c.selection,
    selected_icon_name: c.selected_icon_name,
    toggle_icon_name: c.toggle_icon_name,
  )
}

// --- SETTERS ---

/// badge sets the badge field
/// 
pub fn badge(item: NavMenuItem, badge: Option(String)) -> NavMenuItem {
  NavMenuItem(..item, badge: badge)
}

/// disabled sets the interaction field
/// 
pub fn disabled(item: NavMenuItem, interaction: Interaction) -> NavMenuItem {
  NavMenuItem(..item, interaction: interaction)
}

/// leading_icon_name sets the leading_icon_name field
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

///  open sets the expansion field
/// 
pub fn open(item: NavMenuItem, expansion: Expansion) -> NavMenuItem {
  NavMenuItem(..item, expansion: expansion)
}

/// selected sets the selection field
/// 
pub fn selected(item: NavMenuItem, selection: SelectionState) -> NavMenuItem {
  NavMenuItem(..item, selection: selection)
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
      boolean_attribute("disabled", item.interaction == Disabled),
      boolean_attribute("open", item.expansion == Open),
      boolean_attribute("selected", item.selection == Selected),
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

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  render(from_config(config), attributes)
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

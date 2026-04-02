//// nav_menu_item provides Lustre support for the [M3E Nav Menu Item component](https://matraic.github.io/m3e/#/components/nav-menu.html)

import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

import m3e/helpers
import m3e/icon
import m3e/state.{type Interaction, type SelectionState, Disabled, Selected}

// --- Types ---

/// Expansion specifies if an item is open or closed
/// 
pub type Expansion {
  Open
  Closed
}

pub const default_expansion: Expansion = Closed

/// Mode is whether the element's selected / checked state is indeterminate
/// 
pub type Mode {
  Determinate
  Indeterminate
}

pub const default_mode = Determinate

/// NavMenuItem represents a navigation menu item
/// 
/// ## Fields:
/// - badge: Renders the badge of the item
/// - disabled: Whether the element is disabled
/// - indeterminate: Whether the element's selected / checked state is indeterminate
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
    disabled: Interaction,
    indeterminate: Mode,
    leading_icon_name: Option(String),
    label: String,
    open: Expansion,
    selected: SelectionState,
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
    disabled: Interaction,
    indeterminate: Mode,
    leading_icon_name: Option(String),
    label: String,
    open: Expansion,
    selected: SelectionState,
    selected_icon_name: Option(String),
    toggle_icon_name: Option(String),
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config(label: String) -> Config {
  Config(
    badge: None,
    disabled: state.default_interaction,
    indeterminate: default_mode,
    leading_icon_name: None,
    label: label,
    open: default_expansion,
    selected: state.default_selection_state,
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
    disabled: c.disabled,
    indeterminate: c.indeterminate,
    leading_icon_name: c.leading_icon_name,
    label: c.label,
    open: c.open,
    selected: c.selected,
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

/// disabled sets the disabled field
/// 
pub fn disabled(item: NavMenuItem, disabled: Interaction) -> NavMenuItem {
  NavMenuItem(..item, disabled: disabled)
}

/// indeterminate sets the indeterminate field
/// 
pub fn indeterminate(item: NavMenuItem, indeterminate: Mode) -> NavMenuItem {
  NavMenuItem(..item, indeterminate: indeterminate)
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

///  open sets the open field
/// 
pub fn open(item: NavMenuItem, open: Expansion) -> NavMenuItem {
  NavMenuItem(..item, open: open)
}

/// selected sets the selected field
/// 
pub fn selected(item: NavMenuItem, selected: SelectionState) -> NavMenuItem {
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
  element.element(
    "m3e-nav-menu-item",
    [
      helpers.boolean_attribute("disabled", item.disabled == Disabled),
      helpers.boolean_attribute(
        "indeterminate",
        item.indeterminate == Indeterminate,
      ),
      helpers.boolean_attribute("open", item.open == Open),
      helpers.boolean_attribute("selected", item.selected == Selected),
      ..attributes
    ],
    [
      badge_elt(item.badge),
      leading_icon_elt(item.leading_icon_name),
      html.span([slot(Label)], [element.text(item.label)]),
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
    Badge -> attribute.attribute("slot", "badge")
    Icon -> attribute.attribute("slot", "icon")
    Label -> attribute.attribute("slot", "label")
    SelectedIcon -> attribute.attribute("slot", "selected-icon")
    ToggleIcon -> attribute.attribute("slot", "toggle-icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn badge_elt(badge: Option(String)) -> Element(msg) {
  case badge {
    None -> element.none()
    Some(s) -> html.span([slot(Badge)], [element.text(s)])
  }
}

fn leading_icon_elt(leading_icon_name: Option(String)) -> Element(msg) {
  case leading_icon_name {
    None -> element.none()
    Some(s) -> icon.new(s) |> icon.purpose(slot(Icon)) |> icon.render([], [])
  }
}

fn selected_icon_elt(selected_icon_name: Option(String)) -> Element(msg) {
  case selected_icon_name {
    None -> element.none()
    Some(s) ->
      icon.new(s) |> icon.purpose(slot(SelectedIcon)) |> icon.render([], [])
  }
}

fn toggle_icon_elt(toggle_icon_name: Option(String)) -> Element(msg) {
  case toggle_icon_name {
    None -> element.none()
    Some(s) ->
      icon.new(s) |> icon.purpose(slot(ToggleIcon)) |> icon.render([], [])
  }
}

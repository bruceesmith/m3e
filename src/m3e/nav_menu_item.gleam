//// NavMenuItem is an expandable item, selectable item within a navigation menu.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr

// --- Types ---

/// NavMenuItem is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether the element is disabled.
/// - open: Whether the item is expanded.
/// - selected: Whether the item is selected.
///
pub opaque type NavMenuItem {
  NavMenuItem(disabled: Disabled, open: Open, selected: Selected)
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// Open is whether the item is expanded.
///
pub type Open {
  IsOpen
  IsNotOpen
}

/// Selected is whether the item is selected.
///
pub type Selected {
  IsSelected
  IsNotSelected
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_open: Open = IsNotOpen

pub const default_selected: Selected = IsNotSelected

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Label
  // Renders the label of the item.
  Icon
  // Renders the icon of the item.
  Badge
  // Renders the badge of the item.
  SelectedIcon
  // Renders the icon of the item when selected.
  ToggleIcon
  // Renders the toggle icon.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(disabled: Disabled, open: Open, selected: Selected)
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(disabled: IsNotDisabled, open: IsNotOpen, selected: IsNotSelected)
}

// --- Constructors ---

/// from_config creates a new NavMenuItem from the given configuration.
///
pub fn from_config(config: Config) -> NavMenuItem {
  NavMenuItem(
    disabled: config.disabled,
    open: config.open,
    selected: config.selected,
  )
}

/// new creates a new NavMenuItem with the default configuration.
///
pub fn new() -> NavMenuItem {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this NavMenuItem.
///
pub fn disabled(record: NavMenuItem, disabled: Disabled) -> NavMenuItem {
  NavMenuItem(..record, disabled: disabled)
}

/// open sets the value of open for this NavMenuItem.
///
pub fn open(record: NavMenuItem, open: Open) -> NavMenuItem {
  NavMenuItem(..record, open: open)
}

/// selected sets the value of selected for this NavMenuItem.
///
pub fn selected(record: NavMenuItem, selected: Selected) -> NavMenuItem {
  NavMenuItem(..record, selected: selected)
}

// --- Renderers ---

/// render creates a Lustre Element for a NavMenuItem
///
pub fn render(
  model: NavMenuItem,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-nav-menu-item",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.boolean("open", model.open == IsOpen),
        attr.boolean("selected", model.selected == IsSelected),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a NavMenuItem Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Label -> attribute.attribute("slot", "label")
    Icon -> attribute.attribute("slot", "icon")
    Badge -> attribute.attribute("slot", "badge")
    SelectedIcon -> attribute.attribute("slot", "selected-icon")
    ToggleIcon -> attribute.attribute("slot", "toggle-icon")
  }
}

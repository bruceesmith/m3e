//// ExpansionPanel is an expandable details-summary view.
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
import m3e/expansion_toggle_direction.{type ExpansionToggleDirection}
import m3e/expansion_toggle_position.{type ExpansionTogglePosition}

// --- Types ---

/// ExpansionPanel is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether the element is disabled.
/// - hide_toggle: Whether to hide the expansion toggle.
/// - open: Whether the panel is expanded.
/// - toggle_direction: The direction of the expansion toggle.
/// - toggle_position: The position of the expansion toggle.
///
pub opaque type ExpansionPanel {
  ExpansionPanel(
    disabled: Disabled,
    hide_toggle: HideToggle,
    open: Open,
    toggle_direction: ExpansionToggleDirection,
    toggle_position: ExpansionTogglePosition,
  )
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// HideToggle is whether to hide the expansion toggle.
///
pub type HideToggle {
  IsHideToggle
  IsNotHideToggle
}

/// Open is whether the panel is expanded.
///
pub type Open {
  IsOpen
  IsNotOpen
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_hide_toggle: HideToggle = IsNotHideToggle

pub const default_open: Open = IsNotOpen

pub const default_toggle_direction: ExpansionToggleDirection = expansion_toggle_direction.Vertical

pub const default_toggle_position: ExpansionTogglePosition = expansion_toggle_position.After

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Actions
  // Renders the actions bar of the panel.
  Header
  // Renders the header content.
  ToggleIcon
  // Renders the expansion toggle icon.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    hide_toggle: HideToggle,
    open: Open,
    toggle_direction: ExpansionToggleDirection,
    toggle_position: ExpansionTogglePosition,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disabled: IsNotDisabled,
    hide_toggle: IsNotHideToggle,
    open: IsNotOpen,
    toggle_direction: expansion_toggle_direction.Vertical,
    toggle_position: expansion_toggle_position.After,
  )
}

// --- Constructors ---

/// from_config creates a new ExpansionPanel from the given configuration.
///
pub fn from_config(config: Config) -> ExpansionPanel {
  ExpansionPanel(
    disabled: config.disabled,
    hide_toggle: config.hide_toggle,
    open: config.open,
    toggle_direction: config.toggle_direction,
    toggle_position: config.toggle_position,
  )
}

/// new creates a new ExpansionPanel with the default configuration.
///
pub fn new() -> ExpansionPanel {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this ExpansionPanel.
///
pub fn disabled(record: ExpansionPanel, disabled: Disabled) -> ExpansionPanel {
  ExpansionPanel(..record, disabled: disabled)
}

/// hide_toggle sets the value of hide_toggle for this ExpansionPanel.
///
pub fn hide_toggle(
  record: ExpansionPanel,
  hide_toggle: HideToggle,
) -> ExpansionPanel {
  ExpansionPanel(..record, hide_toggle: hide_toggle)
}

/// open sets the value of open for this ExpansionPanel.
///
pub fn open(record: ExpansionPanel, open: Open) -> ExpansionPanel {
  ExpansionPanel(..record, open: open)
}

/// toggle_direction sets the value of toggle_direction for this ExpansionPanel.
///
pub fn toggle_direction(
  record: ExpansionPanel,
  toggle_direction: ExpansionToggleDirection,
) -> ExpansionPanel {
  ExpansionPanel(..record, toggle_direction: toggle_direction)
}

/// toggle_position sets the value of toggle_position for this ExpansionPanel.
///
pub fn toggle_position(
  record: ExpansionPanel,
  toggle_position: ExpansionTogglePosition,
) -> ExpansionPanel {
  ExpansionPanel(..record, toggle_position: toggle_position)
}

// --- Renderers ---

/// render creates a Lustre Element for a ExpansionPanel
///
pub fn render(
  model: ExpansionPanel,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-expansion-panel",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.boolean("hide-toggle", model.hide_toggle == IsHideToggle),
        attr.boolean("open", model.open == IsOpen),
        attr.with_default(
          "toggle-direction",
          expansion_toggle_direction.to_string(model.toggle_direction),
          expansion_toggle_direction.to_string(default_toggle_direction),
        ),
        attr.with_default(
          "toggle-position",
          expansion_toggle_position.to_string(model.toggle_position),
          expansion_toggle_position.to_string(default_toggle_position),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a ExpansionPanel Config
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
    Actions -> attribute.attribute("slot", "actions")
    Header -> attribute.attribute("slot", "header")
    ToggleIcon -> attribute.attribute("slot", "toggle-icon")
  }
}

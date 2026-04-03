//// input_chip provides Lustre support for the [M3E Input Chip components](https://matraic.github.io/m3e/#/components/chips.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/chip.{type Variant}
import m3e/helpers
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// InputChip is A container that transforms user input into a cohesive set of interactive chips, supporting entry,
/// editing, and removal of discrete values.
///
/// - disabled: Whether the element is disabled
/// - disabled_interactive: Whether the element is disabled and interactive
/// - removable: Whether the chip is removable.
/// - remove_label: The accessible label given to the button used to remove the chip.
/// - value: A string representing the value of the chip
/// - variant: The appearance variant of the chip
///
pub opaque type InputChip(msg) {
  InputChip(
    disabled: Interaction,
    disabled_interactive: Interaction,
    removable: Removability,
    remove_label: String,
    value: Option(String),
    variant: Variant,
  )
}

/// Removability specifies if a chip can be removed
pub type Removability {
  Removable
  Permanent
}

pub const default_removability: Removability = Permanent

pub const default_remove_label: String = "Remove"

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Avatar
  // Renders an avatar before the chip's label
  Icon
  // Renders an icon before the chip's label 
  RemoveIcon
  // Renders the icon for the button used to remove the chip 
}

// --- CONFIGURATION ---

/// Config holds the configuration for a InputChip
/// 
pub type Config(msg) {
  Config(
    disabled: Interaction,
    disabled_interactive: Interaction,
    removable: Removability,
    remove_label: String,
    value: Option(String),
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config(msg) {
  Config(
    disabled: state.default_interaction,
    disabled_interactive: state.default_interaction,
    removable: default_removability,
    remove_label: default_remove_label,
    value: None,
    variant: chip.default_variant,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a InputChip from a Config record
/// 
pub fn from_config(c: Config(msg)) -> InputChip(msg) {
  InputChip(
    disabled: c.disabled,
    disabled_interactive: c.disabled_interactive,
    removable: c.removable,
    remove_label: c.remove_label,
    value: c.value,
    variant: c.variant,
  )
}

// --- SETTERS ---

/// disabled sets the `disabled` field
///
pub fn disabled(c: InputChip(msg), disabled: Interaction) -> InputChip(msg) {
  InputChip(..c, disabled: disabled)
}

/// disabled_interactive sets the `disabled_interactive` field
///
pub fn disabled_interactive(
  c: InputChip(msg),
  disabled_interactive: Interaction,
) -> InputChip(msg) {
  InputChip(..c, disabled_interactive: disabled_interactive)
}

/// removable sets the `removable` field
///
pub fn removable(c: InputChip(msg), removable: Removability) -> InputChip(msg) {
  InputChip(..c, removable: removable)
}

/// remove_label sets the `remove_label` field
///
pub fn remove_label(c: InputChip(msg), remove_label: String) -> InputChip(msg) {
  InputChip(..c, remove_label: remove_label)
}

/// value sets the `value` field
///
pub fn value(c: InputChip(msg), value: Option(String)) -> InputChip(msg) {
  InputChip(..c, value: value)
}

/// variant sets the `variant` field
///
pub fn variant(c: InputChip(msg), v: Variant) -> InputChip(msg) {
  InputChip(..c, variant: v)
}

// --- RENDERING ---

/// render creates a Lustre Element from a InputChip
///
/// ## Parameters:
/// - c: a InputChip
/// - attributes: any extra attributes, e.g. an event
/// - children: a list of child elements
///
pub fn render(
  c: InputChip(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-input-chip",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", c.disabled == Disabled),
        helpers.boolean_attribute(
          "disabled-interactive",
          c.disabled_interactive == Disabled,
        ),
        helpers.boolean_attribute("removable", c.removable == Removable),
        case c.removable {
          Removable -> attribute.attribute("remove-label", c.remove_label)
          _ -> attribute.none()
        },
        helpers.option_attribute(
          c.value,
          fn(_) { "value" },
          function.identity,
          None,
        ),
        attribute.attribute("variant", chip.variant_to_string(c.variant)),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Avatar -> attribute.attribute("slot", "avatar")
    Icon -> attribute.attribute("slot", "icon")
    RemoveIcon -> attribute.attribute("slot", "remove-icon")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

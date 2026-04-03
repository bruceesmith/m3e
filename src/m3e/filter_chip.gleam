//// filter_chip provides Lustre support for the [M3E Filter Chip components](https://matraic.github.io/m3e/#/components/chips.html)

import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/chip.{type Variant}
import m3e/helpers
import m3e/state.{type Interaction, type SelectionState, Disabled, Selected}

// --- Types ---

/// FilterChip is a chip users interact with to select/deselect options
///
/// ## Fields:
/// - disabled: A value indicating whether the element is disabled
/// - disabled_interactive: A value indicating whether the element is disabled and interactive
/// - selected: A value indicating whether the element is selected
/// - value: A string representing the value of the chip
/// - variant: The appearance variant of the chip
///
pub opaque type FilterChip(msg) {
  FilterChip(
    disabled: Interaction,
    disabled_interactive: Interaction,
    selected: SelectionState,
    value: String,
    variant: Variant,
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders an icon before the chip's label 
  TrailingIcon
  // Renders an icon after the chip's label 
}

// --- CONFIGURATION ---

/// Config holds the configuration for a FilterChip
/// 
pub type Config(msg) {
  Config(
    disabled: Interaction,
    disabled_interactive: Interaction,
    selected: SelectionState,
    value: String,
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config(msg) {
  Config(
    disabled: state.default_interaction,
    disabled_interactive: state.default_interaction,
    selected: state.default_selection_state,
    value: "",
    variant: chip.default_variant,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a FilterChip from a Config record
/// 
pub fn from_config(c: Config(msg)) -> FilterChip(msg) {
  FilterChip(
    disabled: c.disabled,
    disabled_interactive: c.disabled_interactive,
    selected: c.selected,
    value: c.value,
    variant: c.variant,
  )
}

// --- SETTERS ---

/// disabled sets the `disabled` field
///
pub fn disabled(c: FilterChip(msg), disabled: Interaction) -> FilterChip(msg) {
  FilterChip(..c, disabled: disabled)
}

/// disabled_interactive sets the `disabled_interactive` field
///
pub fn disabled_interactive(
  c: FilterChip(msg),
  disabled_interactive: Interaction,
) -> FilterChip(msg) {
  FilterChip(..c, disabled_interactive: disabled_interactive)
}

/// selected sets the `selected` field
///
pub fn selected(c: FilterChip(msg), selected: SelectionState) -> FilterChip(msg) {
  FilterChip(..c, selected: selected)
}

/// value sets the `value` field
///
pub fn value(c: FilterChip(msg), value: String) -> FilterChip(msg) {
  FilterChip(..c, value: value)
}

/// variant sets the `variant` field
///
pub fn variant(c: FilterChip(msg), v: Variant) -> FilterChip(msg) {
  FilterChip(..c, variant: v)
}

// --- RENDERING ---

/// render creates a Lustre Element from a FilterChip
///
/// ## Parameters:
/// - c: a FilterChip
/// - attributes: any extra attributes, e.g. an event
/// - children: a list of child elements
///
pub fn render(
  c: FilterChip(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-filter-chip",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", c.disabled == Disabled),
        helpers.boolean_attribute(
          "disabled-interactive",
          c.disabled_interactive == Disabled,
        ),
        helpers.boolean_attribute("selected", c.selected == Selected),
        attribute.attribute("value", c.value),
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
    Icon -> attribute.attribute("slot", "icon")
    TrailingIcon -> attribute.attribute("slot", "trailing-icon")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

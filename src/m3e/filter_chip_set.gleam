//// filter_chip_set provides Lustre support for the [M3E Chip Set component](https://matraic.github.io/m3e/#/components/chip-set.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/config.{
  type SelectionIndicator, type SelectionMode, HideSelectionIndicator, Multi,
  ShowSelectionIndicator,
}
import m3e/helpers
import m3e/layout.{type Orientation, Vertical}
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// FilterChipset contains all the information for a FilterChipSet
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - hide_selection_indicator: Whether to hide the selection indicator
/// - multi: Whether multiple chips can be selected
/// - name: The name that identifies the element when submitting the associated form
/// - vertical: Whether the element is oriented vertically
///
pub opaque type FilterChipSet {
  FilterChipSet(
    disabled: Interaction,
    hide_selection_indicator: SelectionIndicator,
    multi: SelectionMode,
    name: Option(String),
    vertical: Orientation,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a FilterChipSet
///  
pub type Config {
  Config(
    disabled: Interaction,
    hide_selection_indicator: SelectionIndicator,
    multi: SelectionMode,
    name: Option(String),
    vertical: Orientation,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    disabled: state.default_interaction,
    hide_selection_indicator: ShowSelectionIndicator,
    multi: config.default_selection_mode,
    name: None,
    vertical: layout.default_orientation,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new FilterChipSet with default values
///
pub fn new() -> FilterChipSet {
  from_config(default_config())
}

/// from_config creates a FilterChipSet from a Config record
/// 
pub fn from_config(c: Config) -> FilterChipSet {
  FilterChipSet(
    disabled: c.disabled,
    hide_selection_indicator: c.hide_selection_indicator,
    multi: c.multi,
    name: c.name,
    vertical: c.vertical,
  )
}

// --- SETTERS ---

/// disabled sets the `disabled` field
///
pub fn disabled(c: FilterChipSet, disabled: Interaction) -> FilterChipSet {
  FilterChipSet(..c, disabled: disabled)
}

/// hide_selection_indicator sets the `hide_selection_indicator` field
///
pub fn hide_selection_indicator(
  c: FilterChipSet,
  indicator: SelectionIndicator,
) -> FilterChipSet {
  FilterChipSet(..c, hide_selection_indicator: indicator)
}

/// multi sets the `multi` field
///
pub fn multi(c: FilterChipSet, mode: SelectionMode) -> FilterChipSet {
  FilterChipSet(..c, multi: mode)
}

/// name sets the `name` field
///
pub fn name(c: FilterChipSet, name: Option(String)) -> FilterChipSet {
  FilterChipSet(..c, name: name)
}

/// vertical sets the `vertical` field
///
pub fn vertical(s: FilterChipSet, vertical: Orientation) -> FilterChipSet {
  FilterChipSet(..s, vertical: vertical)
}

// --- RENDERING ---

/// render creates a Lustre Element from a FilterChipSet
///
pub fn render(
  s: FilterChipSet,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-filter-chip-set",
    list.append(
      [
        helpers.boolean_attribute("disabled", s.disabled == Disabled),
        helpers.boolean_attribute(
          "hide-selection-indicator",
          s.hide_selection_indicator == HideSelectionIndicator,
        ),
        helpers.boolean_attribute("multi", s.multi == Multi),
        helpers.option_attribute(
          s.name,
          fn(_) { "name" },
          function.identity,
          None,
        ),
        helpers.boolean_attribute("vertical", s.vertical == Vertical),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}
// --- PRIVATE INTERNAL HELPERS ---

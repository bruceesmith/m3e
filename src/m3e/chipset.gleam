//// chipset provides Lustre support for the [M3E Chip Set component](https://matraic.github.io/m3e/#/components/chip-set.html)

import gleam/list
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

/// Chipset contains all the information for a ChipSet
/// 
/// ## Fields:
/// - disabled: disable the chip set in its entirety
/// - selection_indicator: hide selection indicators
/// - selection_mode: Whether multiple chips can be selected
/// - type_: the chipset type
/// - vertical: Whether the element is oriented vertically
///
pub opaque type ChipSet {
  ChipSet(
    disabled: Interaction,
    selection_indicator: SelectionIndicator,
    selection_mode: SelectionMode,
    type_: Type,
    vertical: Orientation,
  )
}

/// Type of chipset
///
pub type Type {
  Information
  Filter
  Input
}

pub const default_type: Type = Information

// --- CONFIGURATION ---

/// Config holds the configuration for a ChipSet
///  
pub type Config {
  Config(
    disabled: Interaction,
    selection_indicator: SelectionIndicator,
    selection_mode: SelectionMode,
    type_: Type,
    vertical: Orientation,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    disabled: state.default_interaction,
    selection_indicator: ShowSelectionIndicator,
    selection_mode: config.default_selection_mode,
    type_: default_type,
    vertical: layout.default_orientation,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new ChipSet with default values
///
pub fn new() -> ChipSet {
  from_config(default_config())
}

/// from_config creates a ChipSet from a Config record
/// 
pub fn from_config(c: Config) -> ChipSet {
  ChipSet(
    disabled: c.disabled,
    selection_indicator: c.selection_indicator,
    selection_mode: c.selection_mode,
    type_: c.type_,
    vertical: c.vertical,
  )
}

// --- SETTERS ---

/// disabled sets the `disabled` field
///
pub fn disabled(c: ChipSet, disabled: Interaction) -> ChipSet {
  case c.type_ {
    Input -> ChipSet(..c, disabled: disabled)
    _ -> c
  }
}

/// hide_selection_indicator sets the `selection_indicator` field
///
pub fn hide_selection_indicator(
  c: ChipSet,
  indicator: SelectionIndicator,
) -> ChipSet {
  case c.type_ {
    Filter -> ChipSet(..c, selection_indicator: indicator)
    _ -> c
  }
}

/// multi sets the `selection_mode` field
///
pub fn multi(c: ChipSet, mode: SelectionMode) -> ChipSet {
  case c.type_ {
    Filter -> ChipSet(..c, selection_mode: mode)
    _ -> c
  }
}

/// type_ sets the `type_` field
///
pub fn type_(c: ChipSet, t: Type) -> ChipSet {
  ChipSet(..c, type_: t)
}

/// vertical sets the `vertical` field
///
pub fn vertical(s: ChipSet, vertical: Orientation) -> ChipSet {
  ChipSet(..s, vertical: vertical)
}

// --- RENDERING ---

/// render creates a Lustre Element from a ChipSet
///
pub fn render(
  s: ChipSet,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    type_to_string(s.type_),
    list.append(
      [
        disabled_attr(s.type_, s.disabled),
        hide_selection_indicator_attr(s.type_, s.selection_indicator),
        multi_attr(s.type_, s.selection_mode),
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

fn disabled_attr(t: Type, disabled: Interaction) -> Attribute(msg) {
  case t, disabled {
    Input, Disabled -> attribute.attribute("disabled", "")
    _, _ -> attribute.none()
  }
}

fn hide_selection_indicator_attr(
  t: Type,
  hsi: SelectionIndicator,
) -> Attribute(msg) {
  case t, hsi {
    Filter, HideSelectionIndicator ->
      attribute.attribute("hide-selection-indicator", "")
    _, _ -> attribute.none()
  }
}

fn multi_attr(t: Type, mode: SelectionMode) -> Attribute(msg) {
  case t, mode {
    Filter, Multi -> attribute.attribute("multi", "")
    _, _ -> attribute.none()
  }
}

fn type_to_string(t: Type) -> String {
  case t {
    Information -> "m3e-chip-set"
    Filter -> "m3e-filter-chip-set"
    Input -> "m3e-input-chip-set"
  }
}

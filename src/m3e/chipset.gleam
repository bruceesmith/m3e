//// chipset provides Lustre support for the [M3E Chip Set component](https://matraic.github.io/m3e/#/components/chip-set.html)

import gleam/list
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/types.{
  type Interaction, type SelectionIndicator, Disabled, Enabled,
  HideSelectionIndicator, ShowSelectionIndicator,
}

// --- Types ---

/// Orientation specifies the layout orientation of the chipset
pub type Orientation {
  Horizontal
  Vertical
}

/// SelectionMode specifies if multiple chips can be selected
pub type SelectionMode {
  Single
  Multi
}

/// Type of chipset
///
pub type Type {
  Information
  Filter
  Input
}

/// Chipset contains all the information for a ChipSet
/// 
/// ## Fields:
/// - interaction: disable the chip set in its entirety
/// - selection_indicator: hide selection indicators
/// - selection_mode: Whether multiple chips can be selected
/// - type_: the chipset type
/// - orientation: Whether the element is oriented vertically
///
pub opaque type ChipSet {
  ChipSet(
    interaction: Interaction,
    selection_indicator: SelectionIndicator,
    selection_mode: SelectionMode,
    type_: Type,
    orientation: Orientation,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a ChipSet
/// 
pub type Config {
  Config(
    interaction: Interaction,
    selection_indicator: SelectionIndicator,
    selection_mode: SelectionMode,
    type_: Type,
    orientation: Orientation,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    interaction: Enabled,
    selection_indicator: ShowSelectionIndicator,
    selection_mode: Single,
    type_: Information,
    orientation: Horizontal,
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
    interaction: c.interaction,
    selection_indicator: c.selection_indicator,
    selection_mode: c.selection_mode,
    type_: c.type_,
    orientation: c.orientation,
  )
}

// --- SETTERS ---

/// disabled sets the `interaction` field
///
pub fn disabled(c: ChipSet, interaction: Interaction) -> ChipSet {
  case c.type_ {
    Input -> ChipSet(..c, interaction: interaction)
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

/// vertical sets the `orientation` field
///
pub fn vertical(s: ChipSet, orientation: Orientation) -> ChipSet {
  ChipSet(..s, orientation: orientation)
}

// --- RENDERING ---

/// render creates a Lustre Element from a ChipSet
///
pub fn render(
  s: ChipSet,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    type_to_string(s.type_),
    list.append(
      [
        disabled_attr(s.type_, s.interaction),
        hide_selection_indicator_attr(s.type_, s.selection_indicator),
        multi_attr(s.type_, s.selection_mode),
        boolean_attribute("vertical", s.orientation == Vertical),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != none() }),
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

fn disabled_attr(t: Type, interaction: Interaction) -> Attribute(msg) {
  case t, interaction {
    Input, Disabled -> attribute("disabled", "")
    _, _ -> none()
  }
}

fn hide_selection_indicator_attr(
  t: Type,
  hsi: SelectionIndicator,
) -> Attribute(msg) {
  case t, hsi {
    Filter, HideSelectionIndicator -> attribute("hide-selection-indicator", "")
    _, _ -> none()
  }
}

fn multi_attr(t: Type, mode: SelectionMode) -> Attribute(msg) {
  case t, mode {
    Filter, Multi -> attribute("multi", "")
    _, _ -> none()
  }
}

fn type_to_string(t: Type) -> String {
  case t {
    Information -> "m3e-chip-set"
    Filter -> "m3e-filter-chip-set"
    Input -> "m3e-input-chip-set"
  }
}

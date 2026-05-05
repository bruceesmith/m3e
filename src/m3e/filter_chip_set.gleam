//// FilterChipSet is a container that organizes filter chips into a cohesive group, enabling selection and
//// //// deselection of values used to refine content or trigger contextual behavior.
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

/// FilterChipSet is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether the element is disabled.
/// - hide_selection_indicator: Whether to hide the selection indicator.
/// - multi: Whether multiple chips can be selected.
/// - name: The name that identifies the element when submitting the associated form.
/// - vertical: Whether the element is oriented vertically.
///
pub opaque type FilterChipSet {
  FilterChipSet(
    disabled: Disabled,
    hide_selection_indicator: HideSelectionIndicator,
    multi: Multi,
    name: String,
    vertical: Vertical,
  )
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// HideSelectionIndicator is whether to hide the selection indicator.
///
pub type HideSelectionIndicator {
  IsHideSelectionIndicator
  IsNotHideSelectionIndicator
}

/// Multi is whether multiple chips can be selected.
///
pub type Multi {
  IsMulti
  IsNotMulti
}

/// Vertical is whether the element is oriented vertically.
///
pub type Vertical {
  IsVertical
  IsNotVertical
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_hide_selection_indicator: HideSelectionIndicator = IsNotHideSelectionIndicator

pub const default_multi: Multi = IsNotMulti

pub const default_name: String = ""

pub const default_vertical: Vertical = IsNotVertical

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    hide_selection_indicator: HideSelectionIndicator,
    multi: Multi,
    name: String,
    vertical: Vertical,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disabled: IsNotDisabled,
    hide_selection_indicator: IsNotHideSelectionIndicator,
    multi: IsNotMulti,
    name: "",
    vertical: IsNotVertical,
  )
}

// --- Constructors ---

/// from_config creates a new FilterChipSet from the given configuration.
///
pub fn from_config(config: Config) -> FilterChipSet {
  FilterChipSet(
    disabled: config.disabled,
    hide_selection_indicator: config.hide_selection_indicator,
    multi: config.multi,
    name: config.name,
    vertical: config.vertical,
  )
}

/// new creates a new FilterChipSet with the default configuration.
///
pub fn new() -> FilterChipSet {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this FilterChipSet.
///
pub fn disabled(record: FilterChipSet, disabled: Disabled) -> FilterChipSet {
  FilterChipSet(..record, disabled: disabled)
}

/// hide_selection_indicator sets the value of hide_selection_indicator for this FilterChipSet.
///
pub fn hide_selection_indicator(
  record: FilterChipSet,
  hide_selection_indicator: HideSelectionIndicator,
) -> FilterChipSet {
  FilterChipSet(..record, hide_selection_indicator: hide_selection_indicator)
}

/// multi sets the value of multi for this FilterChipSet.
///
pub fn multi(record: FilterChipSet, multi: Multi) -> FilterChipSet {
  FilterChipSet(..record, multi: multi)
}

/// name sets the value of name for this FilterChipSet.
///
pub fn name(record: FilterChipSet, name: String) -> FilterChipSet {
  FilterChipSet(..record, name: name)
}

/// vertical sets the value of vertical for this FilterChipSet.
///
pub fn vertical(record: FilterChipSet, vertical: Vertical) -> FilterChipSet {
  FilterChipSet(..record, vertical: vertical)
}

// --- Renderers ---

/// render creates a Lustre Element for a FilterChipSet
///
pub fn render(
  model: FilterChipSet,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-filter-chip-set",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.boolean(
          "hide-selection-indicator",
          model.hide_selection_indicator == IsHideSelectionIndicator,
        ),
        attr.boolean("multi", model.multi == IsMulti),
        attr.with_default("name", model.name, default_name),
        attr.boolean("vertical", model.vertical == IsVertical),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a FilterChipSet Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

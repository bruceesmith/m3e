//// segmented_button provides Lustre support for the [M3E Segmented Button component](https://matraic.github.io/m3e/#/components/segmented-button.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/config.{type SelectionMode, Multi}
import m3e/helpers
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// IndicatorVisibility specifies if the selection indicator is visible or hidden
pub type IndicatorVisibility {
  Visible
  Hidden
}

pub const default_indicator_visibility: IndicatorVisibility = Visible

/// SegmentedButton provides Lustre support for the [M3E Segmented Button component](https://matraic.github.io/m3e/#/components/segmented-button.html)
///
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - hide_selection_indicator: Whether to hide the selection indicator
/// - multi: Whether multiple options can be selected
/// - name: The name that identifies the element when submitting the associated form
///
pub opaque type SegmentedButton {
  SegmentedButton(
    disabled: Interaction,
    hide_selection_indicator: IndicatorVisibility,
    multi: SelectionMode,
    name: Option(String),
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a SegmentedButton
/// 
pub type Config {
  Config(
    disabled: Interaction,
    hide_selection_indicator: IndicatorVisibility,
    multi: SelectionMode,
    name: Option(String),
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    disabled: state.default_interaction,
    hide_selection_indicator: default_indicator_visibility,
    multi: config.default_selection_mode,
    name: None,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new SegmentedButton with default values
///
pub fn new() -> SegmentedButton {
  from_config(default_config())
}

/// from_config creates a SegmentedButton from a Config record
/// 
pub fn from_config(c: Config) -> SegmentedButton {
  SegmentedButton(
    disabled: c.disabled,
    hide_selection_indicator: c.hide_selection_indicator,
    multi: c.multi,
    name: c.name,
  )
}

// --- SETTERS ---

/// disabled sets the disabled field
///
pub fn disabled(s: SegmentedButton, disabled: Interaction) -> SegmentedButton {
  SegmentedButton(..s, disabled: disabled)
}

/// hide_selection_indicator sets the hide_selection_indicator field
///
pub fn hide_selection_indicator(
  s: SegmentedButton,
  hide_selection_indicator: IndicatorVisibility,
) -> SegmentedButton {
  SegmentedButton(..s, hide_selection_indicator: hide_selection_indicator)
}

/// multi sets the multi field
///
pub fn multi(s: SegmentedButton, multi: SelectionMode) -> SegmentedButton {
  SegmentedButton(..s, multi: multi)
}

/// name sets the name field
///
pub fn name(s: SegmentedButton, name: Option(String)) -> SegmentedButton {
  SegmentedButton(..s, name: name)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a SegmentedButton
///
/// ## Parameters:
/// - s: a SegmentedButton
/// - attributes: additional attributes
/// - children: additional children
/// 
pub fn render(
  s: SegmentedButton,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-segmented-button",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", s.disabled == Disabled),
        helpers.boolean_attribute(
          "hide-selection-indicator",
          s.hide_selection_indicator == Hidden,
        ),
        helpers.boolean_attribute("multi", s.multi == Multi),
        helpers.option_attribute(
          s.name,
          fn(_) { "name" },
          function.identity,
          None,
        ),
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
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

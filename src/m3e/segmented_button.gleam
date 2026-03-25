//// segmented_button provides Lustre support for the [M3E Segmented Button component](https://matraic.github.io/m3e/#/components/segmented-button.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/config.{type SelectionMode, Multi}
import m3e/helpers.{boolean_attribute, option_attribute}
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
/// - interaction: Whether the element is enabled or disabled
/// - indicator_visibility: Whether to hide the selection indicator
/// - selection_mode: Whether multiple options can be selected
/// - name: The name that identifies the element when submitting the associated form
///
pub opaque type SegmentedButton {
  SegmentedButton(
    interaction: Interaction,
    indicator_visibility: IndicatorVisibility,
    selection_mode: SelectionMode,
    name: Option(String),
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a SegmentedButton
/// 
pub type Config {
  Config(
    interaction: Interaction,
    indicator_visibility: IndicatorVisibility,
    selection_mode: SelectionMode,
    name: Option(String),
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    interaction: state.default_interaction,
    indicator_visibility: default_indicator_visibility,
    selection_mode: config.default_selection_mode,
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
    interaction: c.interaction,
    indicator_visibility: c.indicator_visibility,
    selection_mode: c.selection_mode,
    name: c.name,
  )
}

// --- SETTERS ---

/// disabled sets the interaction field
///
pub fn disabled(s: SegmentedButton, interaction: Interaction) -> SegmentedButton {
  SegmentedButton(..s, interaction: interaction)
}

/// hide_selection_indicator sets the indicator_visibility field
///
pub fn hide_selection_indicator(
  s: SegmentedButton,
  indicator_visibility: IndicatorVisibility,
) -> SegmentedButton {
  SegmentedButton(..s, indicator_visibility: indicator_visibility)
}

/// multi sets the selection_mode field
///
pub fn multi(
  s: SegmentedButton,
  selection_mode: SelectionMode,
) -> SegmentedButton {
  SegmentedButton(..s, selection_mode: selection_mode)
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
  element(
    "m3e-segmented-button",
    list.flatten([
      [
        boolean_attribute("disabled", s.interaction == Disabled),
        boolean_attribute(
          "hide-selection-indicator",
          s.indicator_visibility == Hidden,
        ),
        boolean_attribute("multi", s.selection_mode == Multi),
        option_attribute(s.name, fn(_) { "name" }, function.identity, None),
      ],
      attributes,
    ])
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

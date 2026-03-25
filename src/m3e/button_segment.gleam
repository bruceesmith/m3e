//// button_segment provides Lustre support for the [M3E Button Segment component](https://matraic.github.io/m3e/#/components/segmented-button.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}
import m3e/state.{type Interaction, type SelectionState, Disabled, Selected}

// --- Types ---

/// ButtonSegment provides Lustre support for the [M3E Button Segment component](https://matraic.github.io/m3e/#/components/segmented-button.html)
///
/// ## Fields:
/// - checked: Whether the element is checked
/// - disabled: Whether the element is disabled
/// - value: A string representing the value of the segment
///
pub opaque type ButtonSegment {
  ButtonSegment(
    checked: SelectionState,
    disabled: Interaction,
    value: Option(String),
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders an icon before the option's label 
}

// --- CONFIGURATION ---

/// Config allows for a declarative configuration of the ButtonSegment
///
pub type Config {
  Config(checked: SelectionState, disabled: Interaction, value: Option(String))
}

/// default_config returns a default Config
///
pub fn default_config() -> Config {
  Config(
    checked: state.default_selection_state,
    disabled: state.default_interaction,
    value: None,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a ButtonSegment from a Config
///
pub fn from_config(c: Config) -> ButtonSegment {
  ButtonSegment(checked: c.checked, disabled: c.disabled, value: c.value)
}

/// new creates a new ButtonSegment
///
pub fn new() -> ButtonSegment {
  from_config(default_config())
}

// --- SETTERS ---

/// checked sets the checked field
///
pub fn checked(b: ButtonSegment, checked: SelectionState) -> ButtonSegment {
  ButtonSegment(..b, checked: checked)
}

/// disabled sets the disabled field
///
pub fn disabled(b: ButtonSegment, disabled: Interaction) -> ButtonSegment {
  ButtonSegment(..b, disabled: disabled)
}

/// value sets the value field
///
pub fn value(b: ButtonSegment, value: Option(String)) -> ButtonSegment {
  ButtonSegment(..b, value: value)
}

// --- RENDERING ---

/// render_config creates a Lustre Element from a Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// render creates a Lustre Element(msg) from a ButtonSegment
///
/// ## Parameters:
/// - b: a ButtonSegment
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  b: ButtonSegment,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-button-segment",
    list.flatten([
      [
        boolean_attribute("checked", b.checked == Selected),
        boolean_attribute("disabled", b.disabled == Disabled),
        option_attribute(b.value, fn(_) { "value" }, function.identity, None),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Icon -> attribute("slot", "icon")
  }
}

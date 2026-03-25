//// option provides Lustre support for the [M3E Option component](https://matraic.github.io/m3e/#/components/option.html)

import gleam/function
import gleam/list
import gleam/option.{type Option as GleamOption, None}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute, option_attribute}
import m3e/state.{
  type Interaction, type SelectionState, Disabled, Selected, Unselected,
}

// --- TYPES ---

/// Option holds all information to create an Option
///
/// ## Fields:
/// - interaction: Whether the element is enabled or disabled
/// - selection: Whether the element is selected
/// - value: A string representing the value of the option
/// 
pub opaque type Option {
  Option(
    interaction: Interaction,
    selection: SelectionState,
    value: GleamOption(String),
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for an Option
/// 
pub type Config {
  Config(
    interaction: Interaction,
    selection: SelectionState,
    value: GleamOption(String),
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    interaction: state.default_interaction,
    selection: Unselected,
    value: None,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Option with default values
///
pub fn new() -> Option {
  from_config(default_config())
}

/// from_config creates an Option from a Config record
/// 
pub fn from_config(c: Config) -> Option {
  Option(interaction: c.interaction, selection: c.selection, value: c.value)
}

// --- SETTERS ---

/// disabled sets the interaction field
/// 
pub fn disabled(o: Option, interaction: Interaction) -> Option {
  Option(..o, interaction: interaction)
}

/// selected sets the selection field
/// 
pub fn selected(o: Option, selection: SelectionState) -> Option {
  Option(..o, selection: selection)
}

/// value sets the value field
/// 
pub fn value(o: Option, value: GleamOption(String)) -> Option {
  Option(..o, value: value)
}

// --- RENDERING ---

/// render creates an M3E Option component from an Option
///
pub fn render(
  o: Option,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-option",
    list.flatten([
      [
        boolean_attribute("disabled", o.interaction == Disabled),
        boolean_attribute("selected", o.selection == Selected),
        option_attribute(o.value, fn(_) { "value" }, function.identity, None),
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

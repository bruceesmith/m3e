//// input_chip_set provides Lustre support for the [M3E Input  Chip Set component](https://matraic.github.io/m3e/#/components/chip-set.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/layout.{type Orientation, Vertical}
import m3e/state.{type Interaction, type Requirement, Disabled, Required}

// --- Types --- 

/// InputChipSet contains all the information for a InputChipSet
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - name: The name that identifies the element when submitting the associated form
/// - required: Whether a value is required for the element
/// - vertical: Whether the element is oriented vertically
///
pub opaque type InputChipSet {
  InputChipSet(
    disabled: Interaction,
    name: Option(String),
    required: Requirement,
    vertical: Orientation,
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Input
  // Renders the input element used to add new chips to the set
}

// --- CONFIGURATION ---

/// Config holds the configuration for a InputChipSet
///  
pub type Config {
  Config(
    disabled: Interaction,
    name: Option(String),
    required: Requirement,
    vertical: Orientation,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    disabled: state.default_interaction,
    name: None,
    required: state.default_requirement,
    vertical: layout.default_orientation,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new InputChipSet with default values
///
pub fn new() -> InputChipSet {
  from_config(default_config())
}

/// from_config creates a InputChipSet from a Config record
/// 
pub fn from_config(c: Config) -> InputChipSet {
  InputChipSet(
    disabled: c.disabled,
    name: c.name,
    required: c.required,
    vertical: c.vertical,
  )
}

// --- SETTERS ---

/// disabled sets the `disabled` field
///
pub fn disabled(c: InputChipSet, disabled: Interaction) -> InputChipSet {
  InputChipSet(..c, disabled: disabled)
}

/// name sets the `name` field
///
pub fn name(c: InputChipSet, name: Option(String)) -> InputChipSet {
  InputChipSet(..c, name: name)
}

/// required sets the `required` field
///
pub fn required(c: InputChipSet, required: Requirement) -> InputChipSet {
  InputChipSet(..c, required: required)
}

/// vertical sets the `vertical` field
///
pub fn vertical(s: InputChipSet, vertical: Orientation) -> InputChipSet {
  InputChipSet(..s, vertical: vertical)
}

// --- RENDERING ---

/// render creates a Lustre Element from a InputChipSet
///
pub fn render(
  s: InputChipSet,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-input-chip-set",
    list.append(
      [
        helpers.boolean_attribute("disabled", s.disabled == Disabled),
        helpers.option_attribute(
          s.name,
          fn(_) { "name" },
          function.identity,
          None,
        ),
        helpers.boolean_attribute("required", s.required == Required),
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

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Input -> attribute.attribute("slot", "input")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

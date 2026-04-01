//// radio_group provides Lustre support for the [M3E Radio Group component](https://matraic.github.io/m3e/#/components/radio-group.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/state.{type Interaction, type Requirement, Disabled, Required}

// --- Types ---

/// RadioGroup provides Lustre support for the [M3E Radio Group component](https://matraic.github.io/m3e/#/components/radio-group.html)
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - id: The id of the element
/// - name: The name that identifies the element when submitting the associated form
/// - required: Whether the element is required
/// 
pub opaque type RadioGroup {
  RadioGroup(
    disabled: Interaction,
    id: Option(String),
    name: Option(String),
    required: Requirement,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a RadioGroup
/// 
pub type Config {
  Config(
    disabled: Interaction,
    id: Option(String),
    name: Option(String),
    required: Requirement,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    disabled: state.default_interaction,
    id: None,
    name: None,
    required: state.default_requirement,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new RadioGroup with default values
///
pub fn new() -> RadioGroup {
  from_config(default_config())
}

/// from_config creates a RadioGroup from a Config record
/// 
pub fn from_config(c: Config) -> RadioGroup {
  RadioGroup(disabled: c.disabled, id: c.id, name: c.name, required: c.required)
}

// --- SETTERS ---

/// disabled sets the disabled field
///
pub fn disabled(group: RadioGroup, disabled: Interaction) -> RadioGroup {
  RadioGroup(..group, disabled: disabled)
}

/// id sets the id field
///
pub fn id(group: RadioGroup, id: Option(String)) -> RadioGroup {
  RadioGroup(..group, id: id)
}

/// name sets the name field
///
pub fn name(group: RadioGroup, name: Option(String)) -> RadioGroup {
  RadioGroup(..group, name: name)
}

/// required sets the required field
///
pub fn required(group: RadioGroup, required: Requirement) -> RadioGroup {
  RadioGroup(..group, required: required)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a RadioGroup
///
/// ## Parameters:
/// - group: a RadioGroup
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  group: RadioGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-radio-group",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", group.disabled == Disabled),
        helpers.option_attribute(
          group.id,
          fn(_) { "id" },
          function.identity,
          None,
        ),
        helpers.option_attribute(
          group.name,
          fn(_) { "name" },
          function.identity,
          None,
        ),
        helpers.boolean_attribute("required", group.required == Required),
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

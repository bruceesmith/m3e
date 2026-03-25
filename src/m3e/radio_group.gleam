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
/// - interaction: Whether the element is enabled or disabled.
/// - id: The id of the element
/// - name: The name that identifies the element when submitting the associated form
/// - requirement: Whether the element is required
/// 
pub opaque type RadioGroup {
  RadioGroup(
    interaction: Interaction,
    id: Option(String),
    name: Option(String),
    requirement: Requirement,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a RadioGroup
/// 
pub type Config {
  Config(
    interaction: Interaction,
    id: Option(String),
    name: Option(String),
    requirement: Requirement,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    interaction: state.default_interaction,
    id: None,
    name: None,
    requirement: state.default_requirement,
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
  RadioGroup(
    interaction: c.interaction,
    id: c.id,
    name: c.name,
    requirement: c.requirement,
  )
}

// --- SETTERS ---

/// disabled sets the interaction field
///
pub fn disabled(group: RadioGroup, interaction: Interaction) -> RadioGroup {
  RadioGroup(..group, interaction: interaction)
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

/// required sets the requirement field
///
pub fn required(group: RadioGroup, requirement: Requirement) -> RadioGroup {
  RadioGroup(..group, requirement: requirement)
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
        helpers.boolean_attribute("disabled", group.interaction == Disabled),
        helpers.option_attribute(group.id, fn(_) { "id" }, function.identity, None),
        helpers.option_attribute(group.name, fn(_) { "name" }, function.identity, None),
        helpers.boolean_attribute("required", group.requirement == Required),
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

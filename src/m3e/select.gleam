//// select provides Lustre support for the [M3E Select component](https://matraic.github.io/m3e/#/components/select.html)

import gleam/function
import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/config.{type SelectionMode, Multi}
import m3e/helpers.{boolean_attribute, option_attribute}
import m3e/types.{
  type Interaction, type Requirement, Disabled, Required, default_interaction,
  default_requirement,
}

// --- Types ---

/// IndicatorVisibility specifies if the selection indicator is visible or hidden
pub type IndicatorVisibility {
  Visible
  Hidden
}

pub const default_indicator_visibility: IndicatorVisibility = Visible

/// Select provides a form control for selecting a value from a set of predefined options)
/// 
/// ## Fields:
/// - interaction: Whether the element is enabled or disabled
/// - indicator_visibility: Whether to hide the selection indicator for single select options
/// - id: The id of the element
/// - selection_mode: Whether multiple options can be selected
/// - name: The name that identifies the element when submitting the associated form
/// - requirement: Whether the element is required
///
pub opaque type Select {
  Select(
    interaction: Interaction,
    indicator_visibility: IndicatorVisibility,
    id: Option(String),
    selection_mode: SelectionMode,
    name: Option(String),
    requirement: Requirement,
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Arrow
  // Renders the dropdown arrow 
  Value
  // Renders the selected value(s) 
}

// --- CONFIGURATION ---

/// Config holds the configuration for a Select
/// 
pub type Config {
  Config(
    interaction: Interaction,
    indicator_visibility: IndicatorVisibility,
    id: Option(String),
    selection_mode: SelectionMode,
    name: Option(String),
    requirement: Requirement,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    interaction: default_interaction,
    indicator_visibility: default_indicator_visibility,
    id: None,
    selection_mode: config.default_selection_mode,
    name: None,
    requirement: default_requirement,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Select with default values
/// 
pub fn new() -> Select {
  from_config(default_config())
}

/// from_config creates a Select from a Config record
/// 
pub fn from_config(c: Config) -> Select {
  Select(
    interaction: c.interaction,
    indicator_visibility: c.indicator_visibility,
    id: c.id,
    selection_mode: c.selection_mode,
    name: c.name,
    requirement: c.requirement,
  )
}

// --- SETTERS ---

/// disabled sets the interaction field
/// 
pub fn disabled(s: Select, interaction: Interaction) -> Select {
  Select(..s, interaction: interaction)
}

/// hide_selection_indicator sets the indicator_visibility field
/// 
pub fn hide_selection_indicator(
  s: Select,
  indicator_visibility: IndicatorVisibility,
) -> Select {
  Select(..s, indicator_visibility: indicator_visibility)
}

/// id sets the id field
/// 
pub fn id(s: Select, id: Option(String)) -> Select {
  Select(..s, id: id)
}

/// multi sets the selection_mode field
/// 
pub fn multi(s: Select, selection_mode: SelectionMode) -> Select {
  Select(..s, selection_mode: selection_mode)
}

/// name sets the name field
/// 
pub fn name(s: Select, name: Option(String)) -> Select {
  Select(..s, name: name)
}

/// required sets the requirement field
/// 
pub fn required(s: Select, requirement: Requirement) -> Select {
  Select(..s, requirement: requirement)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Select
/// 
/// ## Parameters:
/// - s: a Select
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  s: Select,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-select",
    flatten([
      [
        boolean_attribute("disabled", s.interaction == Disabled),
        boolean_attribute(
          "hide-selection-indicator",
          s.indicator_visibility == Hidden,
        ),
        option_attribute(s.id, fn(_) { "id" }, function.identity, None),
        boolean_attribute("multi", s.selection_mode == Multi),
        option_attribute(s.name, fn(_) { "name" }, function.identity, None),
        boolean_attribute("required", s.requirement == Required),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
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
    Arrow -> attribute("slot", "arrow")
    Value -> attribute("slot", "value")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

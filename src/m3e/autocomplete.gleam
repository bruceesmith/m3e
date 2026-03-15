//// autocomplete provides Lustre support for the [M3E Autocomplete component](https://matraic.github.io/m3e/#/components/autocomplete.html)

import gleam/list.{filter, map}

import lustre/attribute.{attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/option.{type Option}

// --- Types ---

/// Activation specifies if the first option should be automatically activated
pub type Activation {
  AutoActivate
  ManualActivate
}

/// SelectionIndicator specifies if the selection indicator should be shown
pub type SelectionIndicator {
  ShowSelectionIndicator
  HideSelectionIndicator
}

/// Requirement specifies if a selection is required
pub type Requirement {
  Required
  Optional
}

/// Autocomplete holds all information to create an Autocomplete
///
/// ## Fields:
/// - auto_activate: Whether the first option should be automatically activated
/// - for: The identifier of the interactive control to which this element is attached
/// - selection_indicator: Whether to hide the selection indicator
/// - requirement: Whether the user is required to make a selection
///
pub opaque type Autocomplete {
  Autocomplete(
    auto_activate: Activation,
    for: String,
    selection_indicator: SelectionIndicator,
    requirement: Requirement,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for an Autocomplete
///
pub type Config {
  Config(
    auto_activate: Activation,
    for: String,
    selection_indicator: SelectionIndicator,
    requirement: Requirement,
  )
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(
    auto_activate: ManualActivate,
    for: "",
    selection_indicator: ShowSelectionIndicator,
    requirement: Optional,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Autocomplete
///
/// ## Parameters:
/// - for: The identifier of the interactive control to which this element is attached
///
pub fn new(for: String) -> Autocomplete {
  Autocomplete(
    auto_activate: ManualActivate,
    for: for,
    selection_indicator: ShowSelectionIndicator,
    requirement: Optional,
  )
}

/// from_config creates an Autocomplete from a Config record
///
pub fn from_config(c: Config) -> Autocomplete {
  Autocomplete(
    auto_activate: c.auto_activate,
    for: c.for,
    selection_indicator: c.selection_indicator,
    requirement: c.requirement,
  )
}

// --- SETTERS ---

/// auto_activate sets the auto_activate field of an Autocomplete
/// 
pub fn auto_activate(a: Autocomplete, activation: Activation) -> Autocomplete {
  Autocomplete(..a, auto_activate: activation)
}

/// for sets the for field of an Autocomplete
///
pub fn for(a: Autocomplete, for: String) -> Autocomplete {
  Autocomplete(..a, for: for)
}

/// selection_indicator sets the selection_indicator field of an Autocomplete
///
pub fn selection_indicator(
  a: Autocomplete,
  indicator: SelectionIndicator,
) -> Autocomplete {
  Autocomplete(..a, selection_indicator: indicator)
}

/// requirement sets the requirement field of an Autocomplete
///
pub fn requirement(a: Autocomplete, requirement: Requirement) -> Autocomplete {
  Autocomplete(..a, requirement: requirement)
}

// --- RENDERING ---

/// render creates an M3E Autocomplete component from an Autocomplete
///
pub fn render(a: Autocomplete, children: List(Option)) -> Element(msg) {
  element(
    "m3e-autocomplete",
    [
      boolean_attribute("auto-activate", a.auto_activate == AutoActivate),
      attribute("for", a.for),
      boolean_attribute(
        "hide-selection-indicator",
        a.selection_indicator == HideSelectionIndicator,
      ),
      boolean_attribute("required", a.requirement == Required),
    ]
      |> filter(fn(a) { a != none() }),
    map(children, fn(o) { option.render(o, [], []) }),
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(config: Config, children: List(Option)) -> Element(msg) {
  render(from_config(config), children)
}

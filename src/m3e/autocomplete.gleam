//// autocomplete provides Lustre support for the [M3E Autocomplete component](https://matraic.github.io/m3e/#/components/autocomplete.html)

import gleam/list.{filter, map}

import lustre/attribute.{attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/option.{type Option}

/// Autocomplete holds all information to create an Autocomplete
///
/// ## Fields:
/// - auto_activate: Whether the first option should be automatically activated
/// - for: The identifier of the interactive control to which this element is attached
/// - required: Whether the user is required to make a selection when interacting with the autocomplete
/// - hide_selection_indicator: Whether to hide the selection indicator
///
pub type Autocomplete {
  Autocomplete(
    auto_activate: Bool,
    for: String,
    required: Bool,
    hide_selection_indicator: Bool,
  )
}

/// new creates a new Autocomplete
///
/// ## Parameters:
/// - for: The identifier of the interactive control to which this element is attached
///
pub fn new(for: String) -> Autocomplete {
  Autocomplete(
    auto_activate: False,
    for: for,
    required: False,
    hide_selection_indicator: False,
  )
}

/// render creates an M3E Autocomplete component from an Autocomplete
///
pub fn render(a: Autocomplete, children: List(Option)) -> Element(msg) {
  element(
    "m3e-autocomplete",
    [
      boolean_attribute("auto-activate", a.auto_activate),
      attribute("for", a.for),
      boolean_attribute("required", a.required),
      boolean_attribute("hide-selection-indicator", a.hide_selection_indicator),
    ]
      |> filter(fn(a) { a != none() }),
    map(children, fn(o) { option.render(o, [], []) }),
  )
}

/// auto_activate sets the auto_activate field of an Autocomplete
/// 
pub fn auto_activate(a: Autocomplete, auto_activate: Bool) -> Autocomplete {
  Autocomplete(..a, auto_activate: auto_activate)
}

/// for sets the for field of an Autocomplete
///
pub fn for(a: Autocomplete, for: String) -> Autocomplete {
  Autocomplete(..a, for: for)
}

/// required sets the required field of an Autocomplete
///
pub fn required(a: Autocomplete, required: Bool) -> Autocomplete {
  Autocomplete(..a, required: required)
}

/// hide_selection_indicator sets the hide_selection_indicator field of an Autocomplete
///
pub fn hide_selection_indicator(
  a: Autocomplete,
  hide_selection_indicator: Bool,
) -> Autocomplete {
  Autocomplete(..a, hide_selection_indicator: hide_selection_indicator)
}

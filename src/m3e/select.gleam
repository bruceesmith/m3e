//// select provides Lustre support for the [M3E Select component](https://matraic.github.io/m3e/#/components/select.html)

import gleam/function
import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

// --- Types ---

/// Select provides a form control for selecting a value from a set of predefined options)
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - hide_selection_indicator: Whether to hide the selection indicator for single select options
/// - multi: Whether multiple options can be selected
/// - name: The name that identifies the element when submitting the associated form
/// - required: Whether the element is required
///
pub opaque type Select {
  Select(
    disabled: Bool,
    hide_selection_indicator: Bool,
    id: Option(String),
    multi: Bool,
    name: Option(String),
    required: Bool,
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

// --- CONSTRUCTORS ---

/// new creates a new Select
/// 
pub fn new() -> Select {
  Select(
    disabled: False,
    hide_selection_indicator: False,
    id: None,
    multi: False,
    name: None,
    required: False,
  )
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(s: Select, disabled: Bool) -> Select {
  Select(..s, disabled: disabled)
}

/// hide_selection_indicator sets the hide_selection_indicator field
/// 
pub fn hide_selection_indicator(
  s: Select,
  hide_selection_indicator: Bool,
) -> Select {
  Select(..s, hide_selection_indicator: hide_selection_indicator)
}

/// id sets the id field
/// 
pub fn id(s: Select, id: Option(String)) -> Select {
  Select(..s, id: id)
}

/// multi sets the multi field
/// 
pub fn multi(s: Select, multi: Bool) -> Select {
  Select(..s, multi: multi)
}

/// name sets the name field
/// 
pub fn name(s: Select, name: Option(String)) -> Select {
  Select(..s, name: name)
}

/// required sets the required field
/// 
pub fn required(s: Select, required: Bool) -> Select {
  Select(..s, required: required)
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
        boolean_attribute("disabled", s.disabled),
        boolean_attribute(
          "hide-selection-indicator",
          s.hide_selection_indicator,
        ),
        option_attribute(s.id, fn(_) { "id" }, function.identity, None),
        boolean_attribute("multi", s.multi),
        option_attribute(s.name, fn(_) { "name" }, function.identity, None),
        boolean_attribute("required", s.required),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
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

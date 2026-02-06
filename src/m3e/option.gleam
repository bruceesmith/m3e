//// button provides Lustre support for the [M3E Option component](https://matraic.github.io/m3e/#/components/option.html)

import gleam/function
import gleam/list.{filter}
import gleam/option

import lustre/attribute
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// Option holds all information to create an Option
///
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - selected: Whether the element is selected
/// - value: A string representing the value of the option
/// 
pub type Option {
  Option(disabled: Bool, selected: Bool, value: option.Option(String))
}

/// new creates a new Option
///
/// ## Parameters:
/// - disabled: Whether the element is disabled
/// - selected: Whether the element is selected
/// - value: A string representing the value of the option
/// 
pub fn new(
  disabled: Bool,
  selected: Bool,
  value: option.Option(String),
) -> Option {
  Option(disabled: disabled, selected: selected, value: value)
}

/// render creates an M3E Option component from an Option
///
pub fn render(o: Option) -> Element(msg) {
  element(
    "m3e-option",
    [
      boolean_attribute("disabled", o.disabled),
      boolean_attribute("selected", o.selected),
      option_attribute(
        o.value,
        fn(_) { "value" },
        function.identity,
        option.None,
      ),
    ]
      |> filter(fn(a) { a != attribute.none() }),
    [],
  )
}

/// disabled sets the disabled attribute
/// 
pub fn disabled(o: Option, disabled: Bool) -> Option {
  Option(..o, disabled: disabled)
}

/// selected sets the selected attribute
/// 
pub fn selected(o: Option, selected: Bool) -> Option {
  Option(..o, selected: selected)
}

/// value sets the value attribute
/// 
pub fn value(o: Option, value: option.Option(String)) -> Option {
  Option(..o, value: value)
}

//// checkbox provides Lustre support for the [M3E Checkbox component](https://matraic.github.io/m3e/#/components/checkbox.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// Checkbox holds all the values necessary to construct am M3E Checkbox
///
pub opaque type Checkbox {
  Checkbox(
    checked: Bool,
    disabled: Bool,
    name: Option(String),
    required: Bool,
    value: Option(String),
  )
}

pub const default_value = "on"

/// new creates a new Checkbox
///
pub fn new() -> Checkbox {
  Checkbox(
    checked: False,
    disabled: False,
    name: None,
    required: False,
    value: None,
  )
}

/// render creates an HTML m3e-checkbox component from a Checkbox
///
pub fn render(checkbox: Checkbox) -> Element(msg) {
  element(
    "m3e-checkbox",
    [
      boolean_attribute("checked", checkbox.checked),
      boolean_attribute("disabled", checkbox.disabled),
      option_attribute(checkbox.name, fn(_) { "name" }, function.identity, None),
      boolean_attribute("required", checkbox.required),
      option_attribute(
        checkbox.value,
        fn(_) { "value" },
        function.identity,
        None,
      ),
    ]
      |> list.filter(fn(a) { a != none() }),
    [],
  )
}

/// checked sets the `checked` field
///
pub fn checked(checkbox: Checkbox, checked: Bool) -> Checkbox {
  Checkbox(..checkbox, checked: checked)
}

/// disabled sets the `disabled` field
///
pub fn disabled(checkbox: Checkbox, disabled: Bool) -> Checkbox {
  Checkbox(..checkbox, disabled: disabled)
}

/// form sets up a Checkbox to participate in an HTML form
/// 
/// Pass None to name & value to clear the form controls
///
/// ## Parameters:
/// - checkbox: a Checkbox
/// - name: the name of the checkbox when the form is submitted
/// - value: the value of the checkbox when the form is submitted
///
pub fn form(
  checkbox: Checkbox,
  name: Option(String),
  value: Option(String),
) -> Checkbox {
  Checkbox(..checkbox, name: name, value: value)
}

/// required sets the `required` field
///
pub fn required(checkbox: Checkbox, required: Bool) -> Checkbox {
  Checkbox(..checkbox, required: required)
}

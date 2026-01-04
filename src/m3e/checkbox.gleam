//// button provides Lustre support for the [M3E Checkbox component](https://matraic.github.io/m3e/#/components/checkbox.html)

import gleam/function
import gleam/option.{type Option, None}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// Checkbox holds all the values necessary to construct am M3E Checkbox
///
pub type Checkbox {
  Checkbox(
    checked: Bool,
    disabled: Bool,
    key: Option(String),
    required: Bool,
    value: Option(String),
  )
}

pub const default_value = "on"

/// checkbox creates an HTML m3e-checkbox component
///
pub fn checkbox(
  checked: Bool,
  disabled: Bool,
  key: Option(String),
  required: Bool,
  value: Option(String),
) {
  Checkbox(
    checked: checked,
    disabled: disabled,
    key: key,
    required: required,
    value: value,
  )
}

/// element creates an HTML m3e-checkbox component from a Checkbox
///
pub fn element(checkbox: Checkbox) -> Element(msg) {
  element.element(
    "m3e-checkbox",
    [
      boolean_attribute("checked", checkbox.checked),
      boolean_attribute("disabled", checkbox.disabled),
      option_attribute(checkbox.key, fn(_) { "name" }, function.identity, None),
      boolean_attribute("required", checkbox.required),
      option_attribute(
        checkbox.value,
        fn(_) { "value" },
        function.identity,
        None,
      ),
    ],
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
/// ## Parameters:
/// - checkbox: a Checkbox
/// - key: the name of the checkbox when the form is submitted
/// - value: the value of the checkbox when the form is submitted
///
pub fn form(
  checkbox: Checkbox,
  key: Option(String),
  value: Option(String),
) -> Checkbox {
  Checkbox(..checkbox, key: key, value: value)
}

/// key sets the`key` field
///
pub fn key(checkbox: Checkbox, key: Option(String)) -> Checkbox {
  Checkbox(..checkbox, key: key)
}

/// required sets the `required` field
///
pub fn required(checkbox: Checkbox, required: Bool) -> Checkbox {
  Checkbox(..checkbox, required: required)
}

/// value sets the`value` field
///
pub fn value(checkbox: Checkbox, value: Option(String)) -> Checkbox {
  Checkbox(..checkbox, value: value)
}

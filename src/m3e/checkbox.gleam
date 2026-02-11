//// checkbox provides Lustre support for the [M3E Checkbox component](https://matraic.github.io/m3e/#/components/checkbox.html)

import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{none}
import lustre/element.{type Element, element}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers.{boolean_attribute}

/// Checkbox holds all the values necessary to construct am M3E Checkbox
///
/// - checked: whether the checkbox is checked
/// - disabled: whether the checkbox is disabled
/// - form_submission: handles this element's role in form submission
/// - required: Whether a value is required for the element
///
pub opaque type Checkbox {
  Checkbox(
    checked: Bool,
    disabled: Bool,
    form_submission: Option(FormSubmission),
    required: Bool,
  )
}

pub const default_value = "on"

/// new creates a new Checkbox
///
pub fn new() -> Checkbox {
  Checkbox(
    checked: False,
    disabled: False,
    form_submission: None,
    required: False,
  )
}

/// render creates an HTML m3e-checkbox component from a Checkbox
///
pub fn render(checkbox: Checkbox) -> Element(msg) {
  element(
    "m3e-checkbox",
    flatten([
      [
        boolean_attribute("checked", checkbox.checked),
        boolean_attribute("disabled", checkbox.disabled),
        boolean_attribute("required", checkbox.required),
      ],
      form_submission.attributes(checkbox.form_submission),
    ])
      |> filter(fn(a) { a != none() }),
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
/// - form_submission: a FormSubmission
///
pub fn form(
  checkbox: Checkbox,
  form_submission: Option(FormSubmission),
) -> Checkbox {
  Checkbox(..checkbox, form_submission: form_submission)
}

/// required sets the `required` field
///
pub fn required(checkbox: Checkbox, required: Bool) -> Checkbox {
  Checkbox(..checkbox, required: required)
}

//// radio provides Lustre support for the [M3E Radio component](https://matraic.github.io/m3e/#/components/radio-group.html)

import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers.{boolean_attribute}

/// Radio provides Lustre support for the [M3E Radio component](https://matraic.github.io/m3e/#/components/radio.html)
/// 
/// ## Fields:
/// - checked: Whether the element is checked
/// - disabled: Whether the element is disabled
/// - form_submission: handles this button's role in form submission
/// - required: Whether the element is required
///
pub opaque type Radio {
  Radio(
    checked: Bool,
    disabled: Bool,
    form_submission: Option(FormSubmission),
    required: Bool,
  )
}

/// new creates a new Radio
/// 
pub fn new() -> Radio {
  Radio(checked: False, disabled: False, form_submission: None, required: False)
}

/// checked sets the checked field
/// 
pub fn checked(r: Radio, checked: Bool) -> Radio {
  Radio(..r, checked: checked)
}

/// disabled sets the disabled field
/// 
pub fn disabled(r: Radio, disabled: Bool) -> Radio {
  Radio(..r, disabled: disabled)
}

/// form_submission sets up a Radio to participate in an HTML form
/// 
pub fn form(r: Radio, fs: Option(FormSubmission)) -> Radio {
  Radio(..r, form_submission: fs)
}

/// required sets the required field
/// 
pub fn required(r: Radio, required: Bool) -> Radio {
  Radio(..r, required: required)
}

/// render creates a Lustre Element(msg) from a Radio
/// 
/// ## Parameters:
/// - r: a Radio
/// - attributes: additional attributes
/// - children: additional children
/// 
pub fn render(
  r: Radio,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-radio",
    flatten([
      [
        boolean_attribute("checked", r.checked),
        boolean_attribute("disabled", r.disabled),
        boolean_attribute("required", r.required),
      ],
      form_submission.attributes(r.form_submission),
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

//// switch provides Lustre support for the [M3E Switch component](https://matraic.github.io/m3e/#/components/switch.html)

import gleam/list
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import lustre/element/html.{text}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers.{boolean_attribute}

pub type Icons {
  Both
  Neither
  Selected
}

fn icons_to_string(i: Icons) -> String {
  case i {
    Both -> "both"
    Neither -> "none"
    Selected -> "selected"
  }
}

/// Switch is a configuration type representing an M3E Switch
/// 
/// ## Fields:
/// - id: id of the switch,
/// - label: label on the switch
/// - icons: The icons to present
/// - checked: Whether the element is checked
/// - disabled: Whether the element is disabled
/// - form_submission: handles this element's role in form submission
/// 
pub opaque type Switch {
  Switch(
    id: String,
    label: Option(String),
    icons: Icons,
    checked: Bool,
    disabled: Bool,
    form_submission: Option(FormSubmission),
  )
}

/// new creates a Switch with default values
///
pub fn new(id: String) -> Switch {
  Switch(
    id: id,
    label: None,
    icons: Neither,
    checked: False,
    disabled: False,
    form_submission: None,
  )
}

/// checked sets the checked field
///
pub fn checked(s: Switch, checked: Bool) -> Switch {
  Switch(..s, checked: checked)
}

/// disabled sets the disabled field
///
pub fn disabled(s: Switch, disabled: Bool) -> Switch {
  Switch(..s, disabled: disabled)
}

/// label sets the label field
///
pub fn label(s: Switch, label: Option(String)) -> Switch {
  Switch(..s, label: label)
}

/// render creates a list of Lustre Elements from a Switch
///
pub fn render(s: Switch, attributes: List(Attribute(msg))) -> List(Element(msg)) {
  let switch_element =
    element(
      "m3e-switch",
      list.flatten([
        [
          attribute("id", s.id),
          attribute("icons", icons_to_string(s.icons)),
          boolean_attribute("checked", s.checked),
          boolean_attribute("disabled", s.disabled),
        ],
        form_submission.attributes(s.form_submission),
        attributes,
      ])
        |> list.filter(fn(a) { a != none() }),
      [],
    )

  case s.label {
    Some(label) -> [
      switch_element,
      element("label", [attribute("for", s.id)], [text(label)]),
    ]
    None -> [switch_element]
  }
}

/// form sets theform_submission field when the switch is used in a form
///
/// Pass None to name & value to clear the form controls
///
pub fn form(s: Switch, form_submission: Option(FormSubmission)) -> Switch {
  Switch(..s, form_submission: form_submission)
}

/// icon sets the icons field
///
pub fn icon(s: Switch, icons: Icons) -> Switch {
  Switch(..s, icons: icons)
}

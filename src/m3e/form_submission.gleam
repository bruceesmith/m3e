//// form_submitter_type provides types and related functions for handling form submission elements

import gleam/list.{filter}
import gleam/option.{type Option, Some}

import lustre/attribute.{type Attribute, attribute, none}

/// FormSubmitterType is the type of an element when used inside a form
///
pub type FormSubmitterType {
  Button
  Reset
  Submit
}

/// form_submitter_type_to_string converts a FormSubmitterType to a string
///
pub fn form_submitter_type_to_string(t: FormSubmitterType) -> String {
  case t {
    Button -> "button"
    Reset -> "reset"
    Submit -> "submit"
  }
}

pub const default_form_submitter_type = Button

/// FormSubmission is the fields used when an element is submitted as part of a form
/// 
/// ## Fields:
/// - type_: The submission type of the element
/// - name: The name of the element, submitted as a pair with the element's value as part of form data, when the element is used to submit a form
/// - value: The value associated with the element's name when it's submitted with form data
/// 
pub type FormSubmission {
  FormSubmission(type_: FormSubmitterType, name: String, value: String)
}

/// new_form_submission creates a new FormSubmission
///
pub fn new() -> FormSubmission {
  FormSubmission(default_form_submitter_type, "", "")
}

/// type_ sets the `type_` field
///
pub fn type_(fs: FormSubmission, type_: FormSubmitterType) -> FormSubmission {
  FormSubmission(..fs, type_: type_)
}

/// name sets the `name` field
///
pub fn name(fs: FormSubmission, name: String) -> FormSubmission {
  FormSubmission(..fs, name: name)
}

/// value sets the `value` field
///
pub fn value(fs: FormSubmission, value: String) -> FormSubmission {
  FormSubmission(..fs, value: value)
}

/// attributes creates Lustre Attributes for a FormSubmission
///
pub fn attributes(fs: Option(FormSubmission)) -> List(Attribute(msg)) {
  case fs {
    Some(sub) if sub.type_ == Button || sub.type_ == Reset -> {
      [attribute("type", form_submitter_type_to_string(sub.type_))]
    }
    Some(sub) if sub.type_ == Submit && sub.name != "" -> {
      [
        attribute("type", "submit"),
        attribute("name", sub.name),
        attribute("value", sub.value),
      ]
    }
    _ -> [none()]
  }
  |> filter(fn(a) { a != none() })
}

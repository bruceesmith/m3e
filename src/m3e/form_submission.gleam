//// form_submitter_type provides the FormSubmitterType type and related functions

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

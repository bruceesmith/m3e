//// checkbox provides Lustre support for the [M3E Checkbox component](https://matraic.github.io/m3e/#/components/checkbox.html)

import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute
import lustre/element.{type Element}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers
import m3e/state.{
  type CheckedState, type Interaction, type Requirement, Checked, Disabled,
  Optional, Required,
}

// --- Types ---

/// Checkbox holds all the values necessary to construct am M3E Checkbox
///
/// - checked: Whether the element is checked
/// - disabled: Whether the element is disabled
/// - form_submission: handles this element's role in form submission
/// - indeterminate: Whether the element's checked state is indeterminate
/// - required: Whether the element is required
///
pub opaque type Checkbox {
  Checkbox(
    checked: CheckedState,
    disabled: Interaction,
    form_submission: Option(FormSubmission),
    indeterminate: Mode,
    required: Requirement,
  )
}

pub const default_value = "on"

pub type Mode {
  Determinate
  Indeterminate
}

pub const default_mode = Determinate

// --- CONFIGURATION ---

/// Config holds the configuration for a Checkbox
/// 
pub type Config {
  Config(
    checked: CheckedState,
    disabled: Interaction,
    form_submission: Option(FormSubmission),
    indeterminate: Mode,
    required: Requirement,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    checked: state.default_checked_state,
    disabled: state.default_interaction,
    form_submission: None,
    indeterminate: default_mode,
    required: Optional,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Checkbox with default values
///
pub fn new() -> Checkbox {
  from_config(default_config())
}

/// from_config creates a Checkbox from a Config record
/// 
pub fn from_config(c: Config) -> Checkbox {
  Checkbox(
    checked: c.checked,
    disabled: c.disabled,
    form_submission: c.form_submission,
    indeterminate: c.indeterminate,
    required: c.required,
  )
}

// --- SETTERS ---

/// checked sets the `checked` field
///
pub fn checked(checkbox: Checkbox, state: CheckedState) -> Checkbox {
  Checkbox(..checkbox, checked: state)
}

/// disabled sets the `disabled` field
///
pub fn disabled(checkbox: Checkbox, disabled: Interaction) -> Checkbox {
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

/// indeterminate sets the `indeterminate` field
///
pub fn indeterminate(checkbox: Checkbox, mode: Mode) -> Checkbox {
  Checkbox(..checkbox, indeterminate: mode)
}

/// required sets the `required` field
///
pub fn required(checkbox: Checkbox, required: Requirement) -> Checkbox {
  Checkbox(..checkbox, required: required)
}

// --- RENDERING ---

/// render creates an HTML m3e-checkbox component from a Checkbox
///
pub fn render(checkbox: Checkbox) -> Element(msg) {
  element.element(
    "m3e-checkbox",
    list.flatten([
      [
        helpers.boolean_attribute("checked", checkbox.checked == Checked),
        helpers.boolean_attribute("disabled", checkbox.disabled == Disabled),
        helpers.boolean_attribute(
          "indeterminate",
          checkbox.indeterminate == Indeterminate,
        ),
        helpers.boolean_attribute("required", checkbox.required == Required),
      ],
      form_submission.attributes(checkbox.form_submission),
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    [],
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(config: Config) -> Element(msg) {
  render(from_config(config))
}

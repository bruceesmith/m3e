//// checkbox provides Lustre support for the [M3E Checkbox component](https://matraic.github.io/m3e/#/components/checkbox.html)

import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{none}
import lustre/element.{type Element, element}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers.{boolean_attribute}
import m3e/state.{
  type CheckedState, type Interaction, type Requirement, Checked, Disabled,
  Optional, Required,
}

// --- Types ---

/// Checkbox holds all the values necessary to construct am M3E Checkbox
///
/// - checked: whether the checkbox is checked
/// - interaction: whether the checkbox is enabled or disabled
/// - form_submission: handles this element's role in form submission
/// - requirement: Whether a value is required for the element
///
pub opaque type Checkbox {
  Checkbox(
    checked: CheckedState,
    interaction: Interaction,
    form_submission: Option(FormSubmission),
    requirement: Requirement,
  )
}

pub const default_value = "on"

// --- CONFIGURATION ---

/// Config holds the configuration for a Checkbox
/// 
pub type Config {
  Config(
    checked: CheckedState,
    interaction: Interaction,
    form_submission: Option(FormSubmission),
    requirement: Requirement,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    checked: state.default_checked_state,
    interaction: state.default_interaction,
    form_submission: None,
    requirement: Optional,
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
    interaction: c.interaction,
    form_submission: c.form_submission,
    requirement: c.requirement,
  )
}

// --- SETTERS ---

/// checked sets the `checked` field
///
pub fn checked(checkbox: Checkbox, state: CheckedState) -> Checkbox {
  Checkbox(..checkbox, checked: state)
}

/// disabled sets the `interaction` field
///
pub fn disabled(checkbox: Checkbox, interaction: Interaction) -> Checkbox {
  Checkbox(..checkbox, interaction: interaction)
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

/// requirement sets the `requirement` field
///
pub fn required(checkbox: Checkbox, requirement: Requirement) -> Checkbox {
  Checkbox(..checkbox, requirement: requirement)
}

// --- RENDERING ---

/// render creates an HTML m3e-checkbox component from a Checkbox
///
pub fn render(checkbox: Checkbox) -> Element(msg) {
  element(
    "m3e-checkbox",
    list.flatten([
      [
        boolean_attribute("checked", checkbox.checked == Checked),
        boolean_attribute("disabled", checkbox.interaction == Disabled),
        boolean_attribute("required", checkbox.requirement == Required),
      ],
      form_submission.attributes(checkbox.form_submission),
    ])
      |> list.filter(fn(a) { a != none() }),
    [],
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(config: Config) -> Element(msg) {
  render(from_config(config))
}

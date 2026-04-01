//// radio provides Lustre support for the [M3E Radio component](https://matraic.github.io/m3e/#/components/radio-group.html)

import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers
import m3e/state.{
  type CheckedState, type Interaction, type Requirement, Checked, Disabled,
  Required,
}

// --- Types ---

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
    checked: CheckedState,
    disabled: Interaction,
    form_submission: Option(FormSubmission),
    required: Requirement,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a Radio
/// 
pub type Config {
  Config(
    checked: CheckedState,
    disabled: Interaction,
    form_submission: Option(FormSubmission),
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
    required: state.default_requirement,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Radio with default values
/// 
pub fn new() -> Radio {
  from_config(default_config())
}

/// from_config creates a Radio from a Config record
/// 
pub fn from_config(c: Config) -> Radio {
  Radio(
    checked: c.checked,
    disabled: c.disabled,
    form_submission: c.form_submission,
    required: c.required,
  )
}

// --- SETTERS ---

/// checked sets the checked field
/// 
pub fn checked(r: Radio, state: CheckedState) -> Radio {
  Radio(..r, checked: state)
}

/// disabled sets the disabled field
/// 
pub fn disabled(r: Radio, disabled: Interaction) -> Radio {
  Radio(..r, disabled: disabled)
}

/// form_submission sets up a Radio to participate in an HTML form
/// 
pub fn form(r: Radio, fs: Option(FormSubmission)) -> Radio {
  Radio(..r, form_submission: fs)
}

/// required sets the required field
/// 
pub fn required(r: Radio, required: Requirement) -> Radio {
  Radio(..r, required: required)
}

// --- RENDERING ---

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
  element.element(
    "m3e-radio",
    list.flatten([
      [
        helpers.boolean_attribute("checked", r.checked == Checked),
        helpers.boolean_attribute("disabled", r.disabled == Disabled),
        helpers.boolean_attribute("required", r.required == Required),
      ],
      form_submission.attributes(r.form_submission),
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

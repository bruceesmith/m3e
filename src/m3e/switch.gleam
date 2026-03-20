//// switch provides Lustre support for the [M3E Switch component](https://matraic.github.io/m3e/#/components/switch.html)

import gleam/list
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import lustre/element/html.{text}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers.{boolean_attribute}
import m3e/types.{type Interaction, Disabled, Enabled}

// --- TYPES ---

/// CheckedState specfies if a switch is checked or not
/// 
pub type CheckedState {
  Checked
  Unchecked
}

pub const default_checked_state = Unchecked

pub type Icons {
  Both
  Neither
  Selected
}

pub const default_interaction = Enabled

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
    checked: CheckedState,
    disabled: Interaction,
    form_submission: Option(FormSubmission),
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a Switch
/// 
pub type Config {
  Config(
    label: Option(String),
    icons: Icons,
    checked: CheckedState,
    disabled: Interaction,
    form_submission: Option(FormSubmission),
  )
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(
    label: None,
    icons: Neither,
    checked: Unchecked,
    disabled: Enabled,
    form_submission: None,
  )
}

// --- CONSTRUCTORS ---

/// new creates a Switch with default values
///
pub fn new(id: String) -> Switch {
  Switch(
    id: id,
    label: None,
    icons: Neither,
    checked: Unchecked,
    disabled: Enabled,
    form_submission: None,
  )
}

/// from_config creates a Switch from a Config
///
pub fn from_config(config: Config) -> Switch {
  Switch(
    id: "",
    label: config.label,
    icons: config.icons,
    checked: config.checked,
    disabled: config.disabled,
    form_submission: config.form_submission,
  )
}

// --- SETTERS ---

/// checked sets the checked field
///
pub fn checked(s: Switch, checked: CheckedState) -> Switch {
  Switch(..s, checked: checked)
}

/// disabled sets the disabled field
///
pub fn disabled(s: Switch, disabled: Interaction) -> Switch {
  Switch(..s, disabled: disabled)
}

/// label sets the label field
///
pub fn label(s: Switch, label: Option(String)) -> Switch {
  Switch(..s, label: label)
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

// --- RENDERING ---

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
          boolean_attribute("checked", s.checked == Checked),
          boolean_attribute("disabled", s.disabled == Disabled),
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

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
) -> List(Element(msg)) {
  render(from_config(config), attributes)
}

// --- PRIVATE INTERNAL HELPERS ---

fn icons_to_string(i: Icons) -> String {
  case i {
    Both -> "both"
    Neither -> "none"
    Selected -> "selected"
  }
}

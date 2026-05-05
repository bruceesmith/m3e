//// Checkbox is a checkbox that allows a user to select one or more options from a limited number of choices.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr

// --- Types ---

/// Checkbox is a View Model for this component
///
/// ## Fields:
///
/// - checked: Whether the element is checked.
/// - disabled: Whether the element is disabled.
/// - indeterminate: Whether the element's checked state is indeterminate.
/// - name: The name that identifies the element when submitting the associated form.
/// - required: Whether the element is required.
/// - value: A string representing the value of the checkbox.
///
pub opaque type Checkbox {
  Checkbox(
    checked: Checked,
    disabled: Disabled,
    indeterminate: Indeterminate,
    name: String,
    required: Required,
    value: String,
  )
}

/// Checked is whether the element is checked.
///
pub type Checked {
  IsChecked
  IsNotChecked
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// Indeterminate is whether the element's checked state is indeterminate.
///
pub type Indeterminate {
  IsIndeterminate
  IsNotIndeterminate
}

/// Required is whether the element is required.
///
pub type Required {
  IsRequired
  IsNotRequired
}

// --- Defaults ---

pub const default_checked: Checked = IsNotChecked

pub const default_disabled: Disabled = IsNotDisabled

pub const default_indeterminate: Indeterminate = IsNotIndeterminate

pub const default_name: String = ""

pub const default_required: Required = IsNotRequired

pub const default_value: String = "on"

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    checked: Checked,
    disabled: Disabled,
    indeterminate: Indeterminate,
    name: String,
    required: Required,
    value: String,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    checked: IsNotChecked,
    disabled: IsNotDisabled,
    indeterminate: IsNotIndeterminate,
    name: "",
    required: IsNotRequired,
    value: "on",
  )
}

// --- Constructors ---

/// from_config creates a new Checkbox from the given configuration.
///
pub fn from_config(config: Config) -> Checkbox {
  Checkbox(
    checked: config.checked,
    disabled: config.disabled,
    indeterminate: config.indeterminate,
    name: config.name,
    required: config.required,
    value: config.value,
  )
}

/// new creates a new Checkbox with the default configuration.
///
pub fn new() -> Checkbox {
  from_config(default_config())
}

// --- Setters ---

/// checked sets the value of checked for this Checkbox.
///
pub fn checked(record: Checkbox, checked: Checked) -> Checkbox {
  Checkbox(..record, checked: checked)
}

/// disabled sets the value of disabled for this Checkbox.
///
pub fn disabled(record: Checkbox, disabled: Disabled) -> Checkbox {
  Checkbox(..record, disabled: disabled)
}

/// indeterminate sets the value of indeterminate for this Checkbox.
///
pub fn indeterminate(record: Checkbox, indeterminate: Indeterminate) -> Checkbox {
  Checkbox(..record, indeterminate: indeterminate)
}

/// name sets the value of name for this Checkbox.
///
pub fn name(record: Checkbox, name: String) -> Checkbox {
  Checkbox(..record, name: name)
}

/// required sets the value of required for this Checkbox.
///
pub fn required(record: Checkbox, required: Required) -> Checkbox {
  Checkbox(..record, required: required)
}

/// value sets the value of value for this Checkbox.
///
pub fn value(record: Checkbox, value: String) -> Checkbox {
  Checkbox(..record, value: value)
}

// --- Renderers ---

/// render creates a Lustre Element for a Checkbox
///
pub fn render(
  model: Checkbox,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-checkbox",
    list.flatten([
      [
        attr.boolean("checked", model.checked == IsChecked),
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.boolean("indeterminate", model.indeterminate == IsIndeterminate),
        attr.with_default("name", model.name, default_name),
        attr.boolean("required", model.required == IsRequired),
        attr.with_default("value", model.value, default_value),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Checkbox Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

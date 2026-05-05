//// PseudoCheckbox is an element which looks like a checkbox.
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

/// PseudoCheckbox is a View Model for this component
///
/// ## Fields:
///
/// - checked: A value indicating whether the element is checked.
/// - disabled: A value indicating whether the element is disabled.
/// - indeterminate: A value indicating whether the element's checked state is indeterminate.
///
pub opaque type PseudoCheckbox {
  PseudoCheckbox(
    checked: Checked,
    disabled: Disabled,
    indeterminate: Indeterminate,
  )
}

/// Checked is a value indicating whether the element is checked.
///
pub type Checked {
  IsChecked
  IsNotChecked
}

/// Disabled is a value indicating whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// Indeterminate is a value indicating whether the element's checked state is indeterminate.
///
pub type Indeterminate {
  IsIndeterminate
  IsNotIndeterminate
}

// --- Defaults ---

pub const default_checked: Checked = IsNotChecked

pub const default_disabled: Disabled = IsNotDisabled

pub const default_indeterminate: Indeterminate = IsNotIndeterminate

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(checked: Checked, disabled: Disabled, indeterminate: Indeterminate)
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    checked: IsNotChecked,
    disabled: IsNotDisabled,
    indeterminate: IsNotIndeterminate,
  )
}

// --- Constructors ---

/// from_config creates a new PseudoCheckbox from the given configuration.
///
pub fn from_config(config: Config) -> PseudoCheckbox {
  PseudoCheckbox(
    checked: config.checked,
    disabled: config.disabled,
    indeterminate: config.indeterminate,
  )
}

/// new creates a new PseudoCheckbox with the default configuration.
///
pub fn new() -> PseudoCheckbox {
  from_config(default_config())
}

// --- Setters ---

/// checked sets the value of checked for this PseudoCheckbox.
///
pub fn checked(record: PseudoCheckbox, checked: Checked) -> PseudoCheckbox {
  PseudoCheckbox(..record, checked: checked)
}

/// disabled sets the value of disabled for this PseudoCheckbox.
///
pub fn disabled(record: PseudoCheckbox, disabled: Disabled) -> PseudoCheckbox {
  PseudoCheckbox(..record, disabled: disabled)
}

/// indeterminate sets the value of indeterminate for this PseudoCheckbox.
///
pub fn indeterminate(
  record: PseudoCheckbox,
  indeterminate: Indeterminate,
) -> PseudoCheckbox {
  PseudoCheckbox(..record, indeterminate: indeterminate)
}

// --- Renderers ---

/// render creates a Lustre Element for a PseudoCheckbox
///
pub fn render(
  model: PseudoCheckbox,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-pseudo-checkbox",
    list.flatten([
      [
        attr.boolean("checked", model.checked == IsChecked),
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.boolean("indeterminate", model.indeterminate == IsIndeterminate),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a PseudoCheckbox Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

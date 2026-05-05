//// RadioGroup is a container for a set of radio buttons.
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

/// RadioGroup is a View Model for this component
///
/// ## Fields:
///
/// - aria_invalid: 
/// - disabled: Whether the element is disabled.
/// - name: The name that identifies the element when submitting the associated form.
/// - required: Whether the element is required.
///
pub opaque type RadioGroup {
  RadioGroup(
    aria_invalid: String,
    disabled: Disabled,
    name: String,
    required: Required,
  )
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// Required is whether the element is required.
///
pub type Required {
  IsRequired
  IsNotRequired
}

// --- Defaults ---

pub const default_aria_invalid: String = ""

pub const default_disabled: Disabled = IsNotDisabled

pub const default_name: String = ""

pub const default_required: Required = IsNotRequired

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    aria_invalid: String,
    disabled: Disabled,
    name: String,
    required: Required,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    aria_invalid: "",
    disabled: IsNotDisabled,
    name: "",
    required: IsNotRequired,
  )
}

// --- Constructors ---

/// from_config creates a new RadioGroup from the given configuration.
///
pub fn from_config(config: Config) -> RadioGroup {
  RadioGroup(
    aria_invalid: config.aria_invalid,
    disabled: config.disabled,
    name: config.name,
    required: config.required,
  )
}

/// new creates a new RadioGroup with the default configuration.
///
pub fn new() -> RadioGroup {
  from_config(default_config())
}

// --- Setters ---

/// aria_invalid sets the value of aria_invalid for this RadioGroup.
///
pub fn aria_invalid(record: RadioGroup, aria_invalid: String) -> RadioGroup {
  RadioGroup(..record, aria_invalid: aria_invalid)
}

/// disabled sets the value of disabled for this RadioGroup.
///
pub fn disabled(record: RadioGroup, disabled: Disabled) -> RadioGroup {
  RadioGroup(..record, disabled: disabled)
}

/// name sets the value of name for this RadioGroup.
///
pub fn name(record: RadioGroup, name: String) -> RadioGroup {
  RadioGroup(..record, name: name)
}

/// required sets the value of required for this RadioGroup.
///
pub fn required(record: RadioGroup, required: Required) -> RadioGroup {
  RadioGroup(..record, required: required)
}

// --- Renderers ---

/// render creates a Lustre Element for a RadioGroup
///
pub fn render(
  model: RadioGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-radio-group",
    list.flatten([
      [
        attr.with_default(
          "aria-invalid",
          model.aria_invalid,
          default_aria_invalid,
        ),
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.with_default("name", model.name, default_name),
        attr.boolean("required", model.required == IsRequired),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a RadioGroup Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

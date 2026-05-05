//// AssistChip is a chip users interact with to perform a smart or automated action that can span multiple applications.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/chip_variant.{type ChipVariant}
import m3e/form_submitter_type.{type FormSubmitterType}
import m3e/link_target.{type LinkTarget}

// --- Types ---

/// AssistChip is a View Model for this component
///
/// ## Fields:
///
/// - disabled: A value indicating whether the element is disabled.
/// - disabled_interactive: A value indicating whether the element is disabled and interactive.
/// - download: A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file.
/// - href: The URL to which the link button points.
/// - name: The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
/// - rel: The relationship between the `target` of the link button and the document.
/// - target: The target of the link button.
/// - type_: The type of the element.
/// - value: A string representing the value of the chip.
/// - variant: The appearance variant of the chip.
///
pub opaque type AssistChip {
  AssistChip(
    disabled: Disabled,
    disabled_interactive: DisabledInteractive,
    download: Option(String),
    href: String,
    name: String,
    rel: String,
    target: Option(LinkTarget),
    type_: FormSubmitterType,
    value: String,
    variant: ChipVariant,
  )
}

/// Disabled is a value indicating whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// DisabledInteractive is a value indicating whether the element is disabled and interactive.
///
pub type DisabledInteractive {
  IsDisabledInteractive
  IsNotDisabledInteractive
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_disabled_interactive: DisabledInteractive = IsNotDisabledInteractive

pub const default_download: Option(String) = None

pub const default_href: String = ""

pub const default_name: String = ""

pub const default_rel: String = ""

pub const default_target: Option(LinkTarget) = None

pub const default_type_: FormSubmitterType = form_submitter_type.Button

pub const default_value: String = ""

pub const default_variant: ChipVariant = chip_variant.Outlined

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Icon
  // Renders an icon before the chip's label.
  TrailingIcon
  // Renders an icon after the chip's label.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    disabled_interactive: DisabledInteractive,
    download: Option(String),
    href: String,
    name: String,
    rel: String,
    target: Option(LinkTarget),
    type_: FormSubmitterType,
    value: String,
    variant: ChipVariant,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disabled: IsNotDisabled,
    disabled_interactive: IsNotDisabledInteractive,
    download: None,
    href: "",
    name: "",
    rel: "",
    target: None,
    type_: form_submitter_type.Button,
    value: "",
    variant: chip_variant.Outlined,
  )
}

// --- Constructors ---

/// from_config creates a new AssistChip from the given configuration.
///
pub fn from_config(config: Config) -> AssistChip {
  AssistChip(
    disabled: config.disabled,
    disabled_interactive: config.disabled_interactive,
    download: config.download,
    href: config.href,
    name: config.name,
    rel: config.rel,
    target: config.target,
    type_: config.type_,
    value: config.value,
    variant: config.variant,
  )
}

/// new creates a new AssistChip with the default configuration.
///
pub fn new() -> AssistChip {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this AssistChip.
///
pub fn disabled(record: AssistChip, disabled: Disabled) -> AssistChip {
  AssistChip(..record, disabled: disabled)
}

/// disabled_interactive sets the value of disabled_interactive for this AssistChip.
///
pub fn disabled_interactive(
  record: AssistChip,
  disabled_interactive: DisabledInteractive,
) -> AssistChip {
  AssistChip(..record, disabled_interactive: disabled_interactive)
}

/// download sets the value of download for this AssistChip.
///
pub fn download(record: AssistChip, download: Option(String)) -> AssistChip {
  AssistChip(..record, download: download)
}

/// href sets the value of href for this AssistChip.
///
pub fn href(record: AssistChip, href: String) -> AssistChip {
  AssistChip(..record, href: href)
}

/// name sets the value of name for this AssistChip.
///
pub fn name(record: AssistChip, name: String) -> AssistChip {
  AssistChip(..record, name: name)
}

/// rel sets the value of rel for this AssistChip.
///
pub fn rel(record: AssistChip, rel: String) -> AssistChip {
  AssistChip(..record, rel: rel)
}

/// target sets the value of target for this AssistChip.
///
pub fn target(record: AssistChip, target: Option(LinkTarget)) -> AssistChip {
  AssistChip(..record, target: target)
}

/// type_ sets the value of type_ for this AssistChip.
///
pub fn type_(record: AssistChip, type_: FormSubmitterType) -> AssistChip {
  AssistChip(..record, type_: type_)
}

/// value sets the value of value for this AssistChip.
///
pub fn value(record: AssistChip, value: String) -> AssistChip {
  AssistChip(..record, value: value)
}

/// variant sets the value of variant for this AssistChip.
///
pub fn variant(record: AssistChip, variant: ChipVariant) -> AssistChip {
  AssistChip(..record, variant: variant)
}

// --- Renderers ---

/// render creates a Lustre Element for a AssistChip
///
pub fn render(
  model: AssistChip,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-assist-chip",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.boolean(
          "disabled-interactive",
          model.disabled_interactive == IsDisabledInteractive,
        ),
        attr.option(
          model.download,
          fn(_) { "download" },
          function.identity,
          default_download,
        ),
        attr.with_default("href", model.href, default_href),
        attr.with_default("name", model.name, default_name),
        attr.with_default("rel", model.rel, default_rel),
        attr.option(
          model.target,
          fn(_) { "target" },
          link_target.to_string,
          default_target,
        ),
        attr.with_default(
          "type",
          form_submitter_type.to_string(model.type_),
          form_submitter_type.to_string(default_type_),
        ),
        attr.with_default("value", model.value, default_value),
        attr.with_default(
          "variant",
          chip_variant.to_string(model.variant),
          chip_variant.to_string(default_variant),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a AssistChip Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Icon -> attribute.attribute("slot", "icon")
    TrailingIcon -> attribute.attribute("slot", "trailing-icon")
  }
}

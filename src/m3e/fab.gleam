//// Fab is a floating action button (FAB) used to present important actions.
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
import m3e/fab_size.{type FabSize}
import m3e/fab_variant.{type FabVariant}
import m3e/form_submitter_type.{type FormSubmitterType}
import m3e/link_target.{type LinkTarget}

// --- Types ---

/// Fab is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether the element is disabled.
/// - disabled_interactive: Whether the element is disabled and interactive.
/// - download: A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file.
/// - extended: Whether the button is extended to show the label.
/// - href: The URL to which the link button points.
/// - lowered: Whether to present a lowered elevation.
/// - name: The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
/// - rel: The relationship between the `target` of the link button and the document.
/// - size: The size of the button.
/// - target: The target of the link button.
/// - type_: The type of the element.
/// - value: The value associated with the element's name when it's submitted with form data.
/// - variant: The appearance variant of the button.
///
pub opaque type Fab {
  Fab(
    disabled: Disabled,
    disabled_interactive: DisabledInteractive,
    download: Option(String),
    extended: Extended,
    href: String,
    lowered: Lowered,
    name: String,
    rel: String,
    size: FabSize,
    target: Option(LinkTarget),
    type_: FormSubmitterType,
    value: String,
    variant: FabVariant,
  )
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// DisabledInteractive is whether the element is disabled and interactive.
///
pub type DisabledInteractive {
  IsDisabledInteractive
  IsNotDisabledInteractive
}

/// Extended is whether the button is extended to show the label.
///
pub type Extended {
  IsExtended
  IsNotExtended
}

/// Lowered is whether to present a lowered elevation.
///
pub type Lowered {
  IsLowered
  IsNotLowered
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_disabled_interactive: DisabledInteractive = IsNotDisabledInteractive

pub const default_download: Option(String) = None

pub const default_extended: Extended = IsNotExtended

pub const default_href: String = ""

pub const default_lowered: Lowered = IsNotLowered

pub const default_name: String = ""

pub const default_rel: String = ""

pub const default_size: FabSize = fab_size.Medium

pub const default_target: Option(LinkTarget) = None

pub const default_type_: FormSubmitterType = form_submitter_type.Button

pub const default_value: String = ""

pub const default_variant: FabVariant = fab_variant.PrimaryContainer

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Label
  // Renders the label of an extended button.
  CloseIcon
  // Renders the close icon when used to open a FAB menu.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    disabled_interactive: DisabledInteractive,
    download: Option(String),
    extended: Extended,
    href: String,
    lowered: Lowered,
    name: String,
    rel: String,
    size: FabSize,
    target: Option(LinkTarget),
    type_: FormSubmitterType,
    value: String,
    variant: FabVariant,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disabled: IsNotDisabled,
    disabled_interactive: IsNotDisabledInteractive,
    download: None,
    extended: IsNotExtended,
    href: "",
    lowered: IsNotLowered,
    name: "",
    rel: "",
    size: fab_size.Medium,
    target: None,
    type_: form_submitter_type.Button,
    value: "",
    variant: fab_variant.PrimaryContainer,
  )
}

// --- Constructors ---

/// from_config creates a new Fab from the given configuration.
///
pub fn from_config(config: Config) -> Fab {
  Fab(
    disabled: config.disabled,
    disabled_interactive: config.disabled_interactive,
    download: config.download,
    extended: config.extended,
    href: config.href,
    lowered: config.lowered,
    name: config.name,
    rel: config.rel,
    size: config.size,
    target: config.target,
    type_: config.type_,
    value: config.value,
    variant: config.variant,
  )
}

/// new creates a new Fab with the default configuration.
///
pub fn new() -> Fab {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this Fab.
///
pub fn disabled(record: Fab, disabled: Disabled) -> Fab {
  Fab(..record, disabled: disabled)
}

/// disabled_interactive sets the value of disabled_interactive for this Fab.
///
pub fn disabled_interactive(
  record: Fab,
  disabled_interactive: DisabledInteractive,
) -> Fab {
  Fab(..record, disabled_interactive: disabled_interactive)
}

/// download sets the value of download for this Fab.
///
pub fn download(record: Fab, download: Option(String)) -> Fab {
  Fab(..record, download: download)
}

/// extended sets the value of extended for this Fab.
///
pub fn extended(record: Fab, extended: Extended) -> Fab {
  Fab(..record, extended: extended)
}

/// href sets the value of href for this Fab.
///
pub fn href(record: Fab, href: String) -> Fab {
  Fab(..record, href: href)
}

/// lowered sets the value of lowered for this Fab.
///
pub fn lowered(record: Fab, lowered: Lowered) -> Fab {
  Fab(..record, lowered: lowered)
}

/// name sets the value of name for this Fab.
///
pub fn name(record: Fab, name: String) -> Fab {
  Fab(..record, name: name)
}

/// rel sets the value of rel for this Fab.
///
pub fn rel(record: Fab, rel: String) -> Fab {
  Fab(..record, rel: rel)
}

/// size sets the value of size for this Fab.
///
pub fn size(record: Fab, size: FabSize) -> Fab {
  Fab(..record, size: size)
}

/// target sets the value of target for this Fab.
///
pub fn target(record: Fab, target: Option(LinkTarget)) -> Fab {
  Fab(..record, target: target)
}

/// type_ sets the value of type_ for this Fab.
///
pub fn type_(record: Fab, type_: FormSubmitterType) -> Fab {
  Fab(..record, type_: type_)
}

/// value sets the value of value for this Fab.
///
pub fn value(record: Fab, value: String) -> Fab {
  Fab(..record, value: value)
}

/// variant sets the value of variant for this Fab.
///
pub fn variant(record: Fab, variant: FabVariant) -> Fab {
  Fab(..record, variant: variant)
}

// --- Renderers ---

/// render creates a Lustre Element for a Fab
///
pub fn render(
  model: Fab,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-fab",
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
        attr.boolean("extended", model.extended == IsExtended),
        attr.with_default("href", model.href, default_href),
        attr.boolean("lowered", model.lowered == IsLowered),
        attr.with_default("name", model.name, default_name),
        attr.with_default("rel", model.rel, default_rel),
        attr.with_default(
          "size",
          fab_size.to_string(model.size),
          fab_size.to_string(default_size),
        ),
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
          fab_variant.to_string(model.variant),
          fab_variant.to_string(default_variant),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Fab Config
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
    Label -> attribute.attribute("slot", "label")
    CloseIcon -> attribute.attribute("slot", "close-icon")
  }
}

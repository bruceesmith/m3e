//// ButtonGroup is organizes buttons and adds interactions between them.
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
import m3e/button_group_size.{type ButtonGroupSize}
import m3e/button_group_variant.{type ButtonGroupVariant}

// --- Types ---

/// ButtonGroup is a View Model for this component
///
/// ## Fields:
///
/// - multi: Whether multiple toggle buttons can be selected.
/// - size: The size of the group.
/// - variant: The appearance variant of the group.
///
pub opaque type ButtonGroup {
  ButtonGroup(multi: Multi, size: ButtonGroupSize, variant: ButtonGroupVariant)
}

/// Multi is whether multiple toggle buttons can be selected.
///
pub type Multi {
  IsMulti
  IsNotMulti
}

// --- Defaults ---

pub const default_multi: Multi = IsNotMulti

pub const default_size: ButtonGroupSize = button_group_size.Small

pub const default_variant: ButtonGroupVariant = button_group_variant.Standard

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(multi: Multi, size: ButtonGroupSize, variant: ButtonGroupVariant)
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    multi: IsNotMulti,
    size: button_group_size.Small,
    variant: button_group_variant.Standard,
  )
}

// --- Constructors ---

/// from_config creates a new ButtonGroup from the given configuration.
///
pub fn from_config(config: Config) -> ButtonGroup {
  ButtonGroup(multi: config.multi, size: config.size, variant: config.variant)
}

/// new creates a new ButtonGroup with the default configuration.
///
pub fn new() -> ButtonGroup {
  from_config(default_config())
}

// --- Setters ---

/// multi sets the value of multi for this ButtonGroup.
///
pub fn multi(record: ButtonGroup, multi: Multi) -> ButtonGroup {
  ButtonGroup(..record, multi: multi)
}

/// size sets the value of size for this ButtonGroup.
///
pub fn size(record: ButtonGroup, size: ButtonGroupSize) -> ButtonGroup {
  ButtonGroup(..record, size: size)
}

/// variant sets the value of variant for this ButtonGroup.
///
pub fn variant(record: ButtonGroup, variant: ButtonGroupVariant) -> ButtonGroup {
  ButtonGroup(..record, variant: variant)
}

// --- Renderers ---

/// render creates a Lustre Element for a ButtonGroup
///
pub fn render(
  model: ButtonGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-button-group",
    list.flatten([
      [
        attr.boolean("multi", model.multi == IsMulti),
        attr.with_default(
          "size",
          button_group_size.to_string(model.size),
          button_group_size.to_string(default_size),
        ),
        attr.with_default(
          "variant",
          button_group_variant.to_string(model.variant),
          button_group_variant.to_string(default_variant),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a ButtonGroup Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

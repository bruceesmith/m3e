//// Chip is a non-interactive chip used to convey small pieces of information.
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
import m3e/chip_variant.{type ChipVariant}

// --- Types ---

/// Chip is a View Model for this component
///
/// ## Fields:
///
/// - value: A string representing the value of the chip.
/// - variant: The appearance variant of the chip.
///
pub opaque type Chip {
  Chip(value: String, variant: ChipVariant)
}

// --- Defaults ---

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
  Config(value: String, variant: ChipVariant)
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(value: "", variant: chip_variant.Outlined)
}

// --- Constructors ---

/// from_config creates a new Chip from the given configuration.
///
pub fn from_config(config: Config) -> Chip {
  Chip(value: config.value, variant: config.variant)
}

/// new creates a new Chip with the default configuration.
///
pub fn new() -> Chip {
  from_config(default_config())
}

// --- Setters ---

/// value sets the value of value for this Chip.
///
pub fn value(record: Chip, value: String) -> Chip {
  Chip(..record, value: value)
}

/// variant sets the value of variant for this Chip.
///
pub fn variant(record: Chip, variant: ChipVariant) -> Chip {
  Chip(..record, variant: variant)
}

// --- Renderers ---

/// render creates a Lustre Element for a Chip
///
pub fn render(
  model: Chip,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-chip",
    list.flatten([
      [
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

/// render_config creates a Lustre Element from a Chip Config
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

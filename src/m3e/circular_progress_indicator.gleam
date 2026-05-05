//// CircularProgressIndicator is a circular indicator of progress and activity.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/float
import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/progress_indicator_variant.{type ProgressIndicatorVariant}

// --- Types ---

/// CircularProgressIndicator is a View Model for this component
///
/// ## Fields:
///
/// - indeterminate: Whether to show something is happening without conveying progress.
/// - max: The maximum progress value.
/// - value: A fractional value, between 0 and `max`, indicating progress.
/// - variant: The appearance of the indicator.
///
pub opaque type CircularProgressIndicator {
  CircularProgressIndicator(
    indeterminate: Indeterminate,
    max: Float,
    value: Float,
    variant: ProgressIndicatorVariant,
  )
}

/// Indeterminate is whether to show something is happening without conveying progress.
///
pub type Indeterminate {
  IsIndeterminate
  IsNotIndeterminate
}

// --- Defaults ---

pub const default_indeterminate: Indeterminate = IsNotIndeterminate

pub const default_max: Float = 100.0

pub const default_value: Float = 0.0

pub const default_variant: ProgressIndicatorVariant = progress_indicator_variant.Flat

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    indeterminate: Indeterminate,
    max: Float,
    value: Float,
    variant: ProgressIndicatorVariant,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    indeterminate: IsNotIndeterminate,
    max: 100.0,
    value: 0.0,
    variant: progress_indicator_variant.Flat,
  )
}

// --- Constructors ---

/// from_config creates a new CircularProgressIndicator from the given configuration.
///
pub fn from_config(config: Config) -> CircularProgressIndicator {
  CircularProgressIndicator(
    indeterminate: config.indeterminate,
    max: config.max,
    value: config.value,
    variant: config.variant,
  )
}

/// new creates a new CircularProgressIndicator with the default configuration.
///
pub fn new() -> CircularProgressIndicator {
  from_config(default_config())
}

// --- Setters ---

/// indeterminate sets the value of indeterminate for this CircularProgressIndicator.
///
pub fn indeterminate(
  record: CircularProgressIndicator,
  indeterminate: Indeterminate,
) -> CircularProgressIndicator {
  CircularProgressIndicator(..record, indeterminate: indeterminate)
}

/// max sets the value of max for this CircularProgressIndicator.
///
pub fn max(
  record: CircularProgressIndicator,
  max: Float,
) -> CircularProgressIndicator {
  CircularProgressIndicator(..record, max: max)
}

/// value sets the value of value for this CircularProgressIndicator.
///
pub fn value(
  record: CircularProgressIndicator,
  value: Float,
) -> CircularProgressIndicator {
  CircularProgressIndicator(..record, value: value)
}

/// variant sets the value of variant for this CircularProgressIndicator.
///
pub fn variant(
  record: CircularProgressIndicator,
  variant: ProgressIndicatorVariant,
) -> CircularProgressIndicator {
  CircularProgressIndicator(..record, variant: variant)
}

// --- Renderers ---

/// render creates a Lustre Element for a CircularProgressIndicator
///
pub fn render(
  model: CircularProgressIndicator,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-circular-progress-indicator",
    list.flatten([
      [
        attr.boolean("indeterminate", model.indeterminate == IsIndeterminate),
        attr.with_default(
          "max",
          float.to_string(model.max),
          float.to_string(default_max),
        ),
        attr.with_default(
          "value",
          float.to_string(model.value),
          float.to_string(default_value),
        ),
        attr.with_default(
          "variant",
          progress_indicator_variant.to_string(model.variant),
          progress_indicator_variant.to_string(default_variant),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a CircularProgressIndicator Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

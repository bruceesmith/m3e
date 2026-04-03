//// circular_progress_indicator provides Lustre support for the [M3E Circular Progress Indicator component](https://matraic.github.io/m3e/#/components/progress-indicator.html)

import gleam/float
import gleam/int
import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/progress_indicator.{type Variant}

// --- Types ---

/// CircularProgressIndicator provides accessible, animated progress indicators for tracking
/// the completion of tasks or processes
/// 
/// ## Fields:
/// - indeterminate: Whether to show something is happening without conveying progress.
/// - max: The maximum progress value.
/// - value: A fractional value, between 0 and `max`, indicating progress.
/// - variant: The appearance of the indicator.
pub opaque type CircularProgressIndicator {
  CircularProgressIndicator(
    indeterminate: Mode,
    max: Int,
    value: Float,
    variant: Variant,
  )
}

/// Mode of an indicator
///
pub type Mode {
  Determinate
  Indeterminate
}

pub const default_mode = Determinate

// --- CONFIGURATION ---

///  Config holds the configuration of a CircularProgressIndicator
/// 
pub type Config {
  Config(indeterminate: Mode, max: Int, value: Float, variant: Variant)
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(
    indeterminate: default_mode,
    max: 1,
    value: 0.0,
    variant: progress_indicator.default_variant,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a CircularProgressIndicator from a Config record
///
pub fn from_config(c: Config) -> CircularProgressIndicator {
  CircularProgressIndicator(
    indeterminate: c.indeterminate,
    max: c.max,
    value: c.value,
    variant: c.variant,
  )
}

/// new creates a new CircularProgressIndicator
///
pub fn new() -> CircularProgressIndicator {
  from_config(default_config())
}

// --- SETTERS ---

/// indeterminate sets the `indeterminate` field
///
pub fn indeterminate(
  cpi: CircularProgressIndicator,
  indeterminate: Mode,
) -> CircularProgressIndicator {
  CircularProgressIndicator(..cpi, indeterminate: indeterminate)
}

/// max sets the `max` field
///
pub fn max(
  cpi: CircularProgressIndicator,
  max: Int,
) -> CircularProgressIndicator {
  CircularProgressIndicator(..cpi, max: max)
}

/// value sets the `value` field
///
pub fn value(
  cpi: CircularProgressIndicator,
  value: Float,
) -> CircularProgressIndicator {
  CircularProgressIndicator(..cpi, value: value)
}

/// variant sets the `variant` field
///
pub fn variant(
  cpi: CircularProgressIndicator,
  variant: Variant,
) -> CircularProgressIndicator {
  CircularProgressIndicator(..cpi, variant: variant)
}

// --- RENDERING ---  

/// render creates a Lustre Element from a CircularProgressIndicator
///
/// ## Parameters:
/// - cpi: a CircularProgressIndicator
/// - attributes: a list of additional Attributes
///
pub fn render(
  cpi: CircularProgressIndicator,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  element.element(
    "m3e-circular-progress-indicator",
    list.append(
      [
        helpers.boolean_attribute(
          "indeterminate",
          cpi.indeterminate == Indeterminate,
        ),
        attribute.attribute("max", int.to_string(cpi.max)),
        attribute.attribute("value", float.to_string(cpi.value)),
        attribute.attribute(
          "variant",
          progress_indicator.variant_to_string(cpi.variant),
        ),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != attribute.none() }),
    [],
  )
}
// --- PRIVATE INTERNAL HELPERS ---

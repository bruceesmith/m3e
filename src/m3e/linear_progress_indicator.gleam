//// linear_progress_indicator provides Lustre support for the [M3E Linear Progress Indicator component](https://matraic.github.io/m3e/#/components/progress-indicator.html)

import gleam/float
import gleam/int
import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/progress_indicator.{type Variant}

// --- Types ---

/// LinearProgressIndicator provides accessible, animated progress indicators for tracking
/// the completion of tasks or processes
/// 
/// ## Fields:
/// - buffer_value: A fractional value, between 0 and `max`, indicating buffer progress.
/// - max: The maximum progress value.
/// - mode: The mode of the progress bar.
/// - value: A fractional value, between 0 and `max`, indicating progress.
/// - variant: The appearance of the indicator.
pub opaque type LinearProgressIndicator {
  LinearProgressIndicator(
    buffer_value: Float,
    max: Int,
    mode: Mode,
    value: Float,
    variant: Variant,
  )
}

/// Mode is the mode of the progress bar
/// Mode = "determinate" | "indeterminate" | "buffer" | "query"
/// 
pub type Mode {
  Buffer
  Determinate
  Indeterminate
  Query
}

pub const default_mode = Determinate

// --- CONFIGURATION ---

///  Config holds the configuration of a LinearProgressIndicator
/// 
pub type Config {
  Config(
    buffer_value: Float,
    max: Int,
    mode: Mode,
    value: Float,
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(
    buffer_value: 0.0,
    max: 1,
    mode: default_mode,
    value: 0.0,
    variant: progress_indicator.default_variant,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a LinearProgressIndicator from a Config record
///
pub fn from_config(c: Config) -> LinearProgressIndicator {
  LinearProgressIndicator(
    buffer_value: c.buffer_value,
    max: c.max,
    mode: c.mode,
    value: c.value,
    variant: c.variant,
  )
}

/// new creates a new LinearProgressIndicator
///
pub fn new() -> LinearProgressIndicator {
  from_config(default_config())
}

// --- SETTERS ---  

/// buffer_value sets the `buffer_value` field
///
pub fn buffer_value(
  lpi: LinearProgressIndicator,
  buffer_value: Float,
) -> LinearProgressIndicator {
  LinearProgressIndicator(..lpi, buffer_value: buffer_value)
}

/// max sets the `max` field
///
pub fn max(lpi: LinearProgressIndicator, max: Int) -> LinearProgressIndicator {
  LinearProgressIndicator(..lpi, max: max)
}

/// mode sets the `mode` field
///
pub fn mode(lpi: LinearProgressIndicator, mode: Mode) -> LinearProgressIndicator {
  LinearProgressIndicator(..lpi, mode: mode)
}

/// value sets the `value` field
///
pub fn value(
  lpi: LinearProgressIndicator,
  value: Float,
) -> LinearProgressIndicator {
  LinearProgressIndicator(..lpi, value: value)
}

/// variant sets the `variant` field
///
pub fn variant(
  lpi: LinearProgressIndicator,
  variant: Variant,
) -> LinearProgressIndicator {
  LinearProgressIndicator(..lpi, variant: variant)
}

// --- RENDERING ---    

/// render creates a Lustre Element from a LinearProgressIndicator
///
/// ## Parameters:
/// - lpi: a LinearProgressIndicator
/// - attributes: a list of additional Attributes
///
pub fn render(
  lpi: LinearProgressIndicator,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  element.element(
    "m3e-linear-progress-indicator",
    list.append(
      [
        attribute.attribute("buffer-value", float.to_string(lpi.buffer_value)),
        attribute.attribute("max", int.to_string(lpi.max)),
        helpers.boolean_attribute("indeterminate", lpi.mode == Indeterminate),
        attribute.attribute("value", float.to_string(lpi.value)),
        attribute.attribute(
          "variant",
          progress_indicator.variant_to_string(lpi.variant),
        ),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != attribute.none() }),
    [],
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  render(from_config(config), attributes)
}
// --- PRIVATE INTERNAL HELPERS ---

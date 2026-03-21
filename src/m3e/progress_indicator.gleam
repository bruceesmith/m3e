//// progress_indicator provides Lustre support for the [M3E Progress Indicator component](https://matraic.github.io/m3e/#/components/progress-indicator.html)

import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import lustre/element/html.{text}

// --- Types ---

/// Diameter is an alias to Int for clarity
///
pub type Diameter =
  Int

pub const default_diameter = 40

/// Maximum is an alias to Int for clarity
///
pub type Maximum =
  Int

pub const default_max = 1

/// Mode of an indicator
///
pub type Mode {
  Buffer
  Determinate
  Indeterminate
  Query
}

pub const default_mode = Determinate

/// StrokeWidth is an alias to Int for clarity
///
pub type StrokeWidth =
  Int

pub const default_stroke_width = 10

/// Value is an alias to Int for clarity
///
pub type Value =
  Int

/// Variant of indicator
///
pub type Variant {
  Circular
  Linear
}

pub const default_variant = Linear

/// ProgressIndicator holds all the values necessary to construct an M3E Progress Indicator
///
/// ## Fields:
/// - buffer_value: A fractional value, between 0 and max, indicating buffer progress
/// - content: Optional content displayed inside the circle when determinate
/// - diameter: The diameter, in pixels, of the progress spinner
/// - max: The maximum progress value
/// - mode: The mode of the progress bar
/// - stroke_width: The stroke width, in pixels, of the progress spinner
/// - value: A fractional value, between 0 and max, indicating progress
///
pub opaque type ProgressIndicator {
  ProgressIndicator(
    buffer_value: Value,
    content: Option(String),
    diameter: Diameter,
    max: Maximum,
    mode: Mode,
    stroke_width: StrokeWidth,
    value: Value,
    variant: Variant,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a ProgressIndicator
/// 
pub type Config {
  Config(
    buffer_value: Value,
    content: Option(String),
    diameter: Diameter,
    max: Maximum,
    mode: Mode,
    stroke_width: StrokeWidth,
    value: Value,
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    buffer_value: 0,
    content: None,
    diameter: default_diameter,
    max: default_max,
    mode: default_mode,
    stroke_width: default_stroke_width,
    value: 0,
    variant: default_variant,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a ProgressIndicator from a Config record
/// 
pub fn from_config(c: Config) -> ProgressIndicator {
  ProgressIndicator(
    buffer_value: c.buffer_value,
    content: c.content,
    diameter: c.diameter,
    max: c.max,
    mode: c.mode,
    stroke_width: c.stroke_width,
    value: c.value,
    variant: c.variant,
  )
}

/// circular builds a Circular ProgressIndicator
///
pub fn circular() -> ProgressIndicator {
  from_config(Config(..default_config(), variant: Circular))
}

/// linear builds a Linear ProgressIndicator
///
pub fn linear() -> ProgressIndicator {
  from_config(default_config())
}

// --- SETTERS ---

/// buffer_value sets the `buffer_value` field
///
pub fn buffer_value(pi: ProgressIndicator, value: Value) -> ProgressIndicator {
  case pi.variant {
    Linear ->
      ProgressIndicator(
        ..pi,
        buffer_value: buffer_value_validate(pi.max, value),
      )
    _ -> pi
  }
}

/// content sets the `content` field
///
pub fn content(
  pi: ProgressIndicator,
  content: Option(String),
) -> ProgressIndicator {
  case pi.variant {
    Circular -> ProgressIndicator(..pi, content: content)
    Linear -> pi
  }
}

/// diameter sets the `diameter` field
///
pub fn diameter(pi: ProgressIndicator, diameter: Diameter) -> ProgressIndicator {
  case pi.variant {
    Circular -> ProgressIndicator(..pi, diameter: diameter_validate(diameter))
    _ -> pi
  }
}

/// indeterminate sets the `mode` field for Circular (semantic enum support)
///
pub fn indeterminate(pi: ProgressIndicator, mode: Mode) -> ProgressIndicator {
  case pi.variant {
    Circular -> ProgressIndicator(..pi, mode: mode)
    Linear -> pi
  }
}

/// max sets the `max` field
///
pub fn max(pi: ProgressIndicator, new_max: Maximum) -> ProgressIndicator {
  let validated_max = max_validate(new_max)
  case pi.variant {
    Circular ->
      case pi.mode {
        Indeterminate -> pi
        _ ->
          ProgressIndicator(
            ..pi,
            max: validated_max,
            value: value_validate(validated_max, pi.value),
          )
      }
    Linear ->
      case pi.mode {
        Determinate ->
          ProgressIndicator(
            ..pi,
            max: validated_max,
            value: value_validate(validated_max, pi.value),
          )
        _ -> pi
      }
  }
}

/// mode sets the `mode` field
///
pub fn mode(pi: ProgressIndicator, mode: Mode) -> ProgressIndicator {
  case pi.variant {
    Circular -> pi
    Linear -> ProgressIndicator(..pi, mode: mode)
  }
}

/// stroke_width sets the `stroke_width` field
///
pub fn stroke_width(
  pi: ProgressIndicator,
  stroke_width: StrokeWidth,
) -> ProgressIndicator {
  case pi.variant {
    Circular ->
      ProgressIndicator(..pi, stroke_width: stroke_width_validate(stroke_width))
    _ -> pi
  }
}

/// value sets the `value` field
///
pub fn value(pi: ProgressIndicator, value: Value) -> ProgressIndicator {
  case pi.variant {
    Circular ->
      case pi.mode {
        Indeterminate -> pi
        _ -> ProgressIndicator(..pi, value: value_validate(pi.max, value))
      }
    Linear ->
      case pi.mode {
        Buffer | Determinate ->
          ProgressIndicator(..pi, value: value_validate(pi.max, value))
        _ -> pi
      }
  }
}

// --- RENDERING ---

/// render creates a Lustre Element from a ProgressIndicator
///
/// ## Parameters:
/// - pi: a ProgressIndicator
/// - attributes: a list of additional Attributes
///
pub fn render(
  pi: ProgressIndicator,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  element(
    variant_to_string(pi.variant),
    list.append(
      [
        buffer_value_attr(pi.variant, pi.buffer_value),
        diameter_attr(pi.variant, pi.diameter),
        indeterminate_attr(pi.variant, pi.mode),
        attribute("max", int.to_string(pi.max)),
        mode_attr(pi.variant, pi.mode),
        stroke_width_attr(pi.variant, pi.stroke_width),
        attribute.value(int.to_string(pi.value)),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != none() }),
    [content_element(pi.variant, pi.content)]
      |> list.filter(fn(e) { e != element.none() }),
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

fn buffer_value_attr(variant: Variant, value: Value) -> Attribute(msg) {
  case variant {
    Linear -> attribute("buffer-value", int.to_string(value))
    _ -> attribute.none()
  }
}

fn buffer_value_validate(max: Maximum, value: Value) -> Value {
  value |> int.max(0) |> int.min(max)
}

fn content_element(variant: Variant, content: Option(String)) -> Element(msg) {
  case variant, content {
    Circular, Some(c) -> text(c)
    _, _ -> element.none()
  }
}

fn diameter_attr(variant: Variant, diameter: Diameter) -> Attribute(msg) {
  case variant {
    Circular if diameter > 0 -> attribute("diameter", int.to_string(diameter))
    _ -> attribute.none()
  }
}

fn diameter_validate(diameter: Diameter) -> Diameter {
  int.max(0, diameter)
}

fn indeterminate_attr(variant: Variant, mode: Mode) -> Attribute(msg) {
  case variant {
    Circular if mode == Indeterminate -> attribute("indeterminate", "")
    _ -> attribute.none()
  }
}

fn max_validate(max: Maximum) -> Maximum {
  int.max(0, max)
}

fn mode_attr(variant: Variant, mode: Mode) -> Attribute(msg) {
  case variant {
    Linear -> attribute("mode", mode_to_string(mode))
    Circular -> attribute.none()
  }
}

fn mode_to_string(mode: Mode) -> String {
  case mode {
    Buffer -> "buffer"
    Determinate -> "determinate"
    Indeterminate -> "indeterminate"
    Query -> "query"
  }
}

fn stroke_width_attr(variant: Variant, width: StrokeWidth) -> Attribute(msg) {
  case variant {
    Circular ->
      attribute("stroke-width", int.to_string(stroke_width_validate(width)))
    _ -> attribute.none()
  }
}

fn stroke_width_validate(stroke_width: StrokeWidth) -> StrokeWidth {
  int.max(0, stroke_width)
}

fn value_validate(max: Maximum, value: Value) -> Value {
  value |> int.max(0) |> int.min(max)
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Circular -> "m3e-circular-progress-indicator"
    Linear -> "m3e-linear-progress-indicator"
  }
}

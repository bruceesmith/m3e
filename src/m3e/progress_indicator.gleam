//// progress_indicator provides Lustre support for the [M3E Progress Indicator component](https://matraic.github.io/m3e/#/components/progress-indicator.html)

import gleam/int
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html.{text}

/// Diameter is an alias to Int for clarity
///
pub type Diameter =
  Int

pub const default_diameter = 40

/// Maximum is an alias to Int for clarity
///
pub type Maximum =
  Int

/// Mode of a linear indicator
///
pub type Mode {
  Buffer
  Determinate
  Indeterminate
  Query
}

fn mode_to_string(mode: Mode) -> String {
  case mode {
    Buffer -> "buffer"
    Determinate -> "determinate"
    Indeterminate -> "indeterminate"
    Query -> "query"
  }
}

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

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Circular -> "m3e-circular-progress-indicator"
    Linear -> "m3e-linear-progress-indicator"
  }
}

/// ProgressIndicator holds all the values necessary to construct an M3E Progress Indicator
///
/// ## Fields:
/// - buffer_value: A fractional value, between 0 and max, indicating buffer progress
/// - content: Optional content displayed inside the circle when determinate
/// - diameter:The diameter, in pixels, of the progress spinner
/// - indeterminate: Whether to show something is happening without conveying progress
/// - max: The maximum progress value
/// - mode: The mode of the progress bar
/// - stroke_width: The stroke width, in pixels, of the progress spinner
/// - value: A fractional value, between 0 and max, indicating progress
///
pub type ProgressIndicator {
  ProgressIndicator(
    buffer_value: Value,
    content: Option(String),
    diameter: Diameter,
    indeterminate: Bool,
    max: Maximum,
    mode: Mode,
    stroke_width: StrokeWidth,
    value: Value,
    variant: Variant,
  )
}

/// circular builds a Circular ProgressIndicator
///
/// ## Parameters:
/// - content: Optional content displayed inside the circle when determinate
/// - diameter:The diameter, in pixels, of the progress spinner
/// - indeterminate: Whether to show something is happening without conveying progress
/// - max: The maximum progress value
/// - stroke_width: The stroke width, in pixels, of the progress spinner
/// - value: A fractional value, between 0 and max, indicating progress
///
pub fn circular(
  content: Option(String),
  diameter: Diameter,
  indeterminate: Bool,
  max: Maximum,
  stroke_width: StrokeWidth,
  value: Value,
) -> ProgressIndicator {
  ProgressIndicator(
    buffer_value: 0,
    content: content,
    diameter: diameter_validate(diameter),
    indeterminate: indeterminate,
    max: max_validate(max),
    mode: Determinate,
    stroke_width: stroke_width_validate(stroke_width),
    value: value_validate(max, value),
    variant: Circular,
  )
}

/// linear builds a Linear ProgressIndicator
///
/// ## Parameters:
/// - buffer_value: A fractional value, between 0 and max, indicating buffer progress
/// - max: The maximum progress value
/// - mode: The mode of the progress bar
/// - value: A fractional value, between 0 and max, indicating progress
///
pub fn linear(
  buffer_value: Value,
  max: Maximum,
  mode: Mode,
  value: Value,
) -> ProgressIndicator {
  ProgressIndicator(
    buffer_value: buffer_value_validate(max, buffer_value),
    content: None,
    diameter: default_diameter,
    indeterminate: False,
    max: max_validate(max),
    mode: mode,
    stroke_width: default_stroke_width,
    value: value_validate(max, value),
    variant: Linear,
  )
}

/// element creates a Lustra Element from a ProgressIndicator
///
/// ## Patameter:
/// - pi: a ProgressIndicator
///
pub fn element(pi: ProgressIndicator) -> Element(msg) {
  element.element(
    variant_to_string(pi.variant),
    [
      buffer_value_attr(pi.variant, pi.buffer_value),
      diameter_attr(pi.variant, pi.diameter),
      indeterminate_attr(pi.variant, pi.indeterminate),
      max_attr(pi.max),
      mode_attr(pi.variant, pi.mode),
      stroke_width_attr(pi.variant, pi.stroke_width),
      value_attr(pi.value),
    ],
    [content_element(pi.variant, pi.content)],
  )
}

/// buffer_value sets the `buffer_value` field
///
pub fn buffer_value(pi: ProgressIndicator, value: Value) {
  case pi.variant {
    Linear ->
      ProgressIndicator(
        ..pi,
        buffer_value: buffer_value_validate(pi.max, value),
      )
    _ -> pi
  }
}

fn buffer_value_attr(variant: Variant, value: Value) -> Attribute(msg) {
  case variant {
    Linear -> attribute("buffer-value", int.to_string(value))
    _ -> attribute.none()
  }
}

fn buffer_value_validate(max: Maximum, value: Value) -> Value {
  value |> int.max(0) |> int.min(max)
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

fn content_element(variant: Variant, content: Option(String)) -> Element(msg) {
  case variant, content {
    Circular, Some(c) -> text(c)
    _, _ -> element.none()
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

fn diameter_attr(variant: Variant, diameter: Diameter) -> Attribute(msg) {
  case variant {
    Circular if diameter > 0 -> attribute("diameter", int.to_string(diameter))
    _ -> attribute.none()
  }
}

fn diameter_validate(diameter: Diameter) -> Diameter {
  int.max(0, diameter)
}

/// indeterminate sets the `indeterminate` field
///
pub fn indeterminate(
  pi: ProgressIndicator,
  indeterminate: Bool,
) -> ProgressIndicator {
  case pi.variant {
    Circular -> ProgressIndicator(..pi, indeterminate: indeterminate)
    Linear -> pi
  }
}

fn indeterminate_attr(variant: Variant, indeterminate: Bool) -> Attribute(msg) {
  case variant {
    Circular if indeterminate -> attribute("indeterminate", "")
    _ -> attribute.none()
  }
}

/// max sets the `max` field
///
pub fn max(pi: ProgressIndicator, max: Maximum) -> ProgressIndicator {
  case pi.variant {
    Circular ->
      case pi.indeterminate {
        False -> ProgressIndicator(..pi, max: max_validate(max))
        _ -> pi
      }
    Linear ->
      case pi.mode {
        Determinate -> ProgressIndicator(..pi, max: max_validate(max))
        _ -> pi
      }
  }
}

fn max_attr(max: Maximum) -> Attribute(msg) {
  attribute("max", int.to_string(max))
}

fn max_validate(max: Maximum) -> Maximum {
  int.max(0, max)
}

/// mode sets the `mode` field
///
pub fn mode(pi: ProgressIndicator, mode: Mode) -> ProgressIndicator {
  case pi.variant {
    Circular -> pi
    Linear -> ProgressIndicator(..pi, mode: mode)
  }
}

fn mode_attr(variant: Variant, mode: Mode) -> Attribute(msg) {
  case variant {
    Linear -> attribute("mode", mode_to_string(mode))
    Circular -> attribute.none()
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

/// value sets the `value` field
///
pub fn value(pi: ProgressIndicator, value: Value) -> ProgressIndicator {
  case pi.variant {
    Circular ->
      case pi.indeterminate {
        False -> ProgressIndicator(..pi, value: value_validate(pi.max, value))
        _ -> pi
      }
    Linear ->
      case pi.mode {
        Buffer | Determinate ->
          ProgressIndicator(..pi, value: value_validate(pi.max, value))
        _ -> pi
      }
  }
}

fn value_attr(value: Value) -> Attribute(msg) {
  attribute.value(int.to_string(value))
}

fn value_validate(max: Maximum, value: Value) -> Value {
  value |> int.max(0) |> int.min(max)
}

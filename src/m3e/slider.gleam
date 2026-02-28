//// slider provides Lustre support for the [M3E Slider component](https://matraic.github.io/m3e/#/components/slider.html)

import gleam/float.{to_string}
import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

/// Size of the slider
/// 
pub type Size {
  ExtraSmall
  Small
  Medium
  Large
  ExtraLarge
}

pub const default_max = 100.0

pub const default_size = ExtraSmall

pub const default_step = 1.0

pub const default_min = 0.0

/// Slider provides Lustre support for the [M3E Slider component](https://matraic.github.io/m3e/#/components/slider.html)
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - discrete: Whether to show tick marks
/// - labelled: Whether to show value labels when activated
/// - max: The maximum allowable value
/// - min: The minimum allowable value
/// - size: The size of the slider
/// - step: The value at which the thumb will snap
///
pub opaque type Slider {
  Slider(
    disabled: Bool,
    discrete: Bool,
    labelled: Bool,
    max: Float,
    min: Float,
    size: Size,
    step: Float,
  )
}

/// new creates a new Slider
///
pub fn new() -> Slider {
  Slider(
    disabled: False,
    discrete: False,
    labelled: False,
    max: default_max,
    min: default_min,
    size: default_size,
    step: default_step,
  )
}

/// disabled sets the disabled field
/// 
pub fn disabled(s: Slider, disabled: Bool) -> Slider {
  Slider(..s, disabled: disabled)
}

/// discrete sets the discrete field
///
pub fn discrete(s: Slider, discrete: Bool) -> Slider {
  Slider(..s, discrete: discrete)
}

/// labelled sets the labelled field
///
pub fn labelled(s: Slider, labelled: Bool) -> Slider {
  Slider(..s, labelled: labelled)
}

/// max sets the max field
///
pub fn max(s: Slider, max: Float) -> Slider {
  Slider(..s, max: max)
}

/// min sets the min field
///
pub fn min(s: Slider, min: Float) -> Slider {
  Slider(..s, min: min)
}

/// size sets the size field
///
pub fn size(s: Slider, size: Size) -> Slider {
  Slider(..s, size: size)
}

/// step sets the step field
///
pub fn step(s: Slider, step: Float) -> Slider {
  Slider(..s, step: step)
}

fn size_to_string(size: Size) -> String {
  case size {
    ExtraSmall -> "extra-small"
    Small -> "small"
    Medium -> "medium"
    Large -> "large"
    ExtraLarge -> "extra-large"
  }
}

/// render creates a Lustre Element(msg) from a Slider
/// 
/// ## Parameters:
/// - s: a Slider
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  s: Slider,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-slider",
    flatten([
      [
        boolean_attribute("disabled", s.disabled),
        boolean_attribute("discrete", s.discrete),
        boolean_attribute("labelled", s.labelled),
        attribute("max", to_string(s.max)),
        attribute("min", to_string(s.min)),
        attribute("size", size_to_string(s.size)),
        attribute("step", to_string(s.step)),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

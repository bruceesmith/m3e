//// slider provides Lustre support for the [M3E Slider component](https://matraic.github.io/m3e/#/components/slider.html)

import gleam/float.{to_string}
import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// Discrete specifies if a slider is discrete or continuous
pub type Discrete {
  Discrete
  Continuous
}

/// Interaction specifies if a slider is enabled or disabled
pub type Interaction {
  Enabled
  Disabled
}

/// ValueLabels specifies if a slider shows value labels
pub type ValueLabels {
  ShowLabels
  HideLabels
}

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
/// - discrete: Whether to show tick marks
/// - interaction: Whether the element is enabled or disabled
/// - labels: Whether to show value labels when activated
/// - max: The maximum allowable value
/// - min: The minimum allowable value
/// - size: The size of the slider
/// - step: The value at which the thumb will snap
///
pub opaque type Slider {
  Slider(
    discrete: Discrete,
    interaction: Interaction,
    labels: ValueLabels,
    max: Float,
    min: Float,
    size: Size,
    step: Float,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a Slider
/// 
pub type Config {
  Config(
    discrete: Discrete,
    interaction: Interaction,
    labels: ValueLabels,
    max: Float,
    min: Float,
    size: Size,
    step: Float,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    discrete: Continuous,
    interaction: Enabled,
    labels: HideLabels,
    max: default_max,
    min: default_min,
    size: default_size,
    step: default_step,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Slider
///
pub fn new() -> Slider {
  from_config(default_config())
}

/// from_config creates a Slider from a Config record
/// 
pub fn from_config(c: Config) -> Slider {
  Slider(
    discrete: c.discrete,
    interaction: c.interaction,
    labels: c.labels,
    max: c.max,
    min: c.min,
    size: c.size,
    step: c.step,
  )
}

// --- SETTERS ---

/// discrete sets the discrete field
///
pub fn discrete(s: Slider, d: Discrete) -> Slider {
  Slider(..s, discrete: d)
}

/// disabled sets the interaction field
/// 
pub fn disabled(s: Slider, i: Interaction) -> Slider {
  Slider(..s, interaction: i)
}

/// labelled sets the labels field
///
pub fn labelled(s: Slider, l: ValueLabels) -> Slider {
  Slider(..s, labels: l)
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

// --- RENDERING ---

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
        boolean_attribute("disabled", s.interaction == Disabled),
        boolean_attribute("discrete", s.discrete == Discrete),
        boolean_attribute("labelled", s.labels == ShowLabels),
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

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

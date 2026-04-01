//// slider_thumb provides Lustre support for the [M3E Slider Thumb component](https://matraic.github.io/m3e/#/components/slider.html)

import gleam/float
import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// SliderThumb provides Lustre support for the [M3E Slider Thumb component](https://matraic.github.io/m3e/#/components/slider.html)
/// 
/// ## Fields:
/// - interaction: Whether the element is enabled or disabled
/// - name: The name that identifies the element when submitting the associated form
/// - value: The value of the thumb
/// 
pub opaque type SliderThumb {
  SliderThumb(
    interaction: Interaction,
    name: Option(String),
    value: Option(Float),
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a SliderThumb
/// 
pub type Config {
  Config(interaction: Interaction, name: Option(String), value: Option(Float))
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(interaction: state.default_interaction, name: None, value: None)
}

// --- CONSTRUCTORS ---

/// new creates a new SliderThumb with default values
/// 
pub fn new() -> SliderThumb {
  from_config(default_config())
}

/// from_config creates a SliderThumb from a Config record
/// 
pub fn from_config(c: Config) -> SliderThumb {
  SliderThumb(interaction: c.interaction, name: c.name, value: c.value)
}

// --- SETTERS ---

/// disabled sets the interaction field
/// 
pub fn disabled(s: SliderThumb, interaction: Interaction) -> SliderThumb {
  SliderThumb(..s, interaction: interaction)
}

/// name sets the name field
/// 
pub fn name(s: SliderThumb, name: Option(String)) -> SliderThumb {
  SliderThumb(..s, name: name)
}

/// value sets the value field
/// 
pub fn value(s: SliderThumb, value: Option(Float)) -> SliderThumb {
  SliderThumb(..s, value: value)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a SliderThumb
/// 
/// ## Parameters:
/// - s: a SliderThumb
/// - attributes: additional attributes
///
pub fn render(s: SliderThumb, attributes: List(Attribute(msg))) -> Element(msg) {
  element.element(
    "m3e-slider-thumb",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", s.interaction == Disabled),
        helpers.option_attribute(
          s.name,
          fn(_) { "name" },
          function.identity,
          None,
        ),
        helpers.option_attribute(
          s.value,
          fn(_) { "value" },
          float.to_string,
          None,
        ),
      ],
      attributes,
    ])
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

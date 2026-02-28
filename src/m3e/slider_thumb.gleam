//// slider_thumb provides Lustre support for the [M3E Slider Thumb component](https://matraic.github.io/m3e/#/components/slider.html)

import gleam/float.{to_string}
import gleam/function
import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// SliderThumb provides Lustre support for the [M3E Slider Thumb component](https://matraic.github.io/m3e/#/components/slider.html)
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - name - The name that identifies the element when submitting the associated form
/// - value - The value of the thumb
/// 
pub opaque type SliderThumb {
  SliderThumb(disabled: Bool, name: Option(String), value: Option(Float))
}

/// new creates a new SliderThumb
/// 
pub fn new() -> SliderThumb {
  SliderThumb(disabled: False, name: None, value: None)
}

/// disabled sets the disabled field
/// 
pub fn disabled(s: SliderThumb, disabled: Bool) -> SliderThumb {
  SliderThumb(..s, disabled: disabled)
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

/// render creates a Lustre Element(msg) from a SliderThumb
/// 
/// ## Parameters:
/// - s: a SliderThumb
/// - attributes: additional attributes
///
pub fn render(s: SliderThumb, attributes: List(Attribute(msg))) -> Element(msg) {
  element(
    "m3e-slider-thumb",
    flatten([
      [
        boolean_attribute("disabled", s.disabled),
        option_attribute(s.name, fn(_) { "name" }, function.identity, None),
        option_attribute(s.value, fn(_) { "value" }, to_string, None),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    [],
  )
}

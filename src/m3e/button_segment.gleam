//// button_segment provides Lustre support for the [M3E Button Segment component](https://matraic.github.io/m3e/#/components/segmented-button.html)

import gleam/function
import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// ButtonSegment provides Lustre support for the [M3E Button Segment component](https://matraic.github.io/m3e/#/components/segmented-button.html)
///
/// ## Fields:
/// - checked: Whether the element is checked
/// - disabled: Whether the element is disabled
/// - value: A string representing the value of the segment
///
pub opaque type ButtonSegment {
  ButtonSegment(checked: Bool, disabled: Bool, value: Option(String))
}

/// new creates a new ButtonSegment
///
pub fn new() -> ButtonSegment {
  ButtonSegment(checked: False, disabled: False, value: None)
}

/// checked sets the checked field
///
pub fn checked(b: ButtonSegment, checked: Bool) -> ButtonSegment {
  ButtonSegment(..b, checked: checked)
}

/// disabled sets the disabled field
///
pub fn disabled(b: ButtonSegment, disabled: Bool) -> ButtonSegment {
  ButtonSegment(..b, disabled: disabled)
}

/// value sets the value field
///
pub fn value(b: ButtonSegment, value: Option(String)) -> ButtonSegment {
  ButtonSegment(..b, value: value)
}

/// render creates a Lustre Element(msg) from a ButtonSegment
///
/// ## Parameters:
/// - b: a ButtonSegment
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  b: ButtonSegment,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-button-segment",
    flatten([
      [
        boolean_attribute("checked", b.checked),
        boolean_attribute("disabled", b.disabled),
        option_attribute(b.value, fn(_) { "value" }, function.identity, None),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

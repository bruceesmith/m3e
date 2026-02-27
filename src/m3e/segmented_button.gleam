//// segmented_button provides Lustre support for the [M3E Segmented Button component](https://matraic.github.io/m3e/#/components/segmented-button.html)

import gleam/function
import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// SegmentedButton provides Lustre support for the [M3E Segmented Button component](https://matraic.github.io/m3e/#/components/segmented-button.html)
///
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - hide_selection_indicator: Whether to hide the selection indicator
/// - multi: Whether multiple options can be selected
/// - name: The name that identifies the element when submitting the associated form
///
pub opaque type SegmentedButton {
  SegmentedButton(
    disabled: Bool,
    hide_selection_indicator: Bool,
    multi: Bool,
    name: Option(String),
  )
}

/// new creates a new SegmentedButton
///
pub fn new() -> SegmentedButton {
  SegmentedButton(
    disabled: False,
    hide_selection_indicator: False,
    multi: False,
    name: None,
  )
}

/// disabled sets the disabled field
///
pub fn disabled(s: SegmentedButton, disabled: Bool) -> SegmentedButton {
  SegmentedButton(..s, disabled: disabled)
}

/// hide_selection_indicator sets the hide_selection_indicator field
///
pub fn hide_selection_indicator(
  s: SegmentedButton,
  hide_selection_indicator: Bool,
) -> SegmentedButton {
  SegmentedButton(..s, hide_selection_indicator: hide_selection_indicator)
}

/// multi sets the multi field
///
pub fn multi(s: SegmentedButton, multi: Bool) -> SegmentedButton {
  SegmentedButton(..s, multi: multi)
}

/// name sets the name field
///
pub fn name(s: SegmentedButton, name: Option(String)) -> SegmentedButton {
  SegmentedButton(..s, name: name)
}

/// render creates a Lustre Element(msg) from a SegmentedButton
///
/// ## Parameters:
/// - s: a SegmentedButton
/// - attributes: additional attributes
/// - children: additional children
/// 
pub fn render(
  s: SegmentedButton,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-segmented-button",
    flatten([
      [
        boolean_attribute("disabled", s.disabled),
        boolean_attribute(
          "hide-selection-indicator",
          s.hide_selection_indicator,
        ),
        boolean_attribute("multi", s.multi),
        option_attribute(s.name, fn(_) { "name" }, function.identity, None),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

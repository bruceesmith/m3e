//// radio_group provides Lustre support for the [M3E Radio Group component](https://matraic.github.io/m3e/#/components/radio-group.html)

import gleam/function
import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// RadioGroup provides Lustre support for the [M3E Radio Group component](https://matraic.github.io/m3e/#/components/radio-group.html)
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled.
/// - id: The id of the element
/// - name: The name that identifies the element when submitting the associated form
/// - required: Whether the element is required
/// 
pub opaque type RadioGroup {
  RadioGroup(
    disabled: Bool,
    id: Option(String),
    name: Option(String),
    required: Bool,
  )
}

/// new creates a new RadioGroup
///
pub fn new() -> RadioGroup {
  RadioGroup(disabled: False, id: None, name: None, required: False)
}

/// disabled sets the disabled field
///
pub fn disabled(group: RadioGroup, disabled: Bool) -> RadioGroup {
  RadioGroup(..group, disabled: disabled)
}

/// id sets the id field
///
pub fn id(group: RadioGroup, id: Option(String)) -> RadioGroup {
  RadioGroup(..group, id: id)
}

/// name sets the name field
///
pub fn name(group: RadioGroup, name: Option(String)) -> RadioGroup {
  RadioGroup(..group, name: name)
}

/// required sets the required field
///
pub fn required(group: RadioGroup, required: Bool) -> RadioGroup {
  RadioGroup(..group, required: required)
}

/// render creates a Lustre Element(msg) from a RadioGroup
///
/// ## Parameters:
/// - group: a RadioGroup
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  group: RadioGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-radio-group",
    flatten([
      [
        boolean_attribute("disabled", group.disabled),
        option_attribute(group.id, fn(_) { "id" }, function.identity, None),
        option_attribute(group.name, fn(_) { "name" }, function.identity, None),
        boolean_attribute("required", group.required),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

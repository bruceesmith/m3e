//// icon_button provides Lustre support for the [M3E Icon Button component](https://matraic.github.io/m3e/#/components/icon-button.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{
  type FormSubmitterType, boolean_attribute, form_submitter_type_to_string,
  option_attribute, slot,
}

/// Purpose defines the intended purpose of the icon
///
pub type Purpose {
  LeadingIcon
  TrailingButton
  TrailingIcon
}

fn purpose_to_string(purpose: Purpose) -> String {
  case purpose {
    LeadingIcon -> "leading-icon"
    TrailingButton -> "trailing-button"
    TrailingIcon -> "trailing-icon"
  }
}

/// Shape
///
pub type Shape {
  Rounded
  Square
}

/// shape_to_string converts a Shape to a string
/// 
pub fn shape_to_string(s: Shape) -> String {
  case s {
    Rounded -> "rounded"
    Square -> "square"
  }
}

pub const default_shape = Rounded

/// Size is the size of the button
/// extra-small, small (default), medium, large, and extra-large
/// 
pub type Size {
  ExtraSmall
  Small
  Medium
  Large
  ExtraLarge
}

/// size_to_string converts a Size to a string
/// 
fn size_to_string(s: Size) -> String {
  case s {
    ExtraSmall -> "extra-small"
    Small -> "small"
    Medium -> "medium"
    Large -> "large"
    ExtraLarge -> "extra-large"
  }
}

pub const default_size = Small

/// Variant is the appearance variant of the button
/// 
pub type Variant {
  Filled
  Tonal
  Outlined
  Standard
}

/// variant_to_string converts a Variant to a string
/// 
fn variant_to_string(v: Variant) -> String {
  case v {
    Filled -> "filled"
    Tonal -> "tonal"
    Outlined -> "outlined"
    Standard -> "standard"
  }
}

pub const default_variant = Standard

/// Width is the width of the button
/// 
pub type Width {
  Default
  Narrow
  Wide
}

/// width_to_string converts a Width to a string
/// 
fn width_to_string(w: Width) -> String {
  case w {
    Default -> "default"
    Narrow -> "narrow"
    Wide -> "wide"
  }
}

pub const default_width = Default

/// IconButton is an icon button users interact with to perform a supplementary action
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - disabled_interactive: Whether the element is disabled and interactive
/// - name: The name of the element, submitted as a pair with the element's value as part of form data, when the element is used to submit a form
/// - purpose: An slot value defined by a parent element
/// - selected: Whether the toggle button is selected
/// - shape: The shape of the button
/// - size: The size of the button
/// - toggle: Whether the button will toggle between selected and unselected states
/// - type_: The type of the element
/// - value: The value associated with the element's name when it's submitted with form data
/// - variant: The appearance variant of the button
/// - width: The width of the button
/// 
pub opaque type IconButton {
  IconButton(
    disabled: Bool,
    disabled_interactive: Bool,
    name: Option(String),
    purpose: Option(Purpose),
    selected: Bool,
    shape: Shape,
    size: Size,
    toggle: Bool,
    type_: Option(FormSubmitterType),
    value: String,
    variant: Variant,
    width: Width,
  )
}

/// new creates an icon button with default values
/// 
pub fn new() -> IconButton {
  IconButton(
    False,
    False,
    None,
    None,
    False,
    default_shape,
    default_size,
    False,
    None,
    "",
    default_variant,
    default_width,
  )
}

/// disabled sets the disabled field
/// 
pub fn disabled(i: IconButton, disabled: Bool) -> IconButton {
  IconButton(..i, disabled: disabled)
}

/// disabled_interactive sets the disabled_interactive field
/// 
pub fn disabled_interactive(
  i: IconButton,
  disabled_interactive: Bool,
) -> IconButton {
  IconButton(..i, disabled_interactive: disabled_interactive)
}

/// name sets the name field
/// 
pub fn name(i: IconButton, name: Option(String)) -> IconButton {
  IconButton(..i, name: name)
}

/// purpose sets the purpose field
/// 
pub fn purpose(i: IconButton, purpose: Option(Purpose)) -> IconButton {
  IconButton(..i, purpose: purpose)
}

/// selected sets the selected field
/// 
pub fn selected(i: IconButton, selected: Bool) -> IconButton {
  IconButton(..i, selected: selected)
}

/// shape sets the shape field
/// 
pub fn shape(i: IconButton, shape: Shape) -> IconButton {
  IconButton(..i, shape: shape)
}

/// size sets the size field
/// 
pub fn size(i: IconButton, size: Size) -> IconButton {
  IconButton(..i, size: size)
}

/// toggle sets the toggle field
/// 
pub fn toggle(i: IconButton, toggle: Bool) -> IconButton {
  IconButton(..i, toggle: toggle)
}

/// type_ sets the type_ field
/// 
pub fn type_(i: IconButton, type_: Option(FormSubmitterType)) -> IconButton {
  IconButton(..i, type_: type_)
}

/// value sets the value field
/// 
pub fn value(i: IconButton, value: String) -> IconButton {
  IconButton(..i, value: value)
}

/// variant sets the variant field
/// 
pub fn variant(i: IconButton, variant: Variant) -> IconButton {
  IconButton(..i, variant: variant)
}

/// width sets the width field
/// 
pub fn width(i: IconButton, width: Width) -> IconButton {
  IconButton(..i, width: width)
}

/// render creates a Lustre Element from an IconButton
///
/// ## Parameters:
/// - i: an IconButton
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn render(
  i: IconButton,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-icon-button",
    [
      attribute.disabled(i.disabled),
      boolean_attribute("disabled-interactive", i.disabled_interactive),
      option_attribute(i.name, fn(_) { "name" }, function.identity, None),
      case i.purpose {
        Some(p) -> slot(purpose_to_string(p))
        None -> none()
      },
      attribute.selected(i.selected),
      attribute("shape", shape_to_string(i.shape)),
      attribute("size", size_to_string(i.size)),
      boolean_attribute("toggle", i.toggle),
      option_attribute(
        i.type_,
        fn(_) { "type" },
        form_submitter_type_to_string,
        None,
      ),
      attribute.value(i.value),
      attribute("variant", variant_to_string(i.variant)),
      attribute("width", width_to_string(i.width)),
      ..attributes
    ]
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

//// button provides Lustre support for the [M3E Button component](https://matraic.github.io/m3e/#/components/button.html)

import gleam/function
import gleam/list.{append}
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, none}
import lustre/element/html.{span, text}

import m3e/helpers.{boolean_attribute, option_attribute}

/// The visual shape of the button.
pub type Shape {
  Rounded
  Square
}

fn shape_to_string(shape: Shape) -> String {
  case shape {
    Rounded -> "rounded"
    Square -> "square"
  }
}

/// Default shape
pub const default_shape = Rounded

/// The size of the button.
pub type Size {
  ExtraSmall
  Small
  Medium
  Large
  ExtraLarge
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

/// Default size
pub const default_size = Small

/// The native HTML button type, meaningful only within a form.
pub type Type {
  /// Reset button withion an HTML Form
  Reset
  /// Submit button for an HTML Form
  Submit
}

fn type_to_string(t: Type) -> String {
  case t {
    Reset -> "reset"
    Submit -> "submit"
  }
}

/// The visual variant (style) of the button.
pub type Variant {
  Elevated
  Filled
  Outlined
  Text
  Tonal
}

fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Filled -> "filled"
    Outlined -> "outlined"
    Text -> "text"
    Tonal -> "tonal"
  }
}

/// Default variant
pub const default_variant = Text

// Button holds all the values necessary to construct am M3E Button
//
pub type Button(msg) {
  Button(
    label: String,
    variant: Option(Variant),
    shape: Option(Shape),
    size: Option(Size),
    icons: List(Element(msg)),
    selected_label: Option(String),
    toggle: Bool,
    selected: Bool,
    disabled: Bool,
    type_: Option(Type),
    key: Option(String),
    value: Option(String),
  )
}

/// button returns a m3e-button element and a associated label
///
/// ## Parameters:
/// - label: the text on the button
/// - variant: the visual style of the button
/// - shape: the shape of the button
/// - size: button size
/// - icons: a of icons, empty if none are required. One is for each state (selected or not).
/// - selected_label: alternate label text when the button is selected
/// - toggle: a toggle button (or not)
/// - selected: initially selected (or not)
/// - disabled (or not)
/// - type_: type of button when used in a form
/// - key: the key under which the component's value is submitted in a form
/// - value: the value when the form is submitted
///
pub fn button(
  label: String,
  variant: Option(Variant),
  shape: Option(Shape),
  size: Option(Size),
  icons: List(Element(msg)),
  selected_label: Option(String),
  toggle: Bool,
  selected: Bool,
  disabled: Bool,
  type_: Option(Type),
  key: Option(String),
  value: Option(String),
) -> Button(msg) {
  Button(
    label: label,
    variant: variant,
    shape: shape,
    size: size,
    icons: icons,
    selected_label: selected_label,
    toggle: toggle,
    selected: selected,
    disabled: disabled,
    type_: type_,
    key: key,
    value: value,
  )
}

/// basic is a wrapper for the case of a button which uses default values fpr many parameters
///
/// ## Parameters:
/// - label`: the text on the button
/// - variant: the button variety
///
pub fn basic(label: String, variant: Variant) -> Button(msg) {
  Button(
    label,
    Some(variant),
    None,
    None,
    [],
    None,
    False,
    False,
    False,
    None,
    None,
    None,
  )
}

/// element creates a Lustre Element from a Button
///
/// ## Parameters:
/// - b: a Button
/// - attributes: a list of additional Attributes
///
pub fn element(b: Button(msg), attributes: List(Attribute(msg))) -> Element(msg) {
  element.element(
    "m3e-button",
    append(
      [
        option_attribute(
          b.variant,
          fn(_) { "variant" },
          variant_to_string,
          Some(default_variant),
        ),
        option_attribute(
          b.shape,
          fn(_) { "shape" },
          shape_to_string,
          Some(default_shape),
        ),
        option_attribute(
          b.size,
          fn(_) { "size" },
          size_to_string,
          Some(default_size),
        ),
        boolean_attribute("toggle", b.toggle),
        boolean_attribute("selected", b.selected),
        boolean_attribute("disabled", b.disabled),
        option_attribute(b.type_, fn(_) { "type" }, type_to_string, None),
        option_attribute(b.key, fn(_) { "name" }, function.identity, None),
        option_attribute(b.value, fn(_) { "value" }, function.identity, None),
      ],
      attributes,
    ),
    append(b.icons, [text(b.label), selected_label_elt(b.selected_label)]),
  )
}

/// form sets up a Button to participate in an HTML form
///
/// ## Parameters:
/// - b: a Button
/// - tipe: sets the Button to act as a Reset or Submit button for a form
/// - key: the name of the button when the form is submitted
/// - value: the value of the button when the form is submitted
///
pub fn form(
  b: Button(msg),
  type_: Option(Type),
  key: Option(String),
  value: Option(String),
) -> Button(msg) {
  Button(..b, type_: type_, key: key, value: value)
}

/// disabled sets the `disabled` field
/// 
pub fn disabled(b: Button(msg), disabled: Bool) -> Button(msg) {
  Button(..b, disabled: disabled)
}

///
/// key sets the`key` field of a Button
///
pub fn key(b: Button(msg), key: Option(String)) -> Button(msg) {
  Button(..b, key: key)
}

/// selected_label sets the`selected_label` field of a Button
///
pub fn selected_label(b: Button(msg), lab: String) -> Button(msg) {
  Button(..b, selected_label: Some(lab))
}

fn selected_label_elt(sl: Option(String)) -> Element(msg) {
  case sl {
    Some(lab) -> span([attribute("slot", "selected")], [text(lab)])
    None -> none()
  }
}

/// shape sets the`shape` field of a Button
///
pub fn shape(b: Button(msg), s: Shape) -> Button(msg) {
  Button(..b, shape: Some(s))
}

/// size sets the`size` field of a Button
///
pub fn size(b: Button(msg), s: Size) -> Button(msg) {
  Button(..b, size: Some(s))
}

/// set_type sets the`type_` field of a Button
///
pub fn set_type(b: Button(msg), t: Type) -> Button(msg) {
  Button(..b, type_: Some(t))
}

/// value sets the`value` field of a Button
///
pub fn value(b: Button(msg), v: Option(String)) -> Button(msg) {
  Button(..b, value: v)
}

/// variant sets the`variant` field of a Button
///
pub fn variant(b: Button(msg), v: Variant) -> Button(msg) {
  Button(..b, variant: Some(v))
}

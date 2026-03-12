//// icon_button provides Lustre support for the [M3E Icon Button component](https://matraic.github.io/m3e/#/components/icon-button.html)

import gleam/list.{filter, flatten}
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers.{boolean_attribute}
import m3e/link.{type Link}

// --- Types ---

/// IconButton(msg) is an icon button users interact with to perform a supplementary action
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - disabled_interactive: Whether the element is disabled and interactive
/// - form_submission: Whether the element is involved in a form submission
/// - link: Whether the element is a link
/// - purpose: A slot value defined by a parent element
/// - selected: Whether the toggle button is selected
/// - shape: The shape of the button
/// - size: The size of the button
/// - toggle: Whether the button will toggle between selected and unselected states
/// - variant: The appearance variant of the button
/// - width: The width of the button
/// 
pub opaque type IconButton(msg) {
  IconButton(
    disabled: Bool,
    disabled_interactive: Bool,
    form_submission: Option(FormSubmission),
    link: Option(Link),
    purpose: Option(Attribute(msg)),
    selected: Bool,
    shape: Shape,
    size: Size,
    toggle: Bool,
    variant: Variant,
    width: Width,
  )
}

/// Shape
///
pub type Shape {
  Rounded
  Square
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

pub const default_size = Small

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Selected
  // Renders an icon, when selected
}

/// Variant is the appearance variant of the button
/// 
pub type Variant {
  Filled
  Tonal
  Outlined
  Standard
}

pub const default_variant = Standard

/// Width is the width of the button
/// 
pub type Width {
  Default
  Narrow
  Wide
}

pub const default_width = Default

// --- CONSTRUCTORS ---

/// new creates an icon button with default values
/// 
pub fn new() -> IconButton(msg) {
  IconButton(
    disabled: False,
    disabled_interactive: False,
    form_submission: None,
    link: None,
    purpose: None,
    selected: False,
    shape: default_shape,
    size: default_size,
    toggle: False,
    variant: default_variant,
    width: default_width,
  )
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(i: IconButton(msg), disabled: Bool) -> IconButton(msg) {
  IconButton(..i, disabled: disabled)
}

/// disabled_interactive sets the disabled_interactive field
/// 
pub fn disabled_interactive(
  i: IconButton(msg),
  disabled_interactive: Bool,
) -> IconButton(msg) {
  IconButton(..i, disabled_interactive: disabled_interactive)
}

/// form sets the form_submission field
/// 
pub fn form(i: IconButton(msg), form: Option(FormSubmission)) -> IconButton(msg) {
  IconButton(..i, form_submission: form)
}

// link sets the link field
/// 
pub fn link(i: IconButton(msg), link: Option(Link)) -> IconButton(msg) {
  IconButton(..i, link: link)
}

/// purpose sets the purpose field
/// 
pub fn purpose(
  i: IconButton(msg),
  purpose: Option(Attribute(msg)),
) -> IconButton(msg) {
  IconButton(..i, purpose: purpose)
}

/// selected sets the selected field
/// 
pub fn selected(i: IconButton(msg), selected: Bool) -> IconButton(msg) {
  IconButton(..i, selected: selected)
}

/// shape sets the shape field
/// 
pub fn shape(i: IconButton(msg), shape: Shape) -> IconButton(msg) {
  IconButton(..i, shape: shape)
}

/// size sets the size field
/// 
pub fn size(i: IconButton(msg), size: Size) -> IconButton(msg) {
  IconButton(..i, size: size)
}

/// toggle sets the toggle field
/// 
pub fn toggle(i: IconButton(msg), toggle: Bool) -> IconButton(msg) {
  IconButton(..i, toggle: toggle)
}

/// variant sets the variant field
/// 
pub fn variant(i: IconButton(msg), variant: Variant) -> IconButton(msg) {
  IconButton(..i, variant: variant)
}

/// width sets the width field
/// 
pub fn width(i: IconButton(msg), width: Width) -> IconButton(msg) {
  IconButton(..i, width: width)
}

// --- RENDERING ---

/// render creates a Lustre Element from an IconButton(msg)
///
/// ## Parameters:
/// - i: an IconButton(msg)
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn render(
  i: IconButton(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-icon-button",
    flatten([
      [
        attribute.disabled(i.disabled),
        boolean_attribute("disabled-interactive", i.disabled_interactive),
        case i.purpose {
          Some(p) -> p
          None -> none()
        },
        attribute.selected(i.selected),
        attribute("shape", shape_to_string(i.shape)),
        attribute("size", size_to_string(i.size)),
        boolean_attribute("toggle", i.toggle),
        attribute("variant", variant_to_string(i.variant)),
        attribute("width", width_to_string(i.width)),
      ],
      form_submission.button_attributes(i.form_submission),
      link.attributes(i.link),
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Selected -> attribute("slot", "selected")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

/// shape_to_string converts a Shape to a string
/// 
fn shape_to_string(s: Shape) -> String {
  case s {
    Rounded -> "rounded"
    Square -> "square"
  }
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

/// width_to_string converts a Width to a string
/// 
fn width_to_string(w: Width) -> String {
  case w {
    Default -> "default"
    Narrow -> "narrow"
    Wide -> "wide"
  }
}

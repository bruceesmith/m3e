//// button provides Lustre support for the [M3E Button component](https://matraic.github.io/m3e/#/components/button.html)

import gleam/list.{filter, flatten}
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element, element, none}
import lustre/element/html.{span, text}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers.{boolean_attribute, option_attribute, slot}
import m3e/link.{type Link}

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

/// Button holds all the values necessary to construct am M3E Button
///
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - disabled_interactive: Whether the element is disabled and interactive
/// - form_submission: handles this button's role in form submission
/// - icons: Renders an icon before the button's label, Renders an icon after the button's label, Renders an icon before the button's label, when selected
/// - label: Renders the label of the button
/// - link: Make the button behave like a link
/// - selected: Whether the toggle button is selected
/// - selected_label: Renders the label of the button, when selected
/// - shape: The shape of the button
/// - size: The size of the button
/// - toggle: Whether the button will toggle between selected and unselected states
/// - variant: The appearance variant of the button
///
pub opaque type Button(msg) {
  Button(
    disabled: Bool,
    disabled_interactive: Bool,
    form_submission: Option(FormSubmission),
    icons: List(Element(msg)),
    label: String,
    link: Option(Link),
    selected: Bool,
    selected_label: Option(String),
    shape: Option(Shape),
    size: Option(Size),
    toggle: Bool,
    variant: Option(Variant),
  )
}

/// new creates a new Button
/// 
/// ## Parameters:
/// - label: the text on the button
/// - variant: the button variety
///
pub fn new(label: String, variant: Variant) -> Button(msg) {
  Button(
    disabled: False,
    disabled_interactive: False,
    form_submission: None,
    icons: [],
    label: label,
    link: None,
    selected: False,
    selected_label: None,
    shape: None,
    size: None,
    toggle: False,
    variant: Some(variant),
  )
}

/// render creates a Lustre Element from a Button
///
/// ## Parameters:
/// - b: a Button
/// - attributes: a list of additional Attributes
///
pub fn render(b: Button(msg), attributes: List(Attribute(msg))) -> Element(msg) {
  element(
    "m3e-button",
    flatten([
      [
        attribute.disabled(b.disabled),
        boolean_attribute("disabled-interactive", b.disabled_interactive),
        attribute.selected(b.selected),
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
        option_attribute(
          b.variant,
          fn(_) { "variant" },
          variant_to_string,
          Some(default_variant),
        ),
      ],
      form_submission.button_attributes(b.form_submission),
      link.attributes(b.link),
      attributes,
    ])
      |> filter(fn(a) { a != attribute.none() }),
    flatten([b.icons, [text(b.label), selected_label_elt(b.selected_label)]])
      |> filter(fn(a) { a != none() }),
  )
}

/// form_submission sets up a Button to participate in an HTML form
///
/// ## Parameters:
/// - b: a Button
/// - fs: a FormSubmission
///
pub fn form(b: Button(msg), fs: Option(FormSubmission)) -> Button(msg) {
  Button(..b, form_submission: fs)
}

/// disabled sets the `disabled` field
/// 
pub fn disabled(b: Button(msg), disabled: Bool) -> Button(msg) {
  Button(..b, disabled: disabled)
}

/// disabled_interactive sets the `disabled_interactive` field
///
pub fn disabled_interactive(b: Button(msg), disabled: Bool) -> Button(msg) {
  Button(..b, disabled_interactive: disabled)
}

/// link sets the `link` field
///
pub fn link(b: Button(msg), link: Option(Link)) -> Button(msg) {
  Button(..b, link: link)
}

/// icons sets the `icons` field
///
pub fn icons(b: Button(msg), icons: List(Element(msg))) -> Button(msg) {
  Button(..b, icons: icons)
}

/// label sets the `label` field
///
pub fn label(b: Button(msg), label: String) -> Button(msg) {
  Button(..b, label: label)
}

/// selected_label sets the`selected_label` field of a Button
///
pub fn selected_label(b: Button(msg), lab: String) -> Button(msg) {
  Button(..b, selected_label: Some(lab))
}

fn selected_label_elt(sl: Option(String)) -> Element(msg) {
  case sl {
    Some(lab) -> span([slot("selected")], [text(lab)])
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

/// toggle sets the`toggle` field of a Button
///
pub fn toggle(b: Button(msg), t: Bool) -> Button(msg) {
  Button(..b, toggle: t)
}

/// selected sets the`selected` field of a Button
///
pub fn selected(b: Button(msg), s: Bool) -> Button(msg) {
  Button(..b, selected: s)
}

/// variant sets the`variant` field of a Button
///
pub fn variant(b: Button(msg), v: Variant) -> Button(msg) {
  Button(..b, variant: Some(v))
}

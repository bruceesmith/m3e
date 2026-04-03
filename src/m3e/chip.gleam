//// chip provides Lustre support for the [M3E Chip components](https://matraic.github.io/m3e/#/components/chips.html)

import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/form_submission.{type FormSubmission}

// --- Types ---

/// Chip provides expressive, accessible chip components for actions, input, filtering, and suggestions
///
/// - form_submission: handles this element's role in form submission
/// - variant: The appearance variant of the chip
///
pub opaque type Chip(msg) {
  Chip(form_submission: Option(FormSubmission), variant: Variant)
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders an icon before the chip's label
  TrailingIcon
  // Renders an icon after the chip's label 
}

/// Variant is the style of chip
/// 
pub type Variant {
  Elevated
  Outlined
}

/// Default Variant
/// 
pub const default_variant = Outlined

// --- CONFIGURATION ---

/// Config holds the configuration for a Chip
/// 
pub type Config(msg) {
  Config(form_submission: Option(FormSubmission), variant: Variant)
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config(msg) {
  Config(form_submission: None, variant: default_variant)
}

// --- CONSTRUCTORS ---

/// from_config creates a Chip from a Config record
/// 
pub fn from_config(c: Config(msg)) -> Chip(msg) {
  Chip(form_submission: c.form_submission, variant: c.variant)
}

// --- SETTERS ---

/// form sets the form_submission field when the chip is used in a form
///
pub fn form(c: Chip(msg), form_submission: Option(FormSubmission)) -> Chip(msg) {
  Chip(..c, form_submission: form_submission)
}

/// variant sets the `variant` field
///
pub fn variant(c: Chip(msg), v: Variant) -> Chip(msg) {
  Chip(..c, variant: v)
}

// --- RENDERING ---

/// render creates a Lustre Element from a Chip
///
/// ## Parameters:
/// - c: a Chip
/// - attributes: any extra attributes, e.g. an event
/// - children: a list of child elements
///
pub fn render(
  c: Chip(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-chip",
    list.flatten([
      [
        attribute.attribute("variant", variant_to_string(c.variant)),
      ],
      form_submission.attributes(c.form_submission),
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Icon -> attribute.attribute("slot", "icon")
    TrailingIcon -> attribute.attribute("slot", "trailing-icon")
  }
}

/// variant_to_string converts a Variant to a string
/// 
pub fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Outlined -> "outlined"
  }
}
// --- PRIVATE INTERNAL HELPERS ---

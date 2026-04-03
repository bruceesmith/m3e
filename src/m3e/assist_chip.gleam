//// assist_chip provides Lustre support for the [M3E Assist Chip components](https://matraic.github.io/m3e/#/components/chips.html)

import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/chip.{type Variant}
import m3e/form_submission.{type FormSubmission}
import m3e/helpers
import m3e/link.{type Link}
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// AssistChip is a chip users interact with to perform a smart or automated action that can span multiple applications
///
/// - disabled: A value indicating whether the element is disabled
/// - disabled_interactive: A value indicating whether the element is disabled and interactive
/// - form_submission: handles this element's role in form submission
/// - link: The URL to which the link button points
/// - variant: The appearance variant of the chip
///
pub opaque type AssistChip(msg) {
  AssistChip(
    disabled: Interaction,
    disabled_interactive: Interaction,
    form_submission: Option(FormSubmission),
    link: Option(Link),
    variant: Variant,
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders an icon before the chip's label
}

// --- CONFIGURATION ---

/// Config holds the configuration for a AssistChip
/// 
pub type Config(msg) {
  Config(
    disabled: Interaction,
    disabled_interactive: Interaction,
    form_submission: Option(FormSubmission),
    link: Option(Link),
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config(msg) {
  Config(
    disabled: state.default_interaction,
    disabled_interactive: state.default_interaction,
    form_submission: None,
    link: None,
    variant: chip.default_variant,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a AssistChip from a Config record
/// 
pub fn from_config(c: Config(msg)) -> AssistChip(msg) {
  AssistChip(
    disabled: c.disabled,
    disabled_interactive: c.disabled_interactive,
    form_submission: c.form_submission,
    link: c.link,
    variant: c.variant,
  )
}

// --- SETTERS ---

/// disabled sets the `disabled` field
///
pub fn disabled(c: AssistChip(msg), disabled: Interaction) -> AssistChip(msg) {
  AssistChip(..c, disabled: disabled)
}

/// disabled_interactive sets the `disabled_interactive` field
///
pub fn disabled_interactive(
  c: AssistChip(msg),
  disabled_interactive: Interaction,
) -> AssistChip(msg) {
  AssistChip(..c, disabled_interactive: disabled_interactive)
}

/// form sets the form_submission field when the chip is used in a form
///
pub fn form(
  c: AssistChip(msg),
  form_submission: Option(FormSubmission),
) -> AssistChip(msg) {
  AssistChip(..c, form_submission: form_submission)
}

/// link sets the link field  
/// 
pub fn link(c: AssistChip(msg), link: Option(Link)) -> AssistChip(msg) {
  AssistChip(..c, link: link)
}

/// variant sets the `variant` field
///
pub fn variant(c: AssistChip(msg), v: Variant) -> AssistChip(msg) {
  AssistChip(..c, variant: v)
}

// --- RENDERING ---

/// render creates a Lustre Element from a AssistChip
///
/// ## Parameters:
/// - c: a AssistChip
/// - attributes: any extra attributes, e.g. an event
/// - children: a list of child elements
///
pub fn render(
  c: AssistChip(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-assist-chip",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", c.disabled == Disabled),
        helpers.boolean_attribute(
          "disabled-interactive",
          c.disabled_interactive == Disabled,
        ),
        attribute.attribute("variant", chip.variant_to_string(c.variant)),
      ],
      form_submission.attributes(c.form_submission),
      link.attributes(c.link),
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
  }
}
// --- PRIVATE INTERNAL HELPERS ---

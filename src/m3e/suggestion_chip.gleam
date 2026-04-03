//// suggestion_chip provides Lustre support for the [M3E Suggestion Chip components](https://matraic.github.io/m3e/#/components/chips.html)

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

/// SuggestionChip is a chip used to help narrow a user's intent by presenting dynamically generated suggestions,
/// such as suggested responses or search filters
///
/// - disabled: A value indicating whether the element is disabled
/// - disabled_interactive: A value indicating whether the element is disabled and interactive
/// - form_submission: handles this element's role in form submission
/// - link: the URL to link to when the chip is clicked
/// - variant: The appearance variant of the chip
///
pub opaque type SuggestionChip(msg) {
  SuggestionChip(
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

/// Config holds the configuration for a SuggestionChip
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

/// from_config creates a SuggestionChip from a Config record
/// 
pub fn from_config(c: Config(msg)) -> SuggestionChip(msg) {
  SuggestionChip(
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
pub fn disabled(
  c: SuggestionChip(msg),
  disabled: Interaction,
) -> SuggestionChip(msg) {
  SuggestionChip(..c, disabled: disabled)
}

/// disabled_interactive sets the `disabled_interactive` field
///
pub fn disabled_interactive(
  c: SuggestionChip(msg),
  disabled_interactive: Interaction,
) -> SuggestionChip(msg) {
  SuggestionChip(..c, disabled_interactive: disabled_interactive)
}

/// form sets the form_submission field when the chip is used in a form
///
pub fn form(
  c: SuggestionChip(msg),
  form_submission: Option(FormSubmission),
) -> SuggestionChip(msg) {
  SuggestionChip(..c, form_submission: form_submission)
}

/// link sets the `link` field
///
pub fn link(c: SuggestionChip(msg), link: Option(Link)) -> SuggestionChip(msg) {
  SuggestionChip(..c, link: link)
}

/// variant sets the `variant` field
///
pub fn variant(c: SuggestionChip(msg), v: Variant) -> SuggestionChip(msg) {
  SuggestionChip(..c, variant: v)
}

// --- RENDERING ---

/// render creates a Lustre Element from a SuggestionChip
///
/// ## Parameters:
/// - c: a SuggestionChip
/// - attributes: any extra attributes, e.g. an event
/// - children: a list of child elements
///
pub fn render(
  c: SuggestionChip(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-suggestion-chip",
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

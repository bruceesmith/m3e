//// chip provides Lustre support for the [M3E Chip components](https://matraic.github.io/m3e/#/components/chips.html)

import gleam/list.{append, flatten}
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import lustre/element/html.{text}

import m3e/form_submission.{type FormSubmission}
import m3e/icon.{type Icon}
import m3e/types.{
  type Interaction, type SelectionState, Disabled, Selected, Unselected,
  default_interaction,
}

// --- Types ---

/// Removability specifies if a chip can be removed
pub type Removability {
  Removable
  Permanent
}

/// Behaviour controls the behavior of an assist or suggestion chip
///
pub type Behaviour {
  Normal
  Reset
  Submit
}

/// Chip provides expressive, accessible chip components for actions, input, filtering, and suggestions
///
/// - label: text on the chip
/// - behaviour: behaviour of an Assist or Suggestion chip
/// - interaction: whether the Chip is enabled or disabled
/// - form_submission: handles this element's role in form submission
/// - icon: associated Icon
/// - removability: whether the chip can be removed
/// - selection: whether the chip is selected or not
/// - type_: the type of Chip
/// - variant: variant of the chip
///
pub opaque type Chip(msg) {
  Chip(
    label: String,
    behaviour: Behaviour,
    interaction: Interaction,
    form_submission: Option(FormSubmission),
    icon: Option(Icon(msg)),
    removability: Removability,
    selection: SelectionState,
    type_: Type,
    variant: Variant,
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  AssistIcon
  // Renders an icon before the chip's label 
  ChipIcon
  // Renders an icon before the chip's label 
  ChipTrailingIcon
  // Renders an icon after the chip's label 
  FilterIcon
  // Renders an icon before the chip's label 
  FilterTrailingIcon
  // Renders an icon after the chip's label 
  InputAvatar
  // Renders an avatar before the chip's label 
  InputIcon
  // Renders an icon before the chip's label 
  InputRemoveIcon
  // Renders the icon for the button used to remove the chip 
  InputSetInput
  // Renders the input element used to add new chips to the set 
  SuggestionIcon
  // Renders an icon before the chip's label 
}

/// Type of chip
/// 
pub type Type {
  Assist
  Filter
  Information
  Input
  Suggestion
}

/// Variant is the style of chip
pub type Variant {
  Elevated
  Outlined
}

/// Default Variant
pub const default_variant = Outlined

// --- CONFIGURATION ---

/// Config holds the configuration for a Chip
/// 
pub type Config(msg) {
  Config(
    label: String,
    behaviour: Behaviour,
    interaction: Interaction,
    form_submission: Option(FormSubmission),
    icon: Option(Icon(msg)),
    removability: Removability,
    selection: SelectionState,
    type_: Type,
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config(msg) {
  Config(
    label: "",
    behaviour: Normal,
    interaction: default_interaction,
    form_submission: None,
    icon: None,
    removability: Permanent,
    selection: Unselected,
    type_: Information,
    variant: default_variant,
  )
}

// --- CONSTRUCTORS ---

/// assist creates a basic Assist Chip
///
pub fn assist(label: String) -> Chip(msg) {
  from_config(Config(..default_config(), label: label, type_: Assist))
}

/// filter creates a basic Filter Chip
///
pub fn filter(label: String) -> Chip(msg) {
  from_config(Config(..default_config(), label: label, type_: Filter))
}

/// information creates a basic Information Chip
///
pub fn information(label: String) -> Chip(msg) {
  from_config(Config(..default_config(), label: label, type_: Information))
}

/// input creates a basic Input Chip
///
pub fn input(label: String) -> Chip(msg) {
  from_config(Config(..default_config(), label: label, type_: Input))
}

/// suggestion creates a basic Suggestion Chip
///
pub fn suggestion(label: String) -> Chip(msg) {
  from_config(Config(..default_config(), label: label, type_: Suggestion))
}

/// from_config creates a Chip from a Config record
/// 
pub fn from_config(c: Config(msg)) -> Chip(msg) {
  Chip(
    label: c.label,
    behaviour: c.behaviour,
    interaction: c.interaction,
    form_submission: c.form_submission,
    icon: c.icon,
    removability: c.removability,
    selection: c.selection,
    type_: c.type_,
    variant: c.variant,
  )
}

// --- SETTERS ---

/// behaviour sets the `behaviour` field
///
pub fn behaviour(c: Chip(msg), behaviour: Behaviour) -> Chip(msg) {
  case c.type_ {
    Assist | Suggestion -> Chip(..c, behaviour: behaviour)
    _ -> c
  }
}

/// disabled sets the `interaction` field
///
pub fn disabled(c: Chip(msg), interaction: Interaction) -> Chip(msg) {
  case c.type_ {
    Assist | Filter | Suggestion -> Chip(..c, interaction: interaction)
    _ -> c
  }
}

/// form sets the form_submission field when the chip is used in a form
///
pub fn form(c: Chip(msg), form_submission: Option(FormSubmission)) -> Chip(msg) {
  case c.type_ {
    Filter | Input -> Chip(..c, form_submission: form_submission)
    _ -> c
  }
}

/// icon sets the `icon` field
///
pub fn icon(c: Chip(msg), i: Icon(msg)) -> Chip(msg) {
  case c.type_ {
    Input -> c
    _ -> Chip(..c, icon: Some(i))
  }
}

/// removable sets the `removability` field
///
pub fn removable(c: Chip(msg), removability: Removability) -> Chip(msg) {
  case c.type_ {
    Input -> Chip(..c, removability: removability)
    _ -> c
  }
}

/// selected sets the `selection` field
///
pub fn selected(c: Chip(msg), selection: SelectionState) -> Chip(msg) {
  case c.type_ {
    Filter -> Chip(..c, selection: selection)
    _ -> c
  }
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
  element(
    type_to_string(c.type_),
    flatten([
      [
        behaviour_attr(c.type_, c.behaviour),
        disabled_attr(c.type_, c.interaction),
        removable_attr(c.type_, c.removability),
        selected_attr(c.type_, c.selection),
        variant_attr(c.variant),
      ],
      form_submission.attributes(c.form_submission),
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    append([icon_element(c.type_, c.icon), text(c.label)], children),
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
    AssistIcon -> attribute("slot", "icon")
    ChipIcon -> attribute("slot", "icon")
    ChipTrailingIcon -> attribute("slot", "trailing-icon")
    FilterIcon -> attribute("slot", "icon")
    FilterTrailingIcon -> attribute("slot", "trailing-icon")
    InputAvatar -> attribute("slot", "avatar")
    InputIcon -> attribute("slot", "icon")
    InputRemoveIcon -> attribute("slot", "remove-icon")
    InputSetInput -> attribute("slot", "input")
    SuggestionIcon -> attribute("slot", "icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn behaviour_attr(t: Type, b: Behaviour) -> Attribute(msg) {
  case t, b {
    Assist, Reset | Suggestion, Reset -> attribute("type", "reset")
    Assist, Submit | Suggestion, Submit -> attribute("type", "submit")
    _, _ -> none()
  }
}

fn disabled_attr(t: Type, interaction: Interaction) -> Attribute(msg) {
  case t, interaction {
    Assist, Disabled | Filter, Disabled | Suggestion, Disabled ->
      attribute("disabled", "")
    _, _ -> none()
  }
}

fn icon_element(t: Type, icon: Option(Icon(msg))) -> Element(msg) {
  case t, icon {
    Assist, Some(i) | Suggestion, Some(i) -> icon.render(i, [], [])
    Filter, Some(i) | Information, Some(i) -> icon.render(i, [], [])
    _, _ -> element.none()
  }
}

fn removable_attr(t: Type, removability: Removability) -> Attribute(msg) {
  case t, removability {
    Input, Removable -> attribute("removable", "")
    _, _ -> none()
  }
}

fn selected_attr(t: Type, selection: SelectionState) -> Attribute(msg) {
  case t, selection {
    Filter, Selected -> attribute("selected", "")
    _, _ -> none()
  }
}

fn type_to_string(t: Type) -> String {
  case t {
    Information -> "m3e-chip"
    Assist -> "m3e-assist-chip"
    Filter -> "m3e-filter-chip"
    Input -> "m3e-input-chip"
    Suggestion -> "m3e-suggestion-chip"
  }
}

fn variant_attr(v: Variant) -> Attribute(msg) {
  attribute("variant", variant_to_string(v))
}

fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Outlined -> "outlined"
  }
}

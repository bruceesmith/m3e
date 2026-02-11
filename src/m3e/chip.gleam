//// chip provides Lustre support for the [M3E Chip components](https://matraic.github.io/m3e/#/components/chips.html)

import gleam/list.{append, flatten}
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import lustre/element/html.{text}

import m3e/form_submission.{type FormSubmission}
import m3e/icon.{type Icon}

/// Behaviour controls the behavior of an assist or suggestion chip
///
pub type Behaviour {
  Normal
  Reset
  Submit
}

/// Type of chip
pub type Type {
  Assist
  Filter
  Information
  Input
  Suggestion
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

/// Variant is the style of chip
pub type Variant {
  Elevated
  Outlined
}

fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Outlined -> "outlined"
  }
}

/// Default Variant
pub const default_variant = Outlined

/// Chip is the basis for a m3e-chip element
///
/// - label: text on the chip
/// - behaviour: behaviour of an Assist or Suggestion chip
/// - disabled: whether the Chip is disabled or not
/// - form_submission: handles this element's role in form submission
/// - icon: associated Icon
/// - removable: whether the chip can be removed
/// - selected: whether the chip is selected or not
/// - type_: the type of Chip
/// - variant: variant of the chip
///
pub opaque type Chip {
  Chip(
    label: String,
    behaviour: Behaviour,
    disabled: Bool,
    form_submission: Option(FormSubmission),
    icon: Option(Icon),
    removable: Bool,
    selected: Bool,
    type_: Type,
    variant: Variant,
  )
}

fn default(label: String, type_: Type) -> Chip {
  Chip(
    label: label,
    behaviour: Normal,
    disabled: False,
    form_submission: None,
    icon: None,
    removable: False,
    selected: False,
    type_: type_,
    variant: default_variant,
  )
}

/// assist creates a basic Assist Chip
///
pub fn assist(label: String) -> Chip {
  default(label, Assist)
}

/// filter creates a basic Filter Chip
///
pub fn filter(label: String) -> Chip {
  default(label, Filter)
}

/// information creates a basic Information Chip
///
pub fn information(label: String) -> Chip {
  default(label, Information)
}

/// input creates a basic Input Chip
///
pub fn input(label: String) -> Chip {
  default(label, Input)
}

/// suggestion creates a basic Suggestion Chip
///
pub fn suggestion(label: String) -> Chip {
  default(label, Suggestion)
}

/// render creates a Lustre Element from a Chip
///
/// ## Parameters:
/// - c: a Chip
/// - attributes: any extra attributes, e.g. an event
/// - children: a list of child elements
///
pub fn render(
  c: Chip,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    type_to_string(c.type_),
    flatten([
      [
        behaviour_attr(c.type_, c.behaviour),
        disabled_attr(c.type_, c.disabled),
        removable_attr(c.type_, c.removable),
        selected_attr(c.type_, c.selected),
        variant_attr(c.variant),
      ],
      form_submission.attributes(c.form_submission),
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    append([icon_element(c.type_, c.icon), text(c.label)], children),
  )
}

/// behaviour sets the `behaviour` field
///
pub fn behaviour(c: Chip, behaviour: Behaviour) -> Chip {
  case c.type_ {
    Assist | Suggestion -> Chip(..c, behaviour: behaviour)
    _ -> c
  }
}

fn behaviour_attr(t: Type, b: Behaviour) -> Attribute(msg) {
  case t, b {
    Assist, Reset | Suggestion, Reset -> attribute("type", "reset")
    Assist, Submit | Suggestion, Submit -> attribute("type", "submit")
    _, _ -> none()
  }
}

/// disabled sets the `disabled` field
///
pub fn disabled(c: Chip, d: Bool) -> Chip {
  case c.type_ {
    Assist | Filter | Suggestion -> Chip(..c, disabled: d)
    _ -> c
  }
}

fn disabled_attr(t: Type, disabled: Bool) -> Attribute(msg) {
  case t, disabled {
    Assist, True | Filter, True | Suggestion, True -> attribute("disabled", "")
    _, _ -> none()
  }
}

/// form sets the form_submission field when the chip is used in a form
///
pub fn form(c: Chip, form_submission: Option(FormSubmission)) -> Chip {
  case c.type_ {
    Filter | Input -> Chip(..c, form_submission: form_submission)
    _ -> c
  }
}

/// icon sets the `icon` field
///
pub fn icon(c: Chip, i: Icon) -> Chip {
  case c.type_ {
    Input -> c
    _ -> Chip(..c, icon: Some(i))
  }
}

fn icon_element(t: Type, icon: Option(Icon)) -> Element(msg) {
  case t, icon {
    Assist, Some(i) | Suggestion, Some(i) -> icon.render(i, [], [])
    Filter, Some(i) | Information, Some(i) -> icon.render(i, [], [])
    _, _ -> element.none()
  }
}

/// removable sets the removable field
///
pub fn removable(c: Chip, removable: Bool) -> Chip {
  case c.type_ {
    Input -> Chip(..c, removable: removable)
    _ -> c
  }
}

fn removable_attr(t: Type, removable: Bool) -> Attribute(msg) {
  case t, removable {
    Input, True -> attribute("removable", "")
    _, _ -> none()
  }
}

/// selected sets the `selected` field
///
pub fn selected(c: Chip, s: Bool) -> Chip {
  case c.type_ {
    Filter -> Chip(..c, selected: s)
    _ -> c
  }
}

fn selected_attr(t: Type, selected: Bool) -> Attribute(msg) {
  case t, selected {
    Filter, True -> attribute("selected", "")
    _, _ -> none()
  }
}

/// variant sets the `variant` field
///
pub fn variant(c: Chip, v: Variant) -> Chip {
  Chip(..c, variant: v)
}

fn variant_attr(v: Variant) -> Attribute(msg) {
  attribute("variant", variant_to_string(v))
}

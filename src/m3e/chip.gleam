//// chip provides Lustre support for the [M3E Chip components](https://matraic.github.io/m3e/#/components/chips.html)

import gleam/list.{append}
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute, name}
import lustre/element.{type Element}
import lustre/element/html.{text}
import m3e/icon.{type Icon, leading}

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
/// - type_: the type of Chip
/// - value: value in form submission
/// - variant: variant of the chip
///
pub type Chip {
  Chip(
    label: String,
    behaviour: Behaviour,
    disabled: Bool,
    icon: Option(Icon),
    key: Option(String),
    removable: Bool,
    selected: Bool,
    type_: Type,
    value: Option(String),
    variant: Variant,
  )
}

/// chip creates a new Chip
///
/// ## Parameters:
/// - label: text on the chip
/// - behaviour: behaviour of an Assist or Suggestion chip
/// - disabled: whether the Chip is disabled or not
/// - icon: associated Icon
/// - key: `name` slot in form submission
/// - selected: whether the chip is selected or not
/// - type_: tje ype of Chip
/// - value: value in form submission
/// - variant: variant of the chip
///
pub fn chip(
  label: String,
  behaviour: Behaviour,
  disabled: Bool,
  icon: Option(Icon),
  key: Option(String),
  removable: Bool,
  selected: Bool,
  type_: Type,
  value: Option(String),
  variant: Variant,
) -> Chip {
  Chip(
    label: label,
    behaviour: behaviour,
    disabled: disabled,
    icon: icon,
    key: key,
    removable: removable,
    selected: selected,
    type_: type_,
    value: value,
    variant: variant,
  )
}

fn default(label: String, type_: Type) -> Chip {
  Chip(
    label: label,
    behaviour: Normal,
    disabled: False,
    icon: None,
    key: None,
    removable: False,
    selected: False,
    type_: type_,
    value: None,
    variant: default_variant,
  )
}

/// assist creats a basic Assist Chip
///
pub fn assist(label: String) -> Chip {
  default(label, Assist)
}

/// filter creats a basic Filter Chip
///
pub fn filter(label: String) -> Chip {
  default(label, Filter)
}

/// information creats a basic Information Chip
///
pub fn information(label: String) -> Chip {
  default(label, Information)
}

/// input creats a basic Input Chip
///
pub fn input(label: String) -> Chip {
  default(label, Input)
}

/// suggestion creats a basic Suggestion Chip
///
pub fn suggestion(label: String) -> Chip {
  default(label, Suggestion)
}

/// element creates a Lustre Element from a Chip
///
/// ## Parameters:
/// - c: a Chip
/// - icon: Icon associated with the Chip
/// - attributes: any extra attributes, e.g. an event
/// - children: a list of child elements
///
pub fn element(
  c: Chip,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    type_to_string(c.type_),
    append(
      [
        behaviour_attr(c.type_, c.behaviour),
        disabled_attr(c.type_, c.disabled),
        key_attr(c.type_, c.key),
        removable_attr(c.type_, c.removable),
        selected_attr(c.type_, c.selected),
        value_attr(c.type_, c.value),
        variant_attr(c.variant),
      ],
      attributes,
    ),
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
    _, _ -> attribute.none()
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
    _, _ -> attribute.none()
  }
}

/// form sets the fields when the chip is used in a form
///
pub fn form(c: Chip, name: Option(String), value: Option(String)) -> Chip {
  case c.type_ {
    Filter | Input -> Chip(..c, key: name, value: value)
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
    Assist, Some(i) | Suggestion, Some(i) ->
      case leading(i) {
        True -> icon.element(i, [], [])
        False -> element.none()
      }
    Filter, Some(i) | Information, Some(i) -> icon.element(i, [], [])
    _, _ -> element.none()
  }
}

fn key_attr(t: Type, key: Option(String)) -> Attribute(msg) {
  case t, key {
    Filter, Some(n) | Input, Some(n) -> name(n)
    _, _ -> attribute.none()
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
    _, _ -> attribute.none()
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
    _, _ -> attribute.none()
  }
}

fn value_attr(t: Type, value: Option(String)) -> Attribute(msg) {
  case t, value {
    Filter, Some(v) | Input, Some(v) -> attribute("value", v)
    _, _ -> attribute.none()
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

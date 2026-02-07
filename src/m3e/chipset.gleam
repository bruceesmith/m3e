//// chipset provides Lustre support for the [M3E Chip Set component](https://matraic.github.io/m3e/#/components/chip-set.html)

import gleam/list
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

/// Type of chipset
///
pub type Type {
  Information
  Filter
  Input
}

fn type_to_string(t: Type) -> String {
  case t {
    Information -> "m3e-chip-set"
    Filter -> "m3e-filter-chip-set"
    Input -> "m3e-input-chip-set"
  }
}

/// Chipset contains all the information for a ChipSet
/// 
/// ## Fields:
/// - disabled: disable the chip set in its entirety
/// - hide_selection_indicator: hide selection indicators
/// - multi: Whether multiple chips can be selected
/// - type_: the chipset type
/// - vertical: Whether the element is oriented vertically
///
pub opaque type ChipSet {
  ChipSet(
    disabled: Bool,
    hide_selection_indicator: Bool,
    multi: Bool,
    type_: Type,
    vertical: Bool,
  )
}

/// new creates a new ChipSet
///
pub fn new() -> ChipSet {
  ChipSet(
    disabled: False,
    hide_selection_indicator: False,
    multi: False,
    type_: Information,
    vertical: False,
  )
}

/// render creates a Lustre Element from a ChipSet
///
pub fn render(
  s: ChipSet,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    type_to_string(s.type_),
    list.append(
      [
        disabled_attr(s.type_, s.disabled),
        hide_selection_indicator_attr(s.type_, s.hide_selection_indicator),
        multi_attr(s.type_, s.multi),
        boolean_attribute("vertical", s.vertical),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// disabled sets the `disabled`field
///
pub fn disabled(c: ChipSet, disabled: Bool) -> ChipSet {
  case c.type_ {
    Input -> ChipSet(..c, disabled: disabled)
    _ -> c
  }
}

fn disabled_attr(t: Type, disabled: Bool) -> Attribute(msg) {
  case t, disabled {
    Input, True -> attribute("disabled", "")
    _, _ -> none()
  }
}

/// hide_selection_indicator sets the `hide_selection_indicator` field
///
pub fn hide_selection_indicator(c: ChipSet, hsi: Bool) -> ChipSet {
  case c.type_ {
    Filter -> ChipSet(..c, hide_selection_indicator: hsi)
    _ -> c
  }
}

fn hide_selection_indicator_attr(t: Type, hsi: Bool) -> Attribute(msg) {
  case t, hsi {
    Filter, True -> attribute("hide-selection-indicator", "")
    _, _ -> none()
  }
}

/// multi sets the `multi` field
///
pub fn multi(c: ChipSet, multi: Bool) -> ChipSet {
  case c.type_ {
    Filter -> ChipSet(..c, multi: multi)
    _ -> c
  }
}

fn multi_attr(t: Type, multi: Bool) -> Attribute(msg) {
  case t, multi {
    Filter, True -> attribute("multi", "")
    _, _ -> none()
  }
}

/// type_ sets the `type_` field
///
pub fn type_(c: ChipSet, t: Type) -> ChipSet {
  ChipSet(..c, type_: t)
}

/// vertical sets the `vertical` field
///
pub fn vertical(s: ChipSet, v: Bool) -> ChipSet {
  ChipSet(..s, vertical: v)
}

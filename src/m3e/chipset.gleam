import gleam/list.{append}
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}

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

pub type ChipSet {
  ChipSet(
    disabled: Bool,
    hide_selection_indicator: Bool,
    multi: Bool,
    type_: Type,
    vertical: Bool,
  )
}

/// chipset creates a new ChipSet
///
/// ## Parameters:
/// - hide_selection_indicator: whether to hide the leading tick when selected
///
pub fn chipset(t: Type) -> ChipSet {
  ChipSet(
    disabled: False,
    hide_selection_indicator: False,
    multi: False,
    type_: t,
    vertical: False,
  )
}

/// element creates a Lustre Element from a ChipSet
///
pub fn element(
  s: ChipSet,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    type_to_string(s.type_),
    append(
      [
        disabled_attr(s.type_, s.disabled),
        hide_selection_indicator_attr(s.type_, s.hide_selection_indicator),
        multi_attr(s.type_, s.multi),
        boolean_attribute("vertical", s.vertical),
      ],
      attributes,
    ),
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
    _, _ -> attribute.none()
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
    _, _ -> attribute.none()
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
    _, _ -> attribute.none()
  }
}

/// vertical sets the `vertical` field
///
pub fn vertical(s: ChipSet, v: Bool) -> ChipSet {
  ChipSet(..s, vertical: v)
}

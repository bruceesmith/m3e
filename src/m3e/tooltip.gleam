//// tooltip provides Lustre support for the M3E Tooltip component
//// https://matraic.github.io/m3e/#/components/tooltip.html

import gleam/int.{to_string}
import lustre/attribute.{type Attribute, attribute, for}
import lustre/element.{type Element, text}

import m3e/helpers.{boolean_attribute, clamp_with_default}

/// HideDelay is the amount of time, in milliseconds, before hiding the tooltip.
///
pub type HideDelay =
  Int

/// Maximum hide delay in milliseconds
pub const maximum_hide_delay = 2000

/// Default hide delay in milliseconds
pub const default_hide_delay = 1500

/// Position of the tooltip relative to its paired element
pub type Position {
  Above
  After
  Before
  Below
}

fn position_to_string(p: Position) -> String {
  case p {
    Above -> "above"
    After -> "after"
    Before -> "before"
    Below -> "below"
  }
}

/// Behaviour on touch devices
pub type TouchGestures {
  Auto
  Off
  On
}

fn gestures_to_string(g: TouchGestures) -> String {
  case g {
    Auto -> "auto"
    Off -> "off"
    On -> "on"
  }
}

/// ShowDelay is the amount of time, in milliseconds, before showing the tooltip
///
pub type ShowDelay =
  Int

/// Default show delay in milliseconds
pub const default_show_delay = 0

/// Maximum show delay in milliseconds
pub const maximum_show_delay = 500

/// Default tip position relative to its paired element
pub const default_position = Below

/// Tooltip is the basis for a m3e-tooltip element
///
/// ## Fields:
/// - tip: text of the tool tip
/// - for_id: the ID of the element to which the tip is associated
/// - position: tip position relative to its paired element
/// - hide_delay: amount of time, in milliseconds, before hiding the tooltip
/// - show_delay: amount of time, in milliseconds, before showing the tooltip
/// - disabled: the tooltip is disabled (or not)
/// - gestures: behaviour on touch devices
///
pub type Tooltip {
  Tooltip(
    tip: String,
    for_id: String,
    position: Position,
    hide_delay: HideDelay,
    show_delay: ShowDelay,
    disabled: Bool,
    gestures: TouchGestures,
  )
}

/// tooltip returns a Tooltip
///
/// ## Parameters:
/// - tip: text of the tool tip
/// - for_id: the ID of the element to which the tip is associated
/// - position: tip position relative to its paired element
/// - hide_delay: amount of time, in milliseconds, before hiding the tooltip
/// - show_delay: amount of time, in milliseconds, before showing the tooltip
/// - disabled: the tooltip is disabled (or not)
/// - gestures: behaviour on touch devices
///
pub fn tooltip(
  tip: String,
  for_id: String,
  position: Position,
  hide_delay: HideDelay,
  show_delay: ShowDelay,
  disabled: Bool,
  gestures: TouchGestures,
) -> Tooltip {
  Tooltip(
    tip: tip,
    for_id: for_id,
    position: position,
    hide_delay: hide_delay_validate(hide_delay),
    show_delay: show_delay_vaidate(show_delay),
    disabled: disabled,
    gestures: gestures,
  )
}

/// element creates a Lustre Element from a Tooltip
///
/// ## Parameter:
/// - t: a Tooltip
///
pub fn element(t: Tooltip) -> Element(msg) {
  element.element(
    "m3e-tooltip",
    [
      for(t.for_id),
      boolean_attribute("disabled", t.disabled),
      gestures_attr(t.gestures),
      hide_delay_attr(t.hide_delay),
      position_attr(t.position),
      show_delay_attr(t.show_delay),
    ],
    [
      text(t.tip),
    ],
  )
}

/// basic returns a Lustre Element representing a simple tooltip
///
/// ## Parameters:
/// - tip: text of the tool tip
/// - for_id: the ID of the element to which the tip is associated
///
pub fn basic(tip: String, for_id: String) -> Element(msg) {
  tooltip(
    tip,
    for_id,
    default_position,
    default_hide_delay,
    default_show_delay,
    False,
    Auto,
  )
  |> element
}

/// disabled sets the `disabled` field of a tooltip
///
pub fn disabled(t: Tooltip, d: Bool) -> Tooltip {
  Tooltip(..t, disabled: d)
}

/// gestures sets the `gestures` field of a Tooltip
///
pub fn gestures(t: Tooltip, g: TouchGestures) -> Tooltip {
  Tooltip(..t, gestures: g)
}

fn gestures_attr(g: TouchGestures) -> Attribute(msg) {
  attribute("touch-gestures", gestures_to_string(g))
}

/// hide_delay sets the `hide_delay` field of a Tooltip
///
pub fn hide_delay(t: Tooltip, hd: HideDelay) -> Tooltip {
  Tooltip(..t, hide_delay: hide_delay_validate(hd))
}

fn hide_delay_attr(hd: HideDelay) -> Attribute(msg) {
  attribute("hide-delay", to_string(hd))
}

fn hide_delay_validate(hd: HideDelay) -> HideDelay {
  clamp_with_default(hd, 0, maximum_hide_delay, default_hide_delay)
}

/// position sets the `position`field of a Tooltip
///
pub fn position(t: Tooltip, p: Position) -> Tooltip {
  Tooltip(..t, position: p)
}

fn position_attr(p: Position) -> Attribute(msg) {
  attribute("position", position_to_string(p))
}

/// show_delay sets the `show_delay` field of a Tooltip
///
pub fn show_delay(t: Tooltip, sd: ShowDelay) -> Tooltip {
  Tooltip(..t, show_delay: show_delay_vaidate(sd))
}

fn show_delay_attr(sd: ShowDelay) -> Attribute(msg) {
  attribute("show-delay", to_string(sd))
}

fn show_delay_vaidate(sd: ShowDelay) -> ShowDelay {
  clamp_with_default(sd, 0, maximum_show_delay, default_show_delay)
}

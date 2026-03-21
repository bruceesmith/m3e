//// tooltip provides Lustre support for the M3E Tooltip component
//// https://matraic.github.io/m3e/#/components/tooltip.html

import gleam/int.{to_string}
import gleam/list
import lustre/attribute.{type Attribute, attribute, for, none}
import lustre/element.{type Element, element, text}

import m3e/helpers.{boolean_attribute, clamp_with_default}
import m3e/types.{type Interaction, Disabled, default_interaction}

/// HideDelay is the amount of time, in milliseconds, before hiding the tooltip.
///
pub type HideDelay =
  Int

/// Maximum hide delay in milliseconds
pub const maximum_hide_delay = 2000

/// Default hide delay in milliseconds
pub const default_hide_delay = 1500

/// Position is tip position relative to its paired element
///
pub type Position {
  Above
  After
  Before
  Below
}

pub const default_position: Position = Below

/// Behaviour on touch devices
pub type TouchGestures {
  Auto
  Off
  On
}

pub const default_touch_gestures: TouchGestures = Auto

/// ShowDelay is the amount of time, in milliseconds, before showing the tooltip
///
pub type ShowDelay =
  Int

/// Default show delay in milliseconds
pub const default_show_delay = 0

/// Maximum show delay in milliseconds
pub const maximum_show_delay = 500

/// Tooltip adds additional context to a button or other UI element
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
pub opaque type Tooltip {
  Tooltip(
    tip: String,
    for_id: String,
    position: Position,
    hide_delay: HideDelay,
    show_delay: ShowDelay,
    disabled: Interaction,
    gestures: TouchGestures,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a Tooltip
///
pub type Config {
  Config(
    position: Position,
    hide_delay: HideDelay,
    show_delay: ShowDelay,
    disabled: Interaction,
    gestures: TouchGestures,
  )
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(
    position: default_position,
    hide_delay: default_hide_delay,
    show_delay: default_show_delay,
    disabled: default_interaction,
    gestures: default_touch_gestures,
  )
}

// --- CONSTRUCTORS ---

/// new returns a Tooltip
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
pub fn new(tip: String, for_id: String) -> Tooltip {
  from_config(default_config(), tip, for_id)
}

/// from_config creates a Tooltip from a Config
///
pub fn from_config(config: Config, tip: String, for_id: String) -> Tooltip {
  Tooltip(
    tip: tip,
    for_id: for_id,
    position: config.position,
    hide_delay: config.hide_delay,
    show_delay: config.show_delay,
    disabled: config.disabled,
    gestures: config.gestures,
  )
}

// --- SETTERS ---

/// disabled sets the `disabled` field of a tooltip
///
pub fn disabled(t: Tooltip, d: Interaction) -> Tooltip {
  Tooltip(..t, disabled: d)
}

/// gestures sets the `gestures` field of a Tooltip
///
pub fn gestures(t: Tooltip, g: TouchGestures) -> Tooltip {
  Tooltip(..t, gestures: g)
}

/// hide_delay sets the `hide_delay` field of a Tooltip
///
pub fn hide_delay(t: Tooltip, hd: HideDelay) -> Tooltip {
  Tooltip(..t, hide_delay: hide_delay_validate(hd))
}

/// position sets the `position`field of a Tooltip
///
pub fn position(t: Tooltip, p: Position) -> Tooltip {
  Tooltip(..t, position: p)
}

/// show_delay sets the `show_delay` field of a Tooltip
///
pub fn show_delay(t: Tooltip, sd: ShowDelay) -> Tooltip {
  Tooltip(..t, show_delay: show_delay_validate(sd))
}

// --- RENDERING ---

/// render creates a Lustre Element from a Tooltip
///
/// ## Parameters:
/// - t: a Tooltip
/// - attributes: a list of additional Attributes
///
pub fn render(t: Tooltip, attributes: List(Attribute(msg))) -> Element(msg) {
  element(
    "m3e-tooltip",
    list.append(
      [
        for(t.for_id),
        boolean_attribute("disabled", t.disabled == Disabled),
        attribute("touch-gestures", gestures_to_string(t.gestures)),
        attribute("hide-delay", to_string(t.hide_delay)),
        attribute("position", position_to_string(t.position)),
        attribute("show-delay", to_string(t.show_delay)),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != none() }),
    [text(t.tip)],
  )
}

/// render_config creates a Lustre Element directly from a Config
///
pub fn render_config(
  config: Config,
  tip: String,
  for_id: String,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  render(from_config(config, tip, for_id), attributes)
}

// --- PRIVATE INTERNAL HELPERS ---

fn gestures_to_string(g: TouchGestures) -> String {
  case g {
    Auto -> "auto"
    Off -> "off"
    On -> "on"
  }
}

fn hide_delay_validate(hd: HideDelay) -> HideDelay {
  clamp_with_default(hd, 0, maximum_hide_delay, default_hide_delay)
}

fn position_to_string(p: Position) -> String {
  case p {
    Above -> "above"
    After -> "after"
    Before -> "before"
    Below -> "below"
  }
}

fn show_delay_validate(sd: ShowDelay) -> ShowDelay {
  clamp_with_default(sd, 0, maximum_show_delay, default_show_delay)
}

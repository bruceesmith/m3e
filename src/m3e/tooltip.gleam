//// Tooltip is adds additional context to a button or other UI element.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/float
import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/tooltip_position.{type TooltipPosition}
import m3e/tooltip_touch_gestures.{type TooltipTouchGestures}

// --- Types ---

/// Tooltip is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether the element is disabled.
/// - for: The identifier of the interactive control to which this element is attached.
/// - hide_delay: The amount of time, in milliseconds, before hiding the tooltip.
/// - position: The position of the tooltip.
/// - show_delay: The amount of time, in milliseconds, before showing the tooltip.
/// - touch_gestures: The mode in which to handle touch gestures.
///
pub opaque type Tooltip {
  Tooltip(
    disabled: Disabled,
    for: Option(String),
    hide_delay: Float,
    position: TooltipPosition,
    show_delay: Float,
    touch_gestures: TooltipTouchGestures,
  )
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_for: Option(String) = None

pub const default_hide_delay: Float = 200.0

pub const default_position: TooltipPosition = tooltip_position.Below

pub const default_show_delay: Float = 0.0

pub const default_touch_gestures: TooltipTouchGestures = tooltip_touch_gestures.Auto

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    for: Option(String),
    hide_delay: Float,
    position: TooltipPosition,
    show_delay: Float,
    touch_gestures: TooltipTouchGestures,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disabled: IsNotDisabled,
    for: None,
    hide_delay: 200.0,
    position: tooltip_position.Below,
    show_delay: 0.0,
    touch_gestures: tooltip_touch_gestures.Auto,
  )
}

// --- Constructors ---

/// from_config creates a new Tooltip from the given configuration.
///
pub fn from_config(config: Config) -> Tooltip {
  Tooltip(
    disabled: config.disabled,
    for: config.for,
    hide_delay: config.hide_delay,
    position: config.position,
    show_delay: config.show_delay,
    touch_gestures: config.touch_gestures,
  )
}

/// new creates a new Tooltip with the default configuration.
///
pub fn new() -> Tooltip {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this Tooltip.
///
pub fn disabled(record: Tooltip, disabled: Disabled) -> Tooltip {
  Tooltip(..record, disabled: disabled)
}

/// for sets the value of for for this Tooltip.
///
pub fn for(record: Tooltip, for: Option(String)) -> Tooltip {
  Tooltip(..record, for: for)
}

/// hide_delay sets the value of hide_delay for this Tooltip.
///
pub fn hide_delay(record: Tooltip, hide_delay: Float) -> Tooltip {
  Tooltip(..record, hide_delay: hide_delay)
}

/// position sets the value of position for this Tooltip.
///
pub fn position(record: Tooltip, position: TooltipPosition) -> Tooltip {
  Tooltip(..record, position: position)
}

/// show_delay sets the value of show_delay for this Tooltip.
///
pub fn show_delay(record: Tooltip, show_delay: Float) -> Tooltip {
  Tooltip(..record, show_delay: show_delay)
}

/// touch_gestures sets the value of touch_gestures for this Tooltip.
///
pub fn touch_gestures(
  record: Tooltip,
  touch_gestures: TooltipTouchGestures,
) -> Tooltip {
  Tooltip(..record, touch_gestures: touch_gestures)
}

// --- Renderers ---

/// render creates a Lustre Element for a Tooltip
///
pub fn render(
  model: Tooltip,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-tooltip",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.option(model.for, fn(_) { "for" }, function.identity, default_for),
        attr.with_default(
          "hide-delay",
          float.to_string(model.hide_delay),
          float.to_string(default_hide_delay),
        ),
        attr.with_default(
          "position",
          tooltip_position.to_string(model.position),
          tooltip_position.to_string(default_position),
        ),
        attr.with_default(
          "show-delay",
          float.to_string(model.show_delay),
          float.to_string(default_show_delay),
        ),
        attr.with_default(
          "touch-gestures",
          tooltip_touch_gestures.to_string(model.touch_gestures),
          tooltip_touch_gestures.to_string(default_touch_gestures),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Tooltip Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

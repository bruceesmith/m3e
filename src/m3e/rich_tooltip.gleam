//// RichTooltip is provides contextual details for a control, such as explaining the value or purpose of a feature.
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
import m3e/rich_tooltip_position.{type RichTooltipPosition}
import m3e/tooltip_touch_gestures.{type TooltipTouchGestures}

// --- Types ---

/// RichTooltip is a View Model for this component
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
pub opaque type RichTooltip {
  RichTooltip(
    disabled: Disabled,
    for: Option(String),
    hide_delay: Float,
    position: RichTooltipPosition,
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

pub const default_position: RichTooltipPosition = rich_tooltip_position.BelowAfter

pub const default_show_delay: Float = 0.0

pub const default_touch_gestures: TooltipTouchGestures = tooltip_touch_gestures.Auto

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Subhead
  // Optional subhead text displayed above the supporting content.
  Actions
  // Optional action elements displayed at the bottom of the tooltip.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    for: Option(String),
    hide_delay: Float,
    position: RichTooltipPosition,
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
    position: rich_tooltip_position.BelowAfter,
    show_delay: 0.0,
    touch_gestures: tooltip_touch_gestures.Auto,
  )
}

// --- Constructors ---

/// from_config creates a new RichTooltip from the given configuration.
///
pub fn from_config(config: Config) -> RichTooltip {
  RichTooltip(
    disabled: config.disabled,
    for: config.for,
    hide_delay: config.hide_delay,
    position: config.position,
    show_delay: config.show_delay,
    touch_gestures: config.touch_gestures,
  )
}

/// new creates a new RichTooltip with the default configuration.
///
pub fn new() -> RichTooltip {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this RichTooltip.
///
pub fn disabled(record: RichTooltip, disabled: Disabled) -> RichTooltip {
  RichTooltip(..record, disabled: disabled)
}

/// for sets the value of for for this RichTooltip.
///
pub fn for(record: RichTooltip, for: Option(String)) -> RichTooltip {
  RichTooltip(..record, for: for)
}

/// hide_delay sets the value of hide_delay for this RichTooltip.
///
pub fn hide_delay(record: RichTooltip, hide_delay: Float) -> RichTooltip {
  RichTooltip(..record, hide_delay: hide_delay)
}

/// position sets the value of position for this RichTooltip.
///
pub fn position(
  record: RichTooltip,
  position: RichTooltipPosition,
) -> RichTooltip {
  RichTooltip(..record, position: position)
}

/// show_delay sets the value of show_delay for this RichTooltip.
///
pub fn show_delay(record: RichTooltip, show_delay: Float) -> RichTooltip {
  RichTooltip(..record, show_delay: show_delay)
}

/// touch_gestures sets the value of touch_gestures for this RichTooltip.
///
pub fn touch_gestures(
  record: RichTooltip,
  touch_gestures: TooltipTouchGestures,
) -> RichTooltip {
  RichTooltip(..record, touch_gestures: touch_gestures)
}

// --- Renderers ---

/// render creates a Lustre Element for a RichTooltip
///
pub fn render(
  model: RichTooltip,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-rich-tooltip",
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
          rich_tooltip_position.to_string(model.position),
          rich_tooltip_position.to_string(default_position),
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

/// render_config creates a Lustre Element from a RichTooltip Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Subhead -> attribute.attribute("slot", "subhead")
    Actions -> attribute.attribute("slot", "actions")
  }
}

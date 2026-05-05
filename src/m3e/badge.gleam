//// Badge is a visual indicator used to label content.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/badge_position.{type BadgePosition}
import m3e/badge_size.{type BadgeSize}

// --- Types ---

/// Badge is a View Model for this component
///
/// ## Fields:
///
/// - size: The size of the badge.
/// - position: The position of the badge, when attached to another element.
/// - for: The identifier of the interactive control to which this element is attached.
///
pub opaque type Badge {
  Badge(size: BadgeSize, position: BadgePosition, for: Option(String))
}

// --- Defaults ---

pub const default_size: BadgeSize = badge_size.Medium

pub const default_position: BadgePosition = badge_position.AboveAfter

pub const default_for: Option(String) = None

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(size: BadgeSize, position: BadgePosition, for: Option(String))
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    size: badge_size.Medium,
    position: badge_position.AboveAfter,
    for: None,
  )
}

// --- Constructors ---

/// from_config creates a new Badge from the given configuration.
///
pub fn from_config(config: Config) -> Badge {
  Badge(size: config.size, position: config.position, for: config.for)
}

/// new creates a new Badge with the default configuration.
///
pub fn new() -> Badge {
  from_config(default_config())
}

// --- Setters ---

/// size sets the value of size for this Badge.
///
pub fn size(record: Badge, size: BadgeSize) -> Badge {
  Badge(..record, size: size)
}

/// position sets the value of position for this Badge.
///
pub fn position(record: Badge, position: BadgePosition) -> Badge {
  Badge(..record, position: position)
}

/// for sets the value of for for this Badge.
///
pub fn for(record: Badge, for: Option(String)) -> Badge {
  Badge(..record, for: for)
}

// --- Renderers ---

/// render creates a Lustre Element for a Badge
///
pub fn render(
  model: Badge,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-badge",
    list.flatten([
      [
        attr.with_default(
          "size",
          badge_size.to_string(model.size),
          badge_size.to_string(default_size),
        ),
        attr.with_default(
          "position",
          badge_position.to_string(model.position),
          badge_position.to_string(default_position),
        ),
        attr.option(model.for, fn(_) { "for" }, function.identity, default_for),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Badge Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

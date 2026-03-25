//// badge provides Lustre support for the [M3E Badge component](https://matraic.github.io/m3e/#/components/badge.html)

import gleam/function
import gleam/option.{type Option, None}

import lustre/attribute
import lustre/element.{type Element}

import m3e/config.{type Size}
import m3e/helpers

// --- Types ---

/// Badge is a compact visual indicator for counts, presence, or emphasis that can be attached to icons, buttons, or other components
/// 
/// ## Fields:
/// - for: the identifier of the interactive control to which this element is attached
/// - label: the text content of the badge
/// - size: the size of the badge
/// - badge_position: the position of the badge, when attached to another element
/// 
pub opaque type Badge {
  Badge(
    for: Option(String),
    label: String,
    size: Size,
    badge_position: BadgePosition,
  )
}

/// BadgePosition is the position of the badge, when attached to another element
///
pub type BadgePosition {
  Above
  AboveAfter
  AboveBefore
  After
  Before
  Below
  BelowAfter
  BelowBefore
}

pub const default_badge_position: BadgePosition = AboveAfter

// --- CONFIGURATION ---

/// Default size
/// 
pub const default_size: Size = config.Medium

/// Config holds the configuration for a Badge
/// 
pub type Config {
  Config(
    for: Option(String),
    label: String,
    size: Size,
    badge_position: BadgePosition,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    for: None,
    label: "",
    size: default_size,
    badge_position: default_badge_position,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Badge 
/// 
pub fn new(label: String) -> Badge {
  from_config(Config(..default_config(), label: label))
}

/// from_config creates a Badge from a Config record
/// 
pub fn from_config(c: Config) -> Badge {
  Badge(
    for: c.for,
    label: c.label,
    size: c.size,
    badge_position: c.badge_position,
  )
}

// --- SETTERS ---

/// badge_position sets the badge_position field
/// 
pub fn badge_position(b: Badge, badge_position: BadgePosition) -> Badge {
  Badge(..b, badge_position: badge_position)
}

/// for sets the for field
/// 
pub fn for(b: Badge, for: Option(String)) -> Badge {
  Badge(..b, for: for)
}

/// label sets the label field
/// 
pub fn label(b: Badge, label: String) -> Badge {
  Badge(..b, label: label)
}

/// size sets the size field
/// 
pub fn size(b: Badge, size: Size) -> Badge {
  Badge(..b, size: config.clamp_to_restricted_size(size, default_size))
}

// --- RENDERING ---

/// render creates a Lustre Element from a Badge
/// 
pub fn render(b: Badge) -> Element(msg) {
  element.element(
    "m3e-badge",
    [
      helpers.option_attribute(b.for, fn(_) { "for" }, function.identity, None),
      attribute.attribute(
        "size",
        config.size_to_string(config.clamp_to_restricted_size(
          b.size,
          default_size,
        )),
      ),
      attribute.attribute(
        "position",
        badge_position_to_string(b.badge_position),
      ),
    ],
    [element.text(b.label)],
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(config: Config) -> Element(msg) {
  render(from_config(config))
}

// --- PRIVATE INTERNAL HELPERS ---

fn badge_position_to_string(badge_position: BadgePosition) -> String {
  case badge_position {
    Above -> "above"
    AboveAfter -> "above-after"
    AboveBefore -> "above-before"
    After -> "after"
    Before -> "before"
    Below -> "below"
    BelowAfter -> "below-after"
    BelowBefore -> "below-before"
  }
}

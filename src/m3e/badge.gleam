//// badge provides Lustre support for the [M3E Badge component](https://matraic.github.io/m3e/#/components/badge.html)

import gleam/function
import gleam/option.{type Option, None}

import lustre/attribute.{attribute}
import lustre/element.{type Element, element, text}

import m3e/helpers.{option_attribute}

// --- Types ---

/// Size is the size of the badge
/// 
pub type Size {
  Large
  Medium
  Small
}

pub const default_size: Size = Medium

/// Anchoring is the position of the badge, when attached to another element
///
pub type Anchoring {
  Above
  AboveAfter
  AboveBefore
  After
  Before
  Below
  BelowAfter
  BelowBefore
}

pub const default_anchoring: Anchoring = AboveAfter

/// Badge is a compact visual indicator for counts, presence, or emphasis that can be attached to icons, buttons, or other components
/// 
/// ## Fields:
/// - for: the identifier of the interactive control to which this element is attached
/// - label: the text content of the badge
/// - size: the size of the badge
/// - anchoring: the position of the badge, when attached to another element
/// 
pub opaque type Badge {
  Badge(for: Option(String), label: String, size: Size, anchoring: Anchoring)
}

// --- CONFIGURATION ---

/// Config holds the configuration for a Badge
/// 
pub type Config {
  Config(for: Option(String), label: String, size: Size, anchoring: Anchoring)
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(for: None, label: "", size: default_size, anchoring: default_anchoring)
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
  Badge(for: c.for, label: c.label, size: c.size, anchoring: c.anchoring)
}

// --- SETTERS ---

/// anchoring sets the anchoring field
/// 
pub fn anchoring(b: Badge, anchoring: Anchoring) -> Badge {
  Badge(..b, anchoring: anchoring)
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
  Badge(..b, size: size)
}

// --- RENDERING ---

/// render creates a Lustre Element from a Badge
/// 
pub fn render(b: Badge) -> Element(msg) {
  element(
    "m3e-badge",
    [
      option_attribute(b.for, fn(_) { "for" }, function.identity, None),
      attribute("size", size_to_string(b.size)),
      attribute("anchoring", anchoring_to_string(b.anchoring)),
    ],
    [text(b.label)],
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(config: Config) -> Element(msg) {
  render(from_config(config))
}

// --- PRIVATE INTERNAL HELPERS ---

fn anchoring_to_string(anchoring: Anchoring) -> String {
  case anchoring {
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

fn size_to_string(size: Size) -> String {
  case size {
    Large -> "large"
    Medium -> "medium"
    Small -> "small"
  }
}

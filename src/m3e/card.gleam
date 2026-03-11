//// card provides Lustre support for the [M3E Card component](https://matraic.github.io/m3e/#/components/card.html)

import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/link.{type Link}

// --- Types ---

/// Card is a flexible, expressive container for presenting a unified subject
/// 
/// ## Fields:
/// - actionable: Whether the card is "actionable" and will respond to use interaction
/// - disabled: Whether the element is disabled
/// - inline: Whether to present the card inline with surrounding content
/// - link: Whether the card is a link
/// - orientation: The orientation of the card
/// - variant: The appearance variant of the card
/// 
pub opaque type Card {
  Card(
    actionable: Bool,
    disabled: Bool,
    inline: Bool,
    link: Option(Link),
    orientation: Orientation,
    variant: Variant,
  )
}

/// Orientation is the orientation of the card
/// 
pub type Orientation {
  Horizontal
  Vertical
}

/// Default orientation
pub const default_orientation = Vertical

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Actions
  // Renders the actions of the card 
  Content
  // Renders the content of the card with padding 
  Footer
  // Renders the footer of the card 
  Header
  // Renders the header of the card 
}

/// Variant is the appearance variant of the card
/// 
pub type Variant {
  Elevated
  Filled
  Outlined
}

/// Default variant
pub const default_variant = Filled

// --- CONSTRUCTORS ---

/// new creates a Card with default values
/// 
pub fn new() -> Card {
  Card(False, False, False, None, default_orientation, default_variant)
}

// --- SETTERS ---

/// actionable sets the `actionable` field of a Card
/// 
pub fn actionable(c: Card, actionable: Bool) -> Card {
  Card(..c, actionable: actionable)
}

/// disabled sets the `disabled` field of a Card
/// 
pub fn disabled(c: Card, disabled: Bool) -> Card {
  Card(..c, disabled: disabled)
}

/// inline sets the `inline` field of a Card
/// 
pub fn inline(c: Card, inline: Bool) -> Card {
  Card(..c, inline: inline)
}

/// link sets the `link` field of a Card
/// 
pub fn link(c: Card, link: Option(Link)) -> Card {
  Card(..c, link: link)
}

/// orientation sets the `orientation` field of a Card
/// 
pub fn orientation(c: Card, o: Orientation) -> Card {
  Card(..c, orientation: o)
}

/// variant sets the `variant` field of a Card
/// 
pub fn variant(c: Card, v: Variant) -> Card {
  Card(..c, variant: v)
}

// --- RENDERING ---

/// render creates a Lustre Element from a Card
/// 
/// ## Parameters:
/// - c: a Card
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
/// 
pub fn render(
  c: Card,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-card",
    flatten([
      [
        boolean_attribute("actionable", c.actionable),
        boolean_attribute("disabled", c.disabled),
        boolean_attribute("inline", c.inline),
        attribute("orientation", orientation_to_string(c.orientation)),
        attribute("variant", variant_to_string(c.variant)),
      ],
      link.attributes(c.link),
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Actions -> attribute("slot", "actions")
    Content -> attribute("slot", "content")
    Footer -> attribute("slot", "footer")
    Header -> attribute("slot", "header")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn orientation_to_string(o: Orientation) -> String {
  case o {
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
}

fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Filled -> "filled"
    Outlined -> "outlined"
  }
}

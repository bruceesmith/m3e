//// card provides Lustre support for the [M3E Card component](https://matraic.github.io/m3e/#/components/card.html)

import gleam/list
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

/// Orientation is the orientation of the card
/// 
pub type Orientation {
  Horizontal
  Vertical
}

fn orientation_to_string(o: Orientation) -> String {
  case o {
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
}

/// Default orientation
pub const default_orientation = Vertical

/// Variant is the appearance variant of the card
/// 
pub type Variant {
  Elevated
  Filled
  Outlined
}

fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Filled -> "filled"
    Outlined -> "outlined"
  }
}

/// Default variant
pub const default_variant = Filled

/// Card is a flexible, expressive container for presenting a unified subject
/// 
/// ## Fields:
/// - actionable: Whether the card is "actionable" and will respond to use interaction
/// - disabled: Whether the element is disabled
/// - inline: Whether to present the card inline with surrounding content
/// - orientation: The orientation of the card
/// - variant: The appearance variant of the card
/// 
pub opaque type Card {
  Card(
    actionable: Bool,
    disabled: Bool,
    inline: Bool,
    orientation: Orientation,
    variant: Variant,
  )
}

/// new creates a Card with default values
/// 
pub fn new() -> Card {
  Card(False, False, False, default_orientation, default_variant)
}

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
    [
      boolean_attribute("actionable", c.actionable),
      boolean_attribute("disabled", c.disabled),
      boolean_attribute("inline", c.inline),
      attribute("orientation", orientation_to_string(c.orientation)),
      attribute("variant", variant_to_string(c.variant)),
      ..attributes
    ]
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

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

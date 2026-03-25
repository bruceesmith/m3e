//// card provides Lustre support for the [M3E Card component](https://matraic.github.io/m3e/#/components/card.html)

import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/layout.{type Orientation}
import m3e/link.{type Link}
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// Actionability specifies if a card is interactive
pub type Actionability {
  Actionable
  Static
}

pub const default_actionability: Actionability = Static

/// Card is a flexible, expressive container for presenting a unified subject
/// 
/// ## Fields:
/// - actionability: Whether the card is "actionable" and will respond to user interaction
/// - interaction: Whether the element is enabled or disabled
/// - layout: Whether to present the card inline with surrounding content
/// - link: Whether the card is a link
/// - orientation: The orientation of the card
/// - variant: The appearance variant of the card
/// 
pub opaque type Card {
  Card(
    actionability: Actionability,
    interaction: Interaction,
    layout: Layout,
    link: Option(Link),
    orientation: Orientation,
    variant: Variant,
  )
}

/// Layout specifies if a card is rendered inline or as a block
pub type Layout {
  Inline
  Block
}

pub const default_layout: Layout = Block

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
/// 
pub const default_variant = Filled

// --- CONFIGURATION ---

/// Config holds the configuration for a Card
/// 
pub type Config {
  Config(
    actionability: Actionability,
    interaction: Interaction,
    layout: Layout,
    link: Option(Link),
    orientation: Orientation,
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    actionability: default_actionability,
    interaction: state.default_interaction,
    layout: default_layout,
    link: None,
    orientation: layout.default_orientation,
    variant: default_variant,
  )
}

// --- CONSTRUCTORS ---

/// new creates a Card with default values
/// 
pub fn new() -> Card {
  from_config(default_config())
}

/// from_config creates a Card from a Config record
/// 
pub fn from_config(c: Config) -> Card {
  Card(
    actionability: c.actionability,
    interaction: c.interaction,
    layout: c.layout,
    link: c.link,
    orientation: c.orientation,
    variant: c.variant,
  )
}

// --- SETTERS ---

/// actionable sets the `actionability` field of a Card
/// 
pub fn actionable(c: Card, a: Actionability) -> Card {
  Card(..c, actionability: a)
}

/// disabled sets the `interaction` field of a Card
/// 
pub fn disabled(c: Card, i: Interaction) -> Card {
  Card(..c, interaction: i)
}

/// inline sets the `layout` field of a Card
/// 
pub fn inline(c: Card, l: Layout) -> Card {
  Card(..c, layout: l)
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
    list.flatten([
      [
        boolean_attribute("actionable", c.actionability == Actionable),
        boolean_attribute("disabled", c.interaction == Disabled),
        boolean_attribute("inline", c.layout == Inline),
        attribute("orientation", layout.orientation_to_string(c.orientation)),
        attribute("variant", variant_to_string(c.variant)),
      ],
      link.attributes(c.link),
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
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

fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Filled -> "filled"
    Outlined -> "outlined"
  }
}

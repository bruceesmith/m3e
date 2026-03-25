//// rich_tooltip provides Lustre support for the M3E Rich Tooltip component
//// https://matraic.github.io/m3e/#/components/tooltip.html

import gleam/int
import gleam/list

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// Position is the possible positions for a rich tooltip
///
pub type Position {
  Above
  AboveAfter
  AboveBefore
  After
  Before
  Below
  BelowBefore
  BelowAfter
}

pub const default_position: Position = Below

/// RichTooltip is an element, nested within a clickable element, used to dismiss a parenting rich tooltip
///
/// ## Fields:
/// - interaction: Whether the element is enabled or disabled.
/// - for: The identifier of the interactive control to which this element is attached
/// - hide_delay: The amount of time, in milliseconds, before hiding the tooltip
/// - position: The position of the tooltip
/// - show_delay: The amount of time, in milliseconds, before showing the tooltip
///
pub opaque type RichTooltip {
  RichTooltip(
    interaction: Interaction,
    for: String,
    hide_delay: Int,
    position: Position,
    show_delay: Int,
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Actions
  // Optional action elements displayed at the bottom of the tooltip 
  Subhead
  // Optional subhead text displayed above the supporting content 
}

// --- Configuration ---

/// Config is the configuration of a RichTooltip
/// 
/// ## Fields:
/// - interaction: Whether the element is enabled or disabled.
/// - for: The identifier of the interactive control to which this element is attached
/// - hide_delay: The amount of time, in milliseconds, before hiding the tooltip
/// - position: The position of the tooltip
/// - show_delay: The amount of time, in milliseconds, before showing the tooltip
///
pub type Config {
  Config(
    interaction: Interaction,
    for: String,
    hide_delay: Int,
    position: Position,
    show_delay: Int,
  )
}

/// default_config creates a Config with default values
///
pub fn default_config() -> Config {
  Config(
    interaction: state.default_interaction,
    for: "",
    hide_delay: 1500,
    position: default_position,
    show_delay: 0,
  )
}

// --- Constructors ---

/// from_config creates a RichTooltip from a Config
///
pub fn from_config(config: Config) -> RichTooltip {
  RichTooltip(
    interaction: config.interaction,
    for: config.for,
    hide_delay: config.hide_delay,
    position: config.position,
    show_delay: config.show_delay,
  )
}

/// new creates a RichTooltip with default values
/// 
pub fn new() -> RichTooltip {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the `interaction` field
///
pub fn disabled(r: RichTooltip, interaction: Interaction) -> RichTooltip {
  RichTooltip(..r, interaction: interaction)
}

/// for sets the `for` field
///
pub fn for(r: RichTooltip, for: String) -> RichTooltip {
  RichTooltip(..r, for: for)
}

/// hide_delay sets the `hide_delay` field
///
pub fn hide_delay(r: RichTooltip, hide_delay: Int) -> RichTooltip {
  RichTooltip(..r, hide_delay: hide_delay)
}

/// position sets the `position` field
///
pub fn position(r: RichTooltip, position: Position) -> RichTooltip {
  RichTooltip(..r, position: position)
}

/// show_delay sets the `show_delay` field
///
pub fn show_delay(r: RichTooltip, show_delay: Int) -> RichTooltip {
  RichTooltip(..r, show_delay: show_delay)
}

// --- Rendering ---

/// render creates a Lustre Element from a RichTooltip
///
pub fn render(
  r: RichTooltip,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-rich-tooltip",
    list.flatten([
      [
        boolean_attribute("disabled", r.interaction == Disabled),
        attribute("for", r.for),
        attribute("hide-delay", int.to_string(r.hide_delay)),
        attribute("position", position_to_string(r.position)),
        attribute("show-delay", int.to_string(r.show_delay)),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Actions -> attribute("slot", "actions")
    Subhead -> attribute("slot", "subhead")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn position_to_string(p: Position) -> String {
  case p {
    AboveAfter -> "above-after"
    AboveBefore -> "above-before"
    BelowBefore -> "below-before"
    BelowAfter -> "below-after"
    Before -> "before"
    After -> "after"
    Above -> "above"
    Below -> "below"
  }
}

//// expansion_panel provides Lustre support for the M3E Expansion Header component 

import gleam/list
import m3e/helpers

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

// --- Types ---

/// Direction is the direction of the expansion toggle
/// 
pub type Direction {
  Horizontal
  Vertical
}

pub const default_direction: Direction = Vertical

/// ExpansionHeader is a button used to toggle the expanded state of an expansion panel
///
/// ## Fields:
/// - hide_toggle: Whether to hide the expansion toggle
/// - toggle_direction: The direction of the expansion toggle
/// - toggle_position: The position of the expansion toggle
///
pub opaque type ExpansionHeader {
  ExpansionHeader(
    hide_toggle: ToggleVisibility,
    toggle_direction: Direction,
    toggle_position: Position,
  )
}

/// The position of the expansion toggle
/// 
pub type Position {
  After
  Before
}

pub const default_position: Position = After

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  ToggleIcon
  // Renders the icon of the expansion toggle 
}

/// Whether to hide the expansion toggle
/// 
pub type ToggleVisibility {
  ShowToggle
  // Shows the expansion toggle 
  HideToggle
  // Hides the expansion toggle 
}

pub const default_toggle_visibility: ToggleVisibility = ShowToggle

// --- CONFIGURATION ---

/// Config holds the configuration for an ExpansionHeader
/// 
pub type Config {
  Config(
    hide_toggle: ToggleVisibility,
    toggle_direction: Direction,
    toggle_position: Position,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    hide_toggle: default_toggle_visibility,
    toggle_direction: default_direction,
    toggle_position: default_position,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates an ExpansionHeader from a Config record
/// 
pub fn from_config(c: Config) -> ExpansionHeader {
  ExpansionHeader(
    hide_toggle: c.hide_toggle,
    toggle_direction: c.toggle_direction,
    toggle_position: c.toggle_position,
  )
}

/// new creates a new ExpansionHeader
/// 
pub fn new() -> ExpansionHeader {
  from_config(default_config())
}

// --- SETTERS ---

/// hide_toggle sets the `hide_toggle` field
///
pub fn hide_toggle(
  p: ExpansionHeader,
  visibility: ToggleVisibility,
) -> ExpansionHeader {
  ExpansionHeader(..p, hide_toggle: visibility)
}

/// toggle_direction sets the `toggle_direction` field
///
pub fn toggle_direction(
  p: ExpansionHeader,
  toggle_direction: Direction,
) -> ExpansionHeader {
  ExpansionHeader(..p, toggle_direction: toggle_direction)
}

/// toggle_position sets the `toggle_position` field
///
pub fn toggle_position(
  p: ExpansionHeader,
  toggle_position: Position,
) -> ExpansionHeader {
  ExpansionHeader(..p, toggle_position: toggle_position)
}

// --- RENDERING ---

/// render creates a Lustre Element from an ExpansionHeader
///
pub fn render(
  p: ExpansionHeader,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-expansion-header",
    list.append(
      [
        helpers.boolean_attribute("hide-toggle", p.hide_toggle == HideToggle),
        attribute.attribute(
          "toggle-direction",
          direction_to_string(p.toggle_direction),
        ),
        attribute.attribute(
          "toggle-position",
          position_to_string(p.toggle_position),
        ),
        ..attributes
      ],
      attributes,
    ),
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
    ToggleIcon -> attribute.attribute("slot", "toggle-icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn direction_to_string(d: Direction) -> String {
  case d {
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
}

fn position_to_string(p: Position) -> String {
  case p {
    After -> "after"
    Before -> "before"
  }
}

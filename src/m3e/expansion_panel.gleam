//// expansion_panel provides Lustre support for the M3E Expansion Panel component

import gleam/list.{filter}
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element, text}
import lustre/element/html
import m3e/helpers.{boolean_attribute}
import m3e/icon

// --- Types ---

/// Direction is the direction of the expansion toggle
/// 
pub type Direction {
  End
  Start
}

pub const default_direction: Direction = End

/// ExpansionPanel(msg) is a component that provides an expandable details-summary view
///
/// ## Fields:
/// - disabled: Whether the panel is disabled
/// - hide_toggle: Whether to hide the expansion toggle
/// - open: Whether the panel is expanded
/// - toggle_direction: The direction of the expansion toggle
/// - toggle_position: The position of the expansion toggle
/// - header: The text displayed in the header
/// - toggle_icon_name: The name of the icon to display
/// - actions: Renders the actions bar of the panel
///
pub opaque type ExpansionPanel(msg) {
  ExpansionPanel(
    disabled: Bool,
    hide_toggle: Bool,
    open: Bool,
    toggle_direction: Direction,
    toggle_position: Position,
    header: String,
    toggle_icon_name: Option(String),
    actions: Option(List(Element(msg))),
  )
}

/// Position is the position of the expansion toggle
/// It has the same values as Direction
/// 
pub type Position =
  Direction

pub const default_position = End

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Actions
  // Renders the actions bar of the panel 
  Header
  // Renders the header content 
  ToggleIcon
  // Renders the expansion toggle icon 
}

// --- CONSTRUCTORS ---

/// new creates a new ExpansionPanel
///
/// ## Parameters:
/// - header: The text displayed in the header
///
pub fn new(header: String) -> ExpansionPanel(msg) {
  ExpansionPanel(
    disabled: False,
    hide_toggle: False,
    open: False,
    toggle_direction: default_direction,
    toggle_position: default_position,
    header: header,
    toggle_icon_name: None,
    actions: None,
  )
}

// --- SETTERS ---

/// actions sets the `actions` field
/// 
pub fn actions(
  p: ExpansionPanel(msg),
  actions: Option(List(Element(msg))),
) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, actions: actions)
}

/// disabled sets the `disabled` field
///
pub fn disabled(p: ExpansionPanel(msg), disabled: Bool) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, disabled: disabled)
}

/// header sets the `header` field
///
pub fn header(p: ExpansionPanel(msg), header: String) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, header: header)
}

/// hide_toggle sets the `hide_toggle` field
///
pub fn hide_toggle(
  p: ExpansionPanel(msg),
  hide_toggle: Bool,
) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, hide_toggle: hide_toggle)
}

/// open sets the `open` field
///
pub fn open(p: ExpansionPanel(msg), open: Bool) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, open: open)
}

/// toggle_direction sets the `toggle_direction` field
///
pub fn toggle_direction(
  p: ExpansionPanel(msg),
  toggle_direction: Direction,
) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, toggle_direction: toggle_direction)
}

/// toggle_icon_name sets the `toggle_icon_name` field
///
pub fn toggle_icon_name(
  p: ExpansionPanel(msg),
  toggle_icon_name: Option(String),
) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, toggle_icon_name: toggle_icon_name)
}

/// toggle_position sets the `toggle_position` field
///
pub fn toggle_position(
  p: ExpansionPanel(msg),
  toggle_position: Position,
) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, toggle_position: toggle_position)
}

// --- RENDERING ---

/// render creates a Lustre Element from an ExpansionPanel
///
pub fn render(
  p: ExpansionPanel(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-expansion-panel",
    [
      boolean_attribute("disabled", p.disabled),
      boolean_attribute("hide-toggle", p.hide_toggle),
      boolean_attribute("open", p.open),
      attribute("toggle-direction", direction_to_string(p.toggle_direction)),
      attribute("toggle-position", position_to_string(p.toggle_position)),
      ..attributes
    ]
      |> filter(fn(a) { a != none() }),
    [
      html.span([slot(Header)], [text(p.header)]),
      case p.toggle_icon_name {
        None -> element.none()
        Some(name) ->
          icon.new(name) |> icon.purpose(icon.ToggleIcon) |> icon.render([], [])
      },
      case p.actions {
        None -> element.none()
        Some(actions) -> element("div", [slot(Actions)], actions)
      },
      ..children
    ]
      |> filter(fn(a) { a != element.none() }),
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Actions -> attribute("slot", "actions")
    Header -> attribute("slot", "header")
    ToggleIcon -> attribute("slot", "toggle-icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn direction_to_string(d: Direction) -> String {
  case d {
    End -> "end"
    Start -> "start"
  }
}

fn position_to_string(d: Direction) -> String {
  direction_to_string(d)
}

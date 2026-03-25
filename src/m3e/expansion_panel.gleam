//// expansion_panel provides Lustre support for the M3E Expansion Panel component

import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

import m3e/helpers.{boolean_attribute}
import m3e/icon
import m3e/state.{type Interaction, Disabled}

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
/// - interaction: Whether the panel is enabled or disabled
/// - toggle_visibility: Whether to hide the expansion toggle
/// - state: Whether the panel is expanded
/// - toggle_direction: The direction of the expansion toggle
/// - toggle_position: The position of the expansion toggle
/// - header: The text displayed in the header
/// - toggle_icon_name: The name of the icon to display
/// - actions: Renders the actions bar of the panel
///
pub opaque type ExpansionPanel(msg) {
  ExpansionPanel(
    interaction: Interaction,
    toggle_visibility: ToggleVisibility,
    state: PanelState,
    toggle_direction: Direction,
    toggle_position: Position,
    header: String,
    toggle_icon_name: Option(String),
    actions: Option(List(Element(msg))),
  )
}

/// PanelState specifies if the panel is expanded or collapsed
/// 
pub type PanelState {
  Open
  Closed
}

pub const default_panel_state: PanelState = Closed

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

/// ToggleVisibility specifies if the expansion toggle is hidden or shown
/// 
pub type ToggleVisibility {
  ShowToggle
  HideToggle
}

pub const default_toggle_visibility: ToggleVisibility = ShowToggle

// --- CONFIGURATION ---

/// Config holds the configuration for an ExpansionPanel
/// 
pub type Config(msg) {
  Config(
    interaction: Interaction,
    toggle_visibility: ToggleVisibility,
    state: PanelState,
    toggle_direction: Direction,
    toggle_position: Position,
    header: String,
    toggle_icon_name: Option(String),
    actions: Option(List(Element(msg))),
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config(msg) {
  Config(
    interaction: state.default_interaction,
    toggle_visibility: default_toggle_visibility,
    state: default_panel_state,
    toggle_direction: default_direction,
    toggle_position: default_position,
    header: "",
    toggle_icon_name: None,
    actions: None,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new ExpansionPanel
///
/// ## Parameters:
/// - header: The text displayed in the header
///
pub fn new(header: String) -> ExpansionPanel(msg) {
  from_config(Config(..default_config(), header: header))
}

/// from_config creates an ExpansionPanel from a Config record
/// 
pub fn from_config(c: Config(msg)) -> ExpansionPanel(msg) {
  ExpansionPanel(
    interaction: c.interaction,
    toggle_visibility: c.toggle_visibility,
    state: c.state,
    toggle_direction: c.toggle_direction,
    toggle_position: c.toggle_position,
    header: c.header,
    toggle_icon_name: c.toggle_icon_name,
    actions: c.actions,
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

/// disabled sets the `interaction` field
///
pub fn disabled(
  p: ExpansionPanel(msg),
  interaction: Interaction,
) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, interaction: interaction)
}

/// header sets the `header` field
///
pub fn header(p: ExpansionPanel(msg), header: String) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, header: header)
}

/// hide_toggle sets the `toggle_visibility` field
///
pub fn hide_toggle(
  p: ExpansionPanel(msg),
  visibility: ToggleVisibility,
) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, toggle_visibility: visibility)
}

/// open sets the `state` field
///
pub fn open(p: ExpansionPanel(msg), state: PanelState) -> ExpansionPanel(msg) {
  ExpansionPanel(..p, state: state)
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
  element.element(
    "m3e-expansion-panel",
    [
      boolean_attribute("disabled", p.interaction == Disabled),
      boolean_attribute("hide-toggle", p.toggle_visibility == HideToggle),
      boolean_attribute("open", p.state == Open),
      attribute.attribute("toggle-direction", direction_to_string(p.toggle_direction)),
      attribute.attribute("toggle-position", position_to_string(p.toggle_position)),
      ..attributes
    ]
      |> list.filter(fn(a) { a != attribute.none() }),
    [
      html.span([slot(Header)], [element.text(p.header)]),
      case p.toggle_icon_name {
        None -> element.none()
        Some(name) ->
          icon.new(name)
          |> icon.purpose(slot(ToggleIcon))
          |> icon.render([], [])
      },
      case p.actions {
        None -> element.none()
        Some(actions) -> element.element("div", [slot(Actions)], actions)
      },
      ..children
    ]
      |> list.filter(fn(a) { a != element.none() }),
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Actions -> attribute.attribute("slot", "actions")
    Header -> attribute.attribute("slot", "header")
    ToggleIcon -> attribute.attribute("slot", "toggle-icon")
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

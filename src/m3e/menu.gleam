//// menu provides Lustre support for the [M3E Menu component](https://matraic.github.io/m3e/#/components/menu.html)

import gleam/list
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}
import m3e/state.{type Interaction, Disabled}

// --- TYPES ---

/// AnimationState specifies if a menu uses animations or is instant
pub type AnimationState {
  Animated
  Instant
}

pub const default_animation_state: AnimationState = Animated

/// Menu presents a list of choices on a temporary surface
/// 
/// ## Fields:
/// - anchor: The id of the element to which the menu is anchored
/// - interaction: Whether the element is enabled or disabled
/// - position_x: The position of the menu, on the x-axis
/// - position_y: The position of the menu, on the y-axis
/// - quick: Whether to skip opening and closing animations
/// - state: Whether the menu is open or closed
/// - variant: The appearance variant of the menu
/// 
pub opaque type Menu {
  Menu(
    anchor: Option(String),
    interaction: Interaction,
    position_x: PositionX,
    position_y: PositionY,
    quick: AnimationState,
    state: MenuState,
    variant: Variant,
  )
}

/// MenuState specifies if a menu is open or closed
pub type MenuState {
  Open
  Closed
}

pub const default_menu_state: MenuState = Closed

/// PositionX is the position of the menu, on the x-axis
/// 
pub type PositionX {
  After
  Before
}

pub const default_position_x = After

/// PositionY is the position of the menu, on the y-axis
/// 
pub type PositionY {
  Above
  Below
}

pub const default_position_y = Below

/// Variant is the appearance variant of the menu
/// 
pub type Variant {
  Standard
  Vibrant
}

pub const default_variant = Standard

// --- CONFIGURATION ---

/// Config holds the configuration for a Menu
/// 
pub type Config {
  Config(
    anchor: Option(String),
    interaction: Interaction,
    position_x: PositionX,
    position_y: PositionY,
    quick: AnimationState,
    state: MenuState,
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    anchor: None,
    interaction: state.default_interaction,
    position_x: default_position_x,
    position_y: default_position_y,
    quick: default_animation_state,
    state: default_menu_state,
    variant: default_variant,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Menu
/// 
pub fn new() -> Menu {
  from_config(default_config())
}

/// from_config creates a Menu from a Config record
/// 
pub fn from_config(c: Config) -> Menu {
  Menu(
    anchor: c.anchor,
    interaction: c.interaction,
    position_x: c.position_x,
    position_y: c.position_y,
    quick: c.quick,
    state: c.state,
    variant: c.variant,
  )
}

// --- SETTERS ---

/// anchor sets the anchor field
///
pub fn anchor(m: Menu, id: String) -> Menu {
  Menu(..m, anchor: Some(id))
}

/// disabled sets the interaction field
/// 
pub fn disabled(m: Menu, i: Interaction) -> Menu {
  Menu(..m, interaction: i)
}

/// open sets the state field
/// 
pub fn open(m: Menu, s: MenuState) -> Menu {
  Menu(..m, state: s)
}

/// position_x sets the position_x field
/// 
pub fn position_x(m: Menu, position_x: PositionX) -> Menu {
  Menu(..m, position_x: position_x)
}

/// position_y sets the position_y field
/// 
pub fn position_y(m: Menu, position_y: PositionY) -> Menu {
  Menu(..m, position_y: position_y)
}

/// quick sets the quick field
/// 
pub fn quick(m: Menu, s: AnimationState) -> Menu {
  Menu(..m, quick: s)
}

/// variant sets the variant field
/// 
pub fn variant(m: Menu, variant: Variant) -> Menu {
  Menu(..m, variant: variant)
}

// --- RENDERING ---

/// render creates a Lustre Element from a Menu
///
pub fn render(
  m: Menu,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-menu",
    list.flatten([
      [
        option_attribute(m.anchor, fn(_) { "anchor" }, fn(s) { s }, None),
        boolean_attribute("disabled", m.interaction == Disabled),
        boolean_attribute("open", m.state == Open),
        attribute("position-x", position_x_to_string(m.position_x)),
        attribute("position-y", position_y_to_string(m.position_y)),
        boolean_attribute("quick", m.quick == Instant),
        attribute("variant", variant_to_string(m.variant)),
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
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

// --- PRIVATE HELPER FUNCTIONS ---

fn position_x_to_string(position_x: PositionX) -> String {
  case position_x {
    After -> "after"
    Before -> "before"
  }
}

fn position_y_to_string(position_y: PositionY) -> String {
  case position_y {
    Above -> "above"
    Below -> "below"
  }
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Standard -> "standard"
    Vibrant -> "vibrant"
  }
}

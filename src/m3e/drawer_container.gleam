//// drawer_container provides Lustre support for the [M3E DrawerContainer component](https://matraic.github.io/m3e/#/components/drawer_container.html)

import gleam/list.{append}
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}

/// Mode is the behaviour of the container
/// 
pub type Mode {
  Auto
  Over
  Push
  Side
}

/// Convert a Mode to a string
/// 
fn mode_to_string(m: Mode) -> String {
  case m {
    Auto -> "auto"
    Over -> "over"
    Push -> "push"
    Side -> "side"
  }
}

/// Default Mode
/// 
pub const default_mode = Auto

/// DrawContainer is a responsive layout container that manages collapsible left and right drawers alongside main content
/// 
/// ## Fields:
/// - end: Whether the end drawer is open
/// - end_divider: Whether to show a divider between the end drawer and content for side mode
/// - end_mode: The behavior mode of the end drawer
/// - start: Whether the start drawer is open
/// - start_divider: Whether to show a divider between the start drawer and content for side mode
/// - start_mode: The behavior mode of the start drawer.
///
pub type DrawContainer {
  DrawContainer(
    end: Bool,
    end_divider: Bool,
    end_mode: Mode,
    start: Bool,
    start_divider: Bool,
    start_mode: Mode,
  )
}

/// draw_container creates a DrawContainer
/// 
/// ## Parameters:
/// - end: Whether the end drawer is open
/// - end_divider: Whether to show a divider between the end drawer and content for side mode
/// - end_mode: The behavior mode of the end drawer
/// - start: Whether the start drawer is open
/// - start_divider: Whether to show a divider between the start drawer and content for side mode
/// - start_mode: The behavior mode of the start drawer.
/// 
/// ## Returns:
/// A DrawContainer
/// 
pub fn draw_container(
  end: Bool,
  end_divider: Bool,
  end_mode: Mode,
  start: Bool,
  start_divider: Bool,
  start_mode: Mode,
) -> DrawContainer {
  DrawContainer(
    end: end,
    end_divider: end_divider,
    end_mode: end_mode,
    start: start,
    start_divider: start_divider,
    start_mode: start_mode,
  )
}

/// basic creates a DrawContainer with default values
/// 
pub fn basic() -> DrawContainer {
  DrawContainer(False, False, default_mode, False, False, default_mode)
}

/// element creates a Lustre Element from a DrawContainer
///
/// ## Parameters:
/// - c: a DrawContainer
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn element(
  c: DrawContainer,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let end_attrs = case c.end {
    True -> [
      boolean_attribute("end", c.end),
      boolean_attribute("end-divider", c.end_divider),
      attribute("end-mode", mode_to_string(c.end_mode)),
    ]
    False -> []
  }
  let start_attrs = case c.start {
    True -> [
      boolean_attribute("start", c.start),
      boolean_attribute("start-divider", c.start_divider),
      attribute("start-mode", mode_to_string(c.start_mode)),
    ]
    False -> []
  }
  element.element(
    "m3e-drawer-container",
    append(end_attrs, start_attrs) |> append(attributes),
    children,
  )
}

/// end sets the `end` field
/// 
pub fn end(c: DrawContainer, end: Bool) -> DrawContainer {
  DrawContainer(..c, end: end)
}

/// end_divider sets the `end_divider` field
/// 
pub fn end_divider(c: DrawContainer, end_divider: Bool) -> DrawContainer {
  DrawContainer(..c, end_divider: end_divider)
}

/// end_mode sets the `end_mode` field
/// 
pub fn end_mode(c: DrawContainer, end_mode: Mode) -> DrawContainer {
  DrawContainer(..c, end_mode: end_mode)
}

/// start sets the `start` field
/// 
pub fn start(c: DrawContainer, start: Bool) -> DrawContainer {
  DrawContainer(..c, start: start)
}

/// start_divider sets the `start_divider` field
/// 
pub fn start_divider(c: DrawContainer, start_divider: Bool) -> DrawContainer {
  DrawContainer(..c, start_divider: start_divider)
}

/// start_mode sets the `start_mode` field
/// 
pub fn start_mode(c: DrawContainer, start_mode: Mode) -> DrawContainer {
  DrawContainer(..c, start_mode: start_mode)
}

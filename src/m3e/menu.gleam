//// menu provides Lustre support for the [M3E Menu component](https://matraic.github.io/m3e/#/components/menu.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

/// PositionX is the position of the menu, on the x-axis
/// 
pub type PositionX {
  After
  Before
}

fn position_x_to_string(position_x: PositionX) -> String {
  case position_x {
    After -> "after"
    Before -> "before"
  }
}

pub const default_position_x = After

/// PositionY is the position of the menu, on the y-axis
/// 
pub type PositionY {
  Above
  Below
}

fn position_y_to_string(position_y: PositionY) -> String {
  case position_y {
    Above -> "above"
    Below -> "below"
  }
}

pub const default_position_y = Below

/// Variant is the appearance variant of the menu
/// 
pub type Variant {
  Standard
  Vibrant
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Standard -> "standard"
    Vibrant -> "vibrant"
  }
}

pub const default_variant = Standard

/// Menu presents a list of choices on a temporary surface
/// 
/// ## Fields:
/// - position_x: The position of the menu, on the x-axis
/// - position_y: The position of the menu, on the y-axis
/// - variant: The appearance variant of the menu
/// 
pub opaque type Menu {
  Menu(position_x: PositionX, position_y: PositionY, variant: Variant)
}

/// new creates a new Menu
/// 
pub fn new() -> Menu {
  Menu(
    position_x: default_position_x,
    position_y: default_position_y,
    variant: default_variant,
  )
}

/// render creates a Lustre Element from a Menu
///
pub fn render(
  m: Menu,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-menu",
    flatten([
      [
        attribute("position-x", position_x_to_string(m.position_x)),
        attribute("position-y", position_y_to_string(m.position_y)),
        attribute("variant", variant_to_string(m.variant)),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
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

/// variant sets the variant field
/// 
pub fn variant(m: Menu, variant: Variant) -> Menu {
  Menu(..m, variant: variant)
}

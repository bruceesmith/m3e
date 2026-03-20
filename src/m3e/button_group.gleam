//// button group provides Lustre support for the [M3E Button Group component](https://matraic.github.io/m3e/#/components/button-group.html)

import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}
import m3e/size_many.{type Size, default_size, size_to_string}

/// Variant is the appearance variant of the group
///
pub type Variant {
  Connected
  Standard
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Connected -> "connected"
    Standard -> "standard"
  }
}

pub const default_variant = Standard

/// Button Group component arranges multiple into a unified, expressive layout
///
pub opaque type ButtonGroup {
  ButtonGroup(multi: Bool, size: Option(Size), variant: Option(Variant))
}

/// new creates a new ButtonGroup
///
pub fn new() -> ButtonGroup {
  ButtonGroup(multi: False, size: None, variant: None)
}

/// render creates a Lustre Element from a Button Group
///
/// ## Parameters:
/// - bg: a ButtonGroup
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn render(
  bg: ButtonGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-button-group",
    [
      boolean_attribute("multi", bg.multi),
      option_attribute(
        bg.size,
        fn(_) { "size" },
        size_to_string,
        Some(default_size),
      ),
      option_attribute(
        bg.variant,
        fn(_) { "variant" },
        variant_to_string,
        Some(default_variant),
      ),
      ..attributes
    ]
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// multi sets the `multi` field
///
pub fn multi(bg: ButtonGroup, multi: Bool) -> ButtonGroup {
  ButtonGroup(..bg, multi: multi)
}

/// size sets the `size` field
///
pub fn size(bg: ButtonGroup, size: Option(Size)) -> ButtonGroup {
  ButtonGroup(..bg, size: size)
}

/// variant sets the `variant` field
///
pub fn variant(bg: ButtonGroup, variant: Option(Variant)) -> ButtonGroup {
  ButtonGroup(..bg, variant: variant)
}

//// button group provides Lustre support for the [M3E Button Group component](https://matraic.github.io/m3e/#/components/button-group.html)

import gleam/option.{type Option, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// Size variants control spacing between button
///
pub type Size {
  ExtraSmall
  Small
  Medium
  Large
  ExtraLarge
}

fn size_to_string(size: Size) -> String {
  case size {
    ExtraSmall -> "extra-small"
    Small -> "small"
    Medium -> "medium"
    Large -> "large"
    ExtraLarge -> "extra-large"
  }
}

pub const default_size = Small

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
pub type ButtonGroup {
  ButtonGroup(multi: Bool, size: Option(Size), variant: Option(Variant))
}

/// button_group creats a new ButtonGroup
///
/// ## Parameters:
/// - multi: Whether multiple toggle buttons can be selected
/// - size: The size of the group
/// - variant: The appearance variant of the group
///
pub fn button_group(
  multi: Bool,
  size: Option(Size),
  variant: Option(Variant),
) -> ButtonGroup {
  ButtonGroup(multi: multi, size: size, variant: variant)
}

/// element creates a Lustre Element from a Button Group
///
/// ## Parameters:
/// - bg: a ButtonGroup
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn element(
  bg: ButtonGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
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
    ],
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

//// split_button provides Lustre support for the [M3E Split Button component](https://matraic.github.io/m3e/#/components/split-button.html)

import gleam/list.{flatten}

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

/// Size is the size of the Split Button
/// 
pub type Size {
  ExtraSmall
  Small
  Medium
  Large
  ExtraLarge
}

fn size_to_string(s: Size) -> String {
  case s {
    ExtraSmall -> "extra-small"
    Small -> "small"
    Medium -> "medium"
    Large -> "large"
    ExtraLarge -> "extra-large"
  }
}

pub const default_size = Small

/// Variant is the appearance variant of the Split Button
/// 
pub type Variant {
  Elevated
  Filled
  Outlined
  Tonal
}

fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Filled -> "filled"
    Outlined -> "outlined"
    Tonal -> "tonal"
  }
}

pub const default_variant = Filled

/// SplitButton provides Lustre support for the [M3E Split Button component](https://matraic.github.io/m3e/#/components/split-button.html)
/// 
/// ## Fields:
/// - leading: the leading part of the split button
/// - size: the size of the split button
/// - trailing: the trailing part of the split button
/// - variant: the appearance variant of the split button
///
pub opaque type SplitButton(msg) {
  SplitButton(
    leading: Element(msg),
    size: Size,
    trailing: Element(msg),
    variant: Variant,
  )
}

/// new creates a new SplitButton
/// 
pub fn new(leading: Element(msg), trailing: Element(msg)) -> SplitButton(msg) {
  SplitButton(
    leading: leading,
    size: default_size,
    trailing: trailing,
    variant: default_variant,
  )
}

/// leading sets the leading field
/// 
pub fn leading(s: SplitButton(msg), leading: Element(msg)) -> SplitButton(msg) {
  SplitButton(..s, leading: leading)
}

/// size sets the size field
/// 
pub fn size(s: SplitButton(msg), size: Size) -> SplitButton(msg) {
  SplitButton(..s, size: size)
}

/// trailing sets the trailing field
/// 
pub fn trailing(s: SplitButton(msg), trailing: Element(msg)) -> SplitButton(msg) {
  SplitButton(..s, trailing: trailing)
}

/// variant sets the variant field
/// 
pub fn variant(s: SplitButton(msg), variant: Variant) -> SplitButton(msg) {
  SplitButton(..s, variant: variant)
}

/// render creates a Lustre Element(msg) from a Split Button
/// 
/// ## Parameters:
/// - s: a SplitButton
/// - attributes: additional attributes
///
pub fn render(
  s: SplitButton(msg),
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  element(
    "m3e-split-button",
    flatten([
      [
        attribute("size", size_to_string(s.size)),
        attribute("variant", variant_to_string(s.variant)),
      ],
      attributes,
    ]),
    [s.leading, s.trailing],
  )
}

//// split_button provides Lustre support for the [M3E Split Button component](https://matraic.github.io/m3e/#/components/split-button.html)

import gleam/list.{flatten}

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

// --- Types ---

/// Size is the size of the Split Button
/// 
pub type Size {
  ExtraSmall
  Small
  Medium
  Large
  ExtraLarge
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  LeadingButton
  // The leading button used to perform the primary action 
  TrailingButton
  // The trailing icon button to open a menu of related actions
}

pub const default_size = Small

/// SplitButton provides a primary action alongside a menu of related actions, uniting two buttons in a single expressive surface
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

/// Variant is the appearance variant of the Split Button
/// 
pub type Variant {
  Elevated
  Filled
  Outlined
  Tonal
}

pub const default_variant = Filled

// --- CONSTRUCTORS ---

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

// --- SETTERS ---

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

// --- RENDERING ---

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

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    LeadingButton -> attribute("slot", "leading-button")
    TrailingButton -> attribute("slot", "trailing-button")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn size_to_string(s: Size) -> String {
  case s {
    ExtraSmall -> "extra-small"
    Small -> "small"
    Medium -> "medium"
    Large -> "large"
    ExtraLarge -> "extra-large"
  }
}

fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Filled -> "filled"
    Outlined -> "outlined"
    Tonal -> "tonal"
  }
}

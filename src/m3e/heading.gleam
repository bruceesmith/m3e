//// heading provides Lustre support for the [M3E Heading component](https://matraic.github.io/m3e/#/components/heading.html)

import lustre/attribute.{attribute}
import lustre/element.{type Element}
import lustre/element/html.{text}

import m3e/helpers.{boolean_attribute}

/// Size is the size of the heading
/// 
pub type Size {
  Large
  Medium
  Small
}

fn size_to_string(size: Size) -> String {
  case size {
    Large -> "large"
    Medium -> "medium"
    Small -> "small"
  }
}

pub const default_size = Medium

/// Variant is the appearance of the heading
/// 
pub type Variant {
  Display
  Headline
  Label
  Title
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Display -> "display"
    Headline -> "headline"
    Label -> "label"
    Title -> "title"
  }
}

pub const default_variant = Display

/// Heading is the basis for constructing an HTML m3e-heading component
/// 
pub type Heading {
  Heading(emphasized: Bool, size: Size, variant: Variant, text: String)
}

/// heading creates a Heading
/// 
pub fn heading(
  emphasized: Bool,
  size: Size,
  variant: Variant,
  text: String,
) -> Heading {
  Heading(emphasized: emphasized, size: size, variant: variant, text: text)
}

/// basic creates a Heading using default values
/// 
pub fn basic(text: String) -> Heading {
  Heading(
    emphasized: False,
    size: default_size,
    variant: default_variant,
    text: text,
  )
}

/// element creates a Lustre Element from a Heading
/// 
pub fn element(h: Heading) -> Element(msg) {
  element.element(
    "m3e-heading",
    [
      boolean_attribute("emphasized", h.emphasized),
      attribute("size", size_to_string(h.size)),
      attribute("variant", variant_to_string(h.variant)),
    ],
    [text(h.text)],
  )
}

/// emphasized sets the `emphasized` field of a Heading
/// 
pub fn emphasized(h: Heading, emphasized: Bool) -> Heading {
  Heading(..h, emphasized: emphasized)
}

/// size sets the `size` field of a Heading
/// 
pub fn size(h: Heading, size: Size) -> Heading {
  Heading(..h, size: size)
}

/// variant sets the `variant` field of a Heading
/// 
pub fn variant(h: Heading, variant: Variant) -> Heading {
  Heading(..h, variant: variant)
}

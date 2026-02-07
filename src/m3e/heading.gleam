//// heading provides Lustre support for the [M3E Heading component](https://matraic.github.io/m3e/#/components/heading.html)

import gleam/list
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
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
pub opaque type Heading {
  Heading(emphasized: Bool, size: Size, variant: Variant, text: String)
}

/// new creates a Heading using default values
/// 
/// ## Parameters:
/// - text: The text content of the heading
///
pub fn new(text: String) -> Heading {
  Heading(
    emphasized: False,
    size: default_size,
    variant: default_variant,
    text: text,
  )
}

/// render creates a Lustre Element from a Heading
/// 
pub fn render(h: Heading, attributes: List(Attribute(msg))) -> Element(msg) {
  element(
    "m3e-heading",
    [
      boolean_attribute("emphasized", h.emphasized),
      attribute("size", size_to_string(h.size)),
      attribute("variant", variant_to_string(h.variant)),
      ..attributes
    ]
      |> list.filter(fn(a) { a != none() }),
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

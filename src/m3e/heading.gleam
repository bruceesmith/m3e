//// heading provides Lustre support for the [M3E Heading component](https://matraic.github.io/m3e/#/components/heading.html)

import gleam/list
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import lustre/element/html.{text}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// Emphasis specifies if the heading is emphasized
/// 
pub type Emphasis {
  Emphasized
  Standard
}

/// Heading is the basis for constructing an HTML m3e-heading component
/// 
pub opaque type Heading {
  Heading(emphasis: Emphasis, size: Size, variant: Variant, text: String)
}

/// Size is the size of the heading
/// 
pub type Size {
  Large
  Medium
  Small
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

pub const default_variant = Display

// --- CONFIGURATION ---

/// Config holds the configuration for a Heading
/// 
pub type Config {
  Config(emphasis: Emphasis, size: Size, variant: Variant, text: String)
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    emphasis: Standard,
    size: default_size,
    variant: default_variant,
    text: "",
  )
}

// --- CONSTRUCTORS ---

/// new creates a Heading using default values
/// 
/// ## Parameters:
/// - text: The text content of the heading
///
pub fn new(text: String) -> Heading {
  from_config(Config(..default_config(), text: text))
}

/// from_config creates a Heading from a Config record
/// 
pub fn from_config(c: Config) -> Heading {
  Heading(emphasis: c.emphasis, size: c.size, variant: c.variant, text: c.text)
}

// --- SETTERS ---

/// emphasized sets the `emphasis` field of a Heading
/// 
pub fn emphasized(h: Heading, emphasis: Emphasis) -> Heading {
  Heading(..h, emphasis: emphasis)
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

// --- RENDERING ---

/// render creates a Lustre Element from a Heading
/// 
pub fn render(h: Heading, attributes: List(Attribute(msg))) -> Element(msg) {
  element(
    "m3e-heading",
    [
      boolean_attribute("emphasized", h.emphasis == Emphasized),
      attribute("size", size_to_string(h.size)),
      attribute("variant", variant_to_string(h.variant)),
      ..attributes
    ]
      |> list.filter(fn(a) { a != none() }),
    [text(h.text)],
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  render(from_config(config), attributes)
}

// --- PRIVATE INTERNAL HELPERS ---

fn size_to_string(size: Size) -> String {
  case size {
    Large -> "large"
    Medium -> "medium"
    Small -> "small"
  }
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Display -> "display"
    Headline -> "headline"
    Label -> "label"
    Title -> "title"
  }
}

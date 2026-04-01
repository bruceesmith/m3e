//// heading provides Lustre support for the [M3E Heading component](https://matraic.github.io/m3e/#/components/heading.html)

import gleam/int
import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/config.{type Size}
import m3e/helpers

// --- Types ---

/// Emphasis specifies if the heading is emphasized
/// 
pub type Emphasis {
  Emphasized
  Standard
}

pub const default_emphasized = Standard

/// Heading is the basis for constructing an HTML m3e-heading component
/// 
/// ## Fields:
/// - emphasized: Whether the heading uses an emphasized typescale
/// - level: The accessibility level of the heading
/// - size: The size of the heading
/// - variant: The appearance variant of the heading
/// - text: The heading text
/// 
pub opaque type Heading {
  Heading(
    emphasized: Emphasis,
    level: Int,
    size: Size,
    variant: Variant,
    text: String,
  )
}

pub const default_size: Size = config.Medium

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
  Config(
    emphasized: Emphasis,
    level: Int,
    size: Size,
    variant: Variant,
    text: String,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    emphasized: default_emphasized,
    level: 1,
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
  Heading(
    emphasized: c.emphasized,
    level: helpers.clamp_with_default(c.level, 1, 6, 1),
    size: c.size,
    variant: c.variant,
    text: c.text,
  )
}

// --- SETTERS ---

/// emphasized sets the `emphasized` field of a Heading
/// 
pub fn emphasized(h: Heading, emphasized: Emphasis) -> Heading {
  Heading(..h, emphasized: emphasized)
}

/// level sets the `level` field of a Heading
///
pub fn level(h: Heading, level: Int) -> Heading {
  Heading(..h, level: helpers.clamp_with_default(level, 1, 6, 1))
}

/// size sets the `size` field of a Heading
/// 
pub fn size(h: Heading, size: Size) -> Heading {
  Heading(..h, size: config.clamp_to_restricted_size(size, default_size))
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
  element.element(
    "m3e-heading",
    [
      helpers.boolean_attribute("emphasized", h.emphasized == Emphasized),
      attribute.attribute("level", int.to_string(h.level)),
      attribute.attribute(
        "size",
        config.size_to_string(config.clamp_to_restricted_size(
          h.size,
          default_size,
        )),
      ),
      attribute.attribute("variant", variant_to_string(h.variant)),
      ..attributes
    ]
      |> list.filter(fn(a) { a != attribute.none() }),
    [element.text(h.text)],
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

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Display -> "display"
    Headline -> "headline"
    Label -> "label"
    Title -> "title"
  }
}

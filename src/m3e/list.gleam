//// list provides Lustre support for the [M3E List component](https://matraic.github.io/m3e/#/components/list.html)

import gleam/list
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}

import m3e/list_variant.{type Variant, default_variant, variant_to_string}

// --- Types ---

/// List provides expressive, accessible components for organizing and displaying lists of items
/// 
/// ## Fields:
/// - variant: The appearance variant of the list
/// 
pub opaque type M3EList {
  M3EList(variant: Variant)
}

// --- CONFIGURATION ---

/// Config is the configuration of a List
/// 
pub type Config {
  Config(variant: Variant)
}

/// default_config creates a Config with default values
/// 
pub fn default_config() -> Config {
  Config(variant: default_variant)
}

// --- CONSTRUCTORS ---

/// from_config creates a List from a Config
/// 
pub fn from_config(config: Config) -> M3EList {
  M3EList(variant: config.variant)
}

/// new creates a List with default values
/// 
pub fn new() -> M3EList {
  M3EList(variant: default_variant)
}

// --- SETTERS ---

/// variant sets the `variant` field
/// 
pub fn variant(_: M3EList, variant: Variant) -> M3EList {
  M3EList(variant: variant)
}

// --- RENDERING ---

/// render creates a Lustre Element from a List
///
pub fn render(
  l: M3EList,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-list",
    list.flatten([
      [attribute("variant", variant_to_string(l.variant))],
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
///
/// ## Parameters:
/// - config: a Config
/// - attributes: a list of additional Attributes
/// - children: the main content
///
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}
// --- PRIVATE INTERNAL HELPERS ---

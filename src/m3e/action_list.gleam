//// action_list provides Lustre support for the [M3E Action List component](https://matraic.github.io/m3e/#/components/list.html)

import gleam/list.{filter, flatten}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/list_variant.{type Variant, Standard, variant_to_string}

// --- TYPES ---

/// ActionList provides a specialized list container for action-based interactions following Material 3 design principles
/// 
/// ## Fields:
/// - variant: The appearance variant of the list
/// 
pub opaque type ActionList {
  ActionList(variant: Variant)
}

// --- CONFIGURATION ---

/// Config is the configuration of an ActionList
/// 
pub type Config {
  Config(variant: Variant)
}

/// default_config creates a Config with default values
/// 
pub fn default_config() -> Config {
  Config(variant: Standard)
}

// --- CONSTRUCTORS ---

/// from_config creates an ActionList from a Config
/// 
pub fn from_config(config: Config) -> ActionList {
  ActionList(variant: config.variant)
}

/// new creates an ActionList with default values
/// 
/// ## Parameters:
/// - variant: The appearance variant of the list
/// 
pub fn new(variant: Variant) -> ActionList {
  ActionList(variant)
}

// --- SETTERS ---

/// variant sets the `variant` field
/// 
pub fn variant(_: ActionList, variant: Variant) -> ActionList {
  ActionList(variant: variant)
}

// --- RENDERING ---

/// render creates a Lustre Element from an ActionList
/// 
pub fn render(
  a: ActionList,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-action-list",
    flatten([
      [attribute("variant", variant_to_string(a.variant))],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}
// --- PRIVATE INTERNAL HELPERS ---

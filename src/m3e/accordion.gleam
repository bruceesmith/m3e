//// accordion provides Lustre support for the [M3E Accordion component](https://matraic.github.io/m3e/#/components/expansion-panel.html)

import gleam/list.{filter}
import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}
import m3e/helpers.{boolean_attribute}

// --- TYPES ---

/// Accordion is a container for Expansion Panels
///
/// ## Fields:
/// - multi: Whether multiple panels can be expanded at the same time
///
pub opaque type Accordion {
  Accordion(multi: Bool)
}

// --- CONFIGURATION ---

/// Config holds the configuration for an Accordion
///
/// ## Fields:
/// - multi: Whether multiple panels can be expanded at the same time
///
pub type Config {
  Config(multi: Bool)
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(multi: False)
}

// --- CONSTRUCTORS ---

/// new creates a new Accordion
///
pub fn new() -> Accordion {
  Accordion(multi: False)
}

/// from_config creates a new Accordion from a Config
///
pub fn from_config(config: Config) -> Accordion {
  Accordion(multi: config.multi)
}

// --- SETTERS ---

/// multi sets the `multi` field
///
pub fn multi(_: Accordion, multi: Bool) -> Accordion {
  Accordion(multi: multi)
}

// --- RENDERING ---

/// render creates a Lustre Element from an Accordion
///
pub fn render(
  a: Accordion,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-accordion",
    [boolean_attribute("multi", a.multi), ..attributes]
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Config
///
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-accordion",
    [boolean_attribute("multi", config.multi), ..attributes]
      |> filter(fn(a) { a != none() }),
    children,
  )
}
// --- PRIVATE INTERNAL HELPERS ---

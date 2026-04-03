//// chip_set provides Lustre support for the [M3E Chip Set component](https://matraic.github.io/m3e/#/components/chip-set.html)

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/layout.{type Orientation, Vertical}

// --- Types ---

/// Chipset contains all the information for a ChipSet
/// 
/// ## Fields:
/// - vertical: Whether the element is oriented vertically
///
pub opaque type ChipSet {
  ChipSet(vertical: Orientation)
}

// --- CONFIGURATION ---

/// Config holds the configuration for a ChipSet
///  
pub type Config {
  Config(vertical: Orientation)
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(vertical: layout.default_orientation)
}

// --- CONSTRUCTORS ---

/// new creates a new ChipSet with default values
///
pub fn new() -> ChipSet {
  from_config(default_config())
}

/// from_config creates a ChipSet from a Config record
/// 
pub fn from_config(c: Config) -> ChipSet {
  ChipSet(vertical: c.vertical)
}

// --- SETTERS ---

/// vertical sets the `vertical` field
///
pub fn vertical(_: ChipSet, vertical: Orientation) -> ChipSet {
  ChipSet(vertical: vertical)
}

// --- RENDERING ---

/// render creates a Lustre Element from a ChipSet
///
pub fn render(
  s: ChipSet,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-chip-set",
    list.append(
      [
        helpers.boolean_attribute("vertical", s.vertical == Vertical),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != attribute.none() }),
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

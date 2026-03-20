//// toolbar provides Lustre support for the [M3E Toolbar component](https://matraic.github.io/m3e/#/components/toolbar.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/types.{type Orientation, Vertical, default_orientation}

// --- Types ---

/// Elevation specifies the elevation of the element
/// 
pub type Elevation {
  Raised
  Lowered
}

pub const default_elevation: Elevation = Lowered

/// Shape is the possible shape variants of a toolbar
/// 
pub type Shape {
  Rounded
  Square
}

pub const default_shape: Shape = Square

/// Toolbar provides Lustre support for the [M3E Toolbar component](https://matraic.github.io/m3e/#/components/toolbar.html)
///
/// ## Fields:
/// - elevated: Whether the toolbar is elevated
/// - shape: The shape of the toolbar
/// - variant: The appearance variant of the toolbar
/// - vertical: Whether the element is oriented vertically
///
pub opaque type Toolbar {
  Toolbar(
    elevated: Elevation,
    shape: Shape,
    variant: Variant,
    vertical: Orientation,
  )
}

/// Variant is the possible appearance variants of a toolbar
/// 
pub type Variant {
  Standard
  Vibrant
}

pub const default_variant: Variant = Standard

// --- CONFIGURATION ---

/// Config holds the configuration for a Toolbar
/// 
pub type Config {
  Config(
    elevated: Elevation,
    shape: Shape,
    variant: Variant,
    vertical: Orientation,
  )
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(
    elevated: default_elevation,
    shape: default_shape,
    variant: default_variant,
    vertical: default_orientation,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Toolbar
/// 
pub fn new() -> Toolbar {
  from_config(default_config())
}

/// from_config creates a Toolbar from a Config
///
pub fn from_config(config: Config) -> Toolbar {
  Toolbar(
    elevated: config.elevated,
    shape: config.shape,
    variant: config.variant,
    vertical: config.vertical,
  )
}

// --- SETTERS ---

/// elevated sets the elevated field
///
pub fn elevated(t: Toolbar, elevated: Elevation) -> Toolbar {
  Toolbar(..t, elevated: elevated)
}

/// shape sets the shape field
///
pub fn shape(t: Toolbar, shape: Shape) -> Toolbar {
  Toolbar(..t, shape: shape)
}

/// variant sets the variant field
///
pub fn variant(t: Toolbar, variant: Variant) -> Toolbar {
  Toolbar(..t, variant: variant)
}

/// vertical sets the vertical field
///
pub fn vertical(t: Toolbar, vertical: Orientation) -> Toolbar {
  Toolbar(..t, vertical: vertical)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Toolbar
///
/// ## Parameters:
/// - t: a Toolbar
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  t: Toolbar,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-toolbar",
    flatten([
      [
        boolean_attribute("elevated", t.elevated == Raised),
        attribute("shape", shape_to_string(t.shape)),
        attribute("variant", variant_to_string(t.variant)),
        boolean_attribute("vertical", t.vertical == Vertical),
      ],
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

fn shape_to_string(shape: Shape) -> String {
  case shape {
    Rounded -> "rounded"
    Square -> "square"
  }
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Standard -> "standard"
    Vibrant -> "vibrant"
  }
}

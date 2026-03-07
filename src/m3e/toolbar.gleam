//// toolbar provides Lustre support for the [M3E Toolbar component](https://matraic.github.io/m3e/#/components/toolbar.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

/// Shape is the possible shape variants of a toolbar
/// 
pub type Shape {
  Rounded
  Square
}

fn shape_to_string(shape: Shape) -> String {
  case shape {
    Rounded -> "rounded"
    Square -> "square"
  }
}

pub const default_shape: Shape = Square

/// Variant is the possible appearance variants of a toolbar
/// 
pub type Variant {
  Standard
  Vibrant
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Standard -> "standard"
    Vibrant -> "vibrant"
  }
}

pub const default_variant: Variant = Standard

//  * @attr elevated - Whether the toolbar is elevated.
//  * @attr shape - The shape of the toolbar.
//  * @attr variant - The appearance variant of the toolbar.
//  * @attr vertical - Whether the element is oriented vertically.

/// Toolbar provides Lustre support for the [M3E Toolbar component](https://matraic.github.io/m3e/#/components/toolbar.html)
///
/// ## Fields:
/// - elevated: Whether the toolbar is elevated
/// - shape: The shape of the toolbar
/// - variant: The appearance variant of the toolbar
/// - vertical: Whether the element is oriented vertically
///
pub opaque type Toolbar {
  Toolbar(elevated: Bool, shape: Shape, variant: Variant, vertical: Bool)
}

/// new creates a new Toolbar
/// 
pub fn new() -> Toolbar {
  Toolbar(
    elevated: False,
    shape: default_shape,
    variant: default_variant,
    vertical: False,
  )
}

/// elevated sets the elevated field
///
pub fn elevated(t: Toolbar, elevated: Bool) -> Toolbar {
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
pub fn vertical(t: Toolbar, vertical: Bool) -> Toolbar {
  Toolbar(..t, vertical: vertical)
}

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
        boolean_attribute("elevated", t.elevated),
        attribute("shape", shape_to_string(t.shape)),
        attribute("variant", variant_to_string(t.variant)),
        boolean_attribute("vertical", t.vertical),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

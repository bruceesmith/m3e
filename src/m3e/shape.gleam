//// shape provides Lustre support for the [M3E Shape component](https://matraic.github.io/m3e/#/components/shape.html)

import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

// ---Types ---

/// Shape provides Lustre support for the [M3E Shape component](https://matraic.github.io/m3e/#/components/shape.html)
/// 
/// ## Fields:
/// - name: The name of the shape
///
pub opaque type Shape {
  Shape(name: String)
}

// --- CONSTRUCTORS ---

/// new creates a new Shape
///
pub fn new(name: String) -> Shape {
  Shape(name: name)
}

// --- SETTERS ---

/// name sets the name field
/// 
pub fn name(_: Shape, name: String) -> Shape {
  Shape(name: name)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Shape
/// 
pub fn render(s: Shape, attributes: List(Attribute(msg))) -> Element(msg) {
  element.element(
    "m3e-shape",
    [attribute.attribute("name", s.name), ..attributes]
      |> list.filter(fn(a) { a != attribute.none() }),
    [],
  )
}

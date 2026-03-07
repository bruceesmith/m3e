//// toc provides Lustre support for the [M3E Toc component](https://matraic.github.io/m3e/#/components/toc.html)

import gleam/int.{to_string}
import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

/// Toc provides Lustre support for the [M3E Toc component](https://matraic.github.io/m3e/#/components/toc.html)
/// 
/// ## Fields:
/// - for: The identifier of the interactive control to which this element is attached
/// - max_depth: The maximum depth of the table of contents
///
pub opaque type Toc {
  Toc(for: String, max_depth: Int)
}

/// new creates a new Toc 
/// 
pub fn new(for: String) -> Toc {
  Toc(for: for, max_depth: 0)
}

/// for sets the for field
/// 
pub fn for(t: Toc, for: String) -> Toc {
  Toc(..t, for: for)
}

/// max_depth sets the max_depth field
///
pub fn max_depth(t: Toc, max_depth: Int) -> Toc {
  Toc(..t, max_depth: max_depth)
}

/// render creates a Lustre Element(msg) from a Toc
///
/// ## Parameters:
/// - t: a Toc
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  t: Toc,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-toc",
    flatten([
      [
        attribute("for", t.for),
        attribute("max-depth", to_string(t.max_depth)),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

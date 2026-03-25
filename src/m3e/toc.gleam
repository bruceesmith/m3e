//// toc provides Lustre support for the [M3E Toc component](https://matraic.github.io/m3e/#/components/toc.html)

import gleam/int
import gleam/list

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}

// --- Types ---

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Overline
  // Renders the overline of the table of contents 
  Title
  // Renders the title of the table of contents
}

/// Toc provides Lustre support for the [M3E Toc component](https://matraic.github.io/m3e/#/components/toc.html)
/// 
/// ## Fields:
/// - for: The identifier of the interactive control to which this element is attached
/// - max_depth: The maximum depth of the table of contents
///
pub opaque type Toc {
  Toc(for: String, max_depth: Int)
}

// --- CONSTRUCTORS ---

/// new creates a new Toc 
/// 
pub fn new(for: String) -> Toc {
  Toc(for: for, max_depth: 0)
}

// --- SETTERS ---

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

// --- RENDERING ---

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
  element.element(
    "m3e-toc",
    list.flatten([
      [
        attribute("for", t.for),
        attribute("max-depth", int.to_string(t.max_depth)),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Overline -> attribute("slot", "overline")
    Title -> attribute("slot", "title")
  }
}

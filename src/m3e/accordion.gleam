//// accordion provides Lustre support for the [M3E Accordion component](https://matraic.github.io/m3e/#/components/expansion-panel.html)

import gleam/list.{filter}
import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}
import m3e/helpers.{boolean_attribute}

/// Accordion is a container for Expansion Panels
///
/// ## Fields:
/// - multi: Whether multiple panels can be expanded at the same time
///
pub opaque type Accordion {
  Accordion(multi: Bool)
}

/// new creates a new Accordion
///
pub fn new() -> Accordion {
  Accordion(multi: False)
}

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

/// multi sets the `multi` field
///
pub fn multi(_: Accordion, multi: Bool) -> Accordion {
  Accordion(multi: multi)
}

//// slide_group provides Lustre support for the [M3E Slide Group component](https://matraic.github.io/m3e/#/components/slide_group.html)

import gleam/int.{to_string}
import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

/// SlideGroup provides Lustre support for the [M3E Slide Group component](https://matraic.github.io/m3e/#/components/slide_group.html)
/// 
/// ## Fields:
/// - disabled: Whether scroll buttons are disabled
/// - next_page_label: The accessible label given to the button used to move to the previous page
/// - previous-page-label: The accessible label given to the button used to move to the next page
/// - threshold: A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls
/// - vertical: Whether content is oriented vertically
///
pub opaque type SlideGroup {
  SlideGroup(
    disabled: Bool,
    next_page_label: String,
    previous_page_label: String,
    threshold: Int,
    vertical: Bool,
  )
}

/// new creates a new SlideGroup
/// 
pub fn new() -> SlideGroup {
  SlideGroup(
    disabled: False,
    next_page_label: "Next page",
    previous_page_label: "Previous page",
    threshold: 0,
    vertical: False,
  )
}

/// disabled sets the disabled field
/// 
pub fn disabled(s: SlideGroup, disabled: Bool) -> SlideGroup {
  SlideGroup(..s, disabled: disabled)
}

/// next_page_label sets the next_page_label field
/// 
pub fn next_page_label(s: SlideGroup, next_page_label: String) -> SlideGroup {
  SlideGroup(..s, next_page_label: next_page_label)
}

/// previous_page_label sets the previous_page_label field
/// 
pub fn previous_page_label(
  s: SlideGroup,
  previous_page_label: String,
) -> SlideGroup {
  SlideGroup(..s, previous_page_label: previous_page_label)
}

/// threshold sets the threshold field
/// 
pub fn threshold(s: SlideGroup, threshold: Int) -> SlideGroup {
  SlideGroup(..s, threshold: threshold)
}

/// vertical sets the vertical field
/// 
pub fn vertical(s: SlideGroup, vertical: Bool) -> SlideGroup {
  SlideGroup(..s, vertical: vertical)
}

/// render creates a Lustre Element(msg) from a SlideGroup
/// 
/// ## Parameters:
/// - s: a SlideGroup
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  s: SlideGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-slide-group",
    flatten([
      [
        boolean_attribute("disabled", s.disabled),
        attribute("next-page-label", s.next_page_label),
        attribute("previous-page-label", s.previous_page_label),
        attribute("threshold", to_string(s.threshold)),
        boolean_attribute("vertical", s.vertical),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

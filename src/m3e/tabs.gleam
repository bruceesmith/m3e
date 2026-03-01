//// tab provides Lustre support for the [M3E Tab component](https://matraic.github.io/m3e/#/components/tabs.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

/// HeaderPosition is the position of the tab headers
/// 
pub type HeaderPosition {
  After
  Before
}

fn header_position_to_string(header_position: HeaderPosition) -> String {
  case header_position {
    After -> "after"
    Before -> "before"
  }
}

pub const default_header_position: HeaderPosition = Before

pub const default_next_page_label: String = "Next page"

pub const default_previous_page_label: String = "Previous page"

/// Variant is the appearance variant of the tabs
/// 
pub type Variant {
  Primary
  Secondary
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Primary -> "primary"
    Secondary -> "secondary"
  }
}

pub const default_variant: Variant = Secondary

/// Tabs
/// Tab provides Lustre support for the [M3E Tab component](https://matraic.github.io/m3e/#/components/tabs.html)
/// 
/// ## Fields:
/// - disabled_pagination: Whether scroll buttons are disabled
/// - header_position: The position of the tab headers
/// - next_page_label: The accessible label given to the button used to move to the previous page
/// - previous_page_label: The accessible label given to the button used to move to the next page
/// - stretch: Whether tabs are stretched to fill the header
/// - variant: The appearance variant of the tabs
///
pub opaque type Tabs {
  Tabs(
    disabled_pagination: Bool,
    header_position: HeaderPosition,
    next_page_label: String,
    previous_page_label: String,
    stretch: Bool,
    variant: String,
  )
}

/// new creates a new Tabs 
/// 
pub fn new() -> Tabs {
  Tabs(
    disabled_pagination: False,
    header_position: default_header_position,
    next_page_label: default_next_page_label,
    previous_page_label: default_previous_page_label,
    stretch: False,
    variant: variant_to_string(default_variant),
  )
}

/// disabled_pagination sets the disabled_pagination field
/// 
pub fn disabled_pagination(t: Tabs, disabled_pagination: Bool) -> Tabs {
  Tabs(..t, disabled_pagination: disabled_pagination)
}

/// header_position sets the header_position field
/// 
pub fn header_position(t: Tabs, header_position: HeaderPosition) -> Tabs {
  Tabs(..t, header_position: header_position)
}

/// next_page_label sets the next_page_label field
/// 
pub fn next_page_label(t: Tabs, next_page_label: String) -> Tabs {
  Tabs(..t, next_page_label: next_page_label)
}

/// previous_page_label sets the previous_page_label field
///
pub fn previous_page_label(t: Tabs, previous_page_label: String) -> Tabs {
  Tabs(..t, previous_page_label: previous_page_label)
}

/// stretch sets the stretch field
/// 
pub fn stretch(t: Tabs, stretch: Bool) -> Tabs {
  Tabs(..t, stretch: stretch)
}

/// variant sets the variant field
/// 
pub fn variant(t: Tabs, variant: Variant) -> Tabs {
  Tabs(..t, variant: variant_to_string(variant))
}

/// render creates a Lustre Element(msg) from a Tabs
/// 
/// ## Parameters:
/// - t: a Tabs
/// - attributes: additional attributes
/// - children: additional children
/// 
pub fn render(
  t: Tabs,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-tabs",
    flatten([
      [
        boolean_attribute("disabled-pagination", t.disabled_pagination),
        attribute(
          "header-position",
          header_position_to_string(t.header_position),
        ),
        attribute("next-page-label", t.next_page_label),
        attribute("previous-page-label", t.previous_page_label),
        boolean_attribute("stretch", t.stretch),
        attribute("variant", t.variant),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

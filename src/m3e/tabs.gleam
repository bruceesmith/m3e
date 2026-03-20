//// tab provides Lustre support for the [M3E Tab component](https://matraic.github.io/m3e/#/components/tabs.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// HeaderPosition is the position of the tab headers
/// 
pub type HeaderPosition {
  After
  Before
}

pub const default_header_position: HeaderPosition = Before

pub const default_next_page_label: String = "Next page"

pub const default_previous_page_label: String = "Previous page"

/// ScrollButtons is whether scroll buttons are disabled, defining the disable-pagination attribute
/// 
pub type ScrollButtons {
  Scroll
  NoScroll
}

pub const default_scroll_buttons: ScrollButtons = Scroll

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  NextIcon
  // Renders the icon to present for the next button used to paginate 
  Panel
  // Renders the panels of the tabs 
  PrevIcon
  // Renders the icon to present for the previous button used to paginate
}

/// Stretch defines whether tabs are stretched to fill the header
/// 
pub type Stretch {
  Stretch
  NoStretch
}

pub const default_stretch: Stretch = NoStretch

/// Tabs provides a structured navigation surface for organizing content into distinct views, where only one view is visible at a time
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
    disabled_pagination: ScrollButtons,
    header_position: HeaderPosition,
    next_page_label: String,
    previous_page_label: String,
    stretch: Stretch,
    variant: Variant,
  )
}

/// Variant is the appearance variant of the tabs
/// 
pub type Variant {
  Primary
  Secondary
}

pub const default_variant: Variant = Secondary

// --- CONFIGURATION ---

/// Config holds the configuration for a Tabs
/// 
pub type Config {
  Config(
    disabled_pagination: ScrollButtons,
    header_position: HeaderPosition,
    next_page_label: String,
    previous_page_label: String,
    stretch: Stretch,
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(
    disabled_pagination: default_scroll_buttons,
    header_position: default_header_position,
    next_page_label: default_next_page_label,
    previous_page_label: default_previous_page_label,
    stretch: default_stretch,
    variant: default_variant,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Tabs 
/// 
pub fn new() -> Tabs {
  from_config(default_config())
}

/// from_config creates a Tabs from a Config
///
pub fn from_config(config: Config) -> Tabs {
  Tabs(
    disabled_pagination: config.disabled_pagination,
    header_position: config.header_position,
    next_page_label: config.next_page_label,
    previous_page_label: config.previous_page_label,
    stretch: config.stretch,
    variant: config.variant,
  )
}

// --- SETTERS ---

/// disabled_pagination sets the disabled_pagination field
/// 
pub fn disabled_pagination(t: Tabs, disabled_pagination: ScrollButtons) -> Tabs {
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
pub fn stretch(t: Tabs, stretch: Stretch) -> Tabs {
  Tabs(..t, stretch: stretch)
}

/// variant sets the variant field
/// 
pub fn variant(t: Tabs, variant: Variant) -> Tabs {
  Tabs(..t, variant: variant)
}

// --- RENDERING ---

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
        boolean_attribute(
          "disabled-pagination",
          t.disabled_pagination == NoScroll,
        ),
        attribute(
          "header-position",
          header_position_to_string(t.header_position),
        ),
        attribute("next-page-label", t.next_page_label),
        attribute("previous-page-label", t.previous_page_label),
        boolean_attribute("stretch", t.stretch == Stretch),
        attribute("variant", variant_to_string(t.variant)),
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

// --- ATTRIBUTES ---

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    NextIcon -> attribute("slot", "next-icon")
    Panel -> attribute("slot", "panel")
    PrevIcon -> attribute("slot", "prev-icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn header_position_to_string(header_position: HeaderPosition) -> String {
  case header_position {
    After -> "after"
    Before -> "before"
  }
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Primary -> "primary"
    Secondary -> "secondary"
  }
}

//// Tabs is organizes content into separate views where only one view can be visible at a time.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/tab_header_position.{type TabHeaderPosition}
import m3e/tab_variant.{type TabVariant}

// --- Types ---

/// Tabs is a View Model for this component
///
/// ## Fields:
///
/// - disable_pagination: Whether scroll buttons are disabled.
/// - header_position: The position of the tab headers.
/// - next_page_label: The accessible label given to the button used to move to the next page.
/// - previous_page_label: The accessible label given to the button used to move to the previous page.
/// - stretch: Whether tabs are stretched to fill the header.
/// - variant: The appearance variant of the tabs.
///
pub opaque type Tabs {
  Tabs(
    disable_pagination: DisablePagination,
    header_position: TabHeaderPosition,
    next_page_label: String,
    previous_page_label: String,
    stretch: Stretch,
    variant: TabVariant,
  )
}

/// DisablePagination is whether scroll buttons are disabled.
///
pub type DisablePagination {
  IsDisablePagination
  IsNotDisablePagination
}

/// Stretch is whether tabs are stretched to fill the header.
///
pub type Stretch {
  IsStretch
  IsNotStretch
}

// --- Defaults ---

pub const default_disable_pagination: DisablePagination = IsNotDisablePagination

pub const default_header_position: TabHeaderPosition = tab_header_position.Before

pub const default_next_page_label: String = "Next page"

pub const default_previous_page_label: String = "Previous page"

pub const default_stretch: Stretch = IsNotStretch

pub const default_variant: TabVariant = tab_variant.Secondary

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Panel
  // Renders the panels of the tabs.
  NextIcon
  // Renders the icon to present for the next button used to paginate.
  PrevIcon
  // Renders the icon to present for the previous button used to paginate.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disable_pagination: DisablePagination,
    header_position: TabHeaderPosition,
    next_page_label: String,
    previous_page_label: String,
    stretch: Stretch,
    variant: TabVariant,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disable_pagination: IsNotDisablePagination,
    header_position: tab_header_position.Before,
    next_page_label: "Next page",
    previous_page_label: "Previous page",
    stretch: IsNotStretch,
    variant: tab_variant.Secondary,
  )
}

// --- Constructors ---

/// from_config creates a new Tabs from the given configuration.
///
pub fn from_config(config: Config) -> Tabs {
  Tabs(
    disable_pagination: config.disable_pagination,
    header_position: config.header_position,
    next_page_label: config.next_page_label,
    previous_page_label: config.previous_page_label,
    stretch: config.stretch,
    variant: config.variant,
  )
}

/// new creates a new Tabs with the default configuration.
///
pub fn new() -> Tabs {
  from_config(default_config())
}

// --- Setters ---

/// disable_pagination sets the value of disable_pagination for this Tabs.
///
pub fn disable_pagination(
  record: Tabs,
  disable_pagination: DisablePagination,
) -> Tabs {
  Tabs(..record, disable_pagination: disable_pagination)
}

/// header_position sets the value of header_position for this Tabs.
///
pub fn header_position(record: Tabs, header_position: TabHeaderPosition) -> Tabs {
  Tabs(..record, header_position: header_position)
}

/// next_page_label sets the value of next_page_label for this Tabs.
///
pub fn next_page_label(record: Tabs, next_page_label: String) -> Tabs {
  Tabs(..record, next_page_label: next_page_label)
}

/// previous_page_label sets the value of previous_page_label for this Tabs.
///
pub fn previous_page_label(record: Tabs, previous_page_label: String) -> Tabs {
  Tabs(..record, previous_page_label: previous_page_label)
}

/// stretch sets the value of stretch for this Tabs.
///
pub fn stretch(record: Tabs, stretch: Stretch) -> Tabs {
  Tabs(..record, stretch: stretch)
}

/// variant sets the value of variant for this Tabs.
///
pub fn variant(record: Tabs, variant: TabVariant) -> Tabs {
  Tabs(..record, variant: variant)
}

// --- Renderers ---

/// render creates a Lustre Element for a Tabs
///
pub fn render(
  model: Tabs,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-tabs",
    list.flatten([
      [
        attr.boolean(
          "disable-pagination",
          model.disable_pagination == IsDisablePagination,
        ),
        attr.with_default(
          "header-position",
          tab_header_position.to_string(model.header_position),
          tab_header_position.to_string(default_header_position),
        ),
        attr.with_default(
          "next-page-label",
          model.next_page_label,
          default_next_page_label,
        ),
        attr.with_default(
          "previous-page-label",
          model.previous_page_label,
          default_previous_page_label,
        ),
        attr.boolean("stretch", model.stretch == IsStretch),
        attr.with_default(
          "variant",
          tab_variant.to_string(model.variant),
          tab_variant.to_string(default_variant),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Tabs Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Panel -> attribute.attribute("slot", "panel")
    NextIcon -> attribute.attribute("slot", "next-icon")
    PrevIcon -> attribute.attribute("slot", "prev-icon")
  }
}

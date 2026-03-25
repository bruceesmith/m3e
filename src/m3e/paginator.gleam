//// paginator provides Lustre support for the [M3E Paginator component](https://matraic.github.io/m3e/#/components/paginator.html)

import gleam/int
import gleam/list
import gleam/string

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/form_field.{type Variant, Filled, Outlined}
import m3e/helpers
import m3e/state.{type Interaction, Disabled}

// --- TYPES ---

/// FirstLastButtonsVisibility specifies if first/last buttons are visible or hidden
pub type FirstLastButtonsVisibility {
  Shown
  Omitted
}

pub const default_first_last_buttons_visibility = Omitted

/// PageSize captures the semantics of the page-size attribute
/// 
pub type PageSize {
  PageSize(Int)
  PageSizeAll
}

pub const default_page_size = 50

pub const default_page_sizes = [
  PageSize(5),
  PageSize(10),
  PageSize(25),
  PageSize(50),
  PageSize(100),
]

/// PageSizeVisibility specifies if the page size selector is visible or hidden
pub type PageSizeVisibility {
  Visible
  Hidden
}

pub const default_page_size_visibility = Visible

/// Paginator provides Lustre support for the [M3E Paginator component](https://matraic.github.io/m3e/#/components/paginator.html)
/// 
/// ## Fields:
/// - interaction: Whether the element is enabled or disabled
/// - first_page_label: The accessible label given to the button used to move to the first page
/// - page_size_visibility: Whether to hide page size selection
/// - items_per_page_label: The label for the page size selector
/// - last_page_label: The accessible label given to the button used to move to the last page
/// - length: The length of the total number of items which are being paginated
/// - next_page_label: The accessible label given to the button used to move to the next page
/// - page_index: The zero-based page index of the displayed list of items
/// - page_size: The number of items to display in a page
/// - page_sizes: A comma separated list of available page sizes
/// - page_size_variant: The appearance variant of the page size
/// - previous_page_label: The accessible label given to the button used to move to the previous page
/// - first_last_buttons_visibility: Whether to show first/last buttons
///
pub opaque type Paginator {
  Paginator(
    interaction: Interaction,
    first_page_label: String,
    page_size_visibility: PageSizeVisibility,
    items_per_page_label: String,
    last_page_label: String,
    length: Int,
    next_page_label: String,
    page_index: Int,
    page_size: PageSize,
    page_sizes: List(PageSize),
    page_size_variant: Variant,
    previous_page_label: String,
    first_last_buttons_visibility: FirstLastButtonsVisibility,
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  FirstPageIcon
  // Slot for a custom first-page icon 
  LastPageIcon
  // Slot for a custom last-page icon 
  NextPageIcon
  // Slot for a custom next-page icon
  PreviousPageIcon
  // Slot for a custom previous-page icon 
}

// --- CONFIGURATION ---

/// Config holds the configuration for a Paginator
/// 
pub type Config {
  Config(
    interaction: Interaction,
    first_page_label: String,
    page_size_visibility: PageSizeVisibility,
    items_per_page_label: String,
    last_page_label: String,
    length: Int,
    next_page_label: String,
    page_index: Int,
    page_size: PageSize,
    page_sizes: List(PageSize),
    page_size_variant: Variant,
    previous_page_label: String,
    first_last_buttons_visibility: FirstLastButtonsVisibility,
  )
}

pub const default_first_page_label = "First page"

pub const default_items_per_page_label = "Items per page"

pub const default_last_page_label = "Last page"

pub const default_next_page_label = "Next page"

pub const default_previous_page_label = "Previous page"

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    interaction: state.default_interaction,
    first_page_label: "First page",
    page_size_visibility: default_page_size_visibility,
    items_per_page_label: "Items per page",
    last_page_label: "Last page",
    length: 0,
    next_page_label: "Next page",
    page_index: 0,
    page_size: PageSize(default_page_size),
    page_sizes: default_page_sizes,
    page_size_variant: form_field.default_variant,
    previous_page_label: "Previous page",
    first_last_buttons_visibility: Omitted,
  )
}

// --- CONSTRUCTORS ---

/// new creates a Paginator with default values
/// 
pub fn new() -> Paginator {
  from_config(default_config())
}

/// from_config creates a Paginator from a Config record
/// 
pub fn from_config(c: Config) -> Paginator {
  Paginator(
    interaction: c.interaction,
    first_page_label: c.first_page_label,
    page_size_visibility: c.page_size_visibility,
    items_per_page_label: c.items_per_page_label,
    last_page_label: c.last_page_label,
    length: c.length,
    next_page_label: c.next_page_label,
    page_index: c.page_index,
    page_size: c.page_size,
    page_sizes: c.page_sizes,
    page_size_variant: c.page_size_variant,
    previous_page_label: c.previous_page_label,
    first_last_buttons_visibility: c.first_last_buttons_visibility,
  )
}

// --- SETTERS ---

/// disabled sets the interaction field
/// 
pub fn disabled(p: Paginator, interaction: Interaction) -> Paginator {
  Paginator(..p, interaction: interaction)
}

/// first_page_label sets the first_page_label field
/// 
pub fn first_page_label(p: Paginator, first_page_label: String) -> Paginator {
  Paginator(..p, first_page_label: first_page_label)
}

/// hide_page_size sets the page_size_visibility field
/// 
pub fn hide_page_size(
  p: Paginator,
  page_size_visibility: PageSizeVisibility,
) -> Paginator {
  Paginator(..p, page_size_visibility: page_size_visibility)
}

/// items_per_page_label sets the items_per_page_label field
/// 
pub fn items_per_page_label(
  p: Paginator,
  items_per_page_label: String,
) -> Paginator {
  Paginator(..p, items_per_page_label: items_per_page_label)
}

/// last_page_label sets the last_page_label field
/// 
pub fn last_page_label(p: Paginator, last_page_label: String) -> Paginator {
  Paginator(..p, last_page_label: last_page_label)
}

/// length sets the length field
/// 
pub fn length(p: Paginator, length: Int) -> Paginator {
  Paginator(..p, length: length)
}

/// next_page_label sets the next_page_label field
/// 
pub fn next_page_label(p: Paginator, next_page_label: String) -> Paginator {
  Paginator(..p, next_page_label: next_page_label)
}

/// page_index sets the page_index field
/// 
pub fn page_index(p: Paginator, page_index: Int) -> Paginator {
  Paginator(..p, page_index: page_index)
}

/// page_size sets the page_size field
/// 
pub fn page_size(p: Paginator, page_size: PageSize) -> Paginator {
  Paginator(..p, page_size: page_size)
}

/// page_sizes sets the page_sizes field
/// 
pub fn page_sizes(p: Paginator, page_sizes: List(PageSize)) -> Paginator {
  Paginator(..p, page_sizes: page_sizes)
}

/// page_size_variant sets the page_size_variant field
///
pub fn page_size_variant(p: Paginator, page_size_variant: Variant) -> Paginator {
  Paginator(..p, page_size_variant: page_size_variant)
}

/// previous_page_label sets the previous_page_label field
/// 
pub fn previous_page_label(
  p: Paginator,
  previous_page_label: String,
) -> Paginator {
  Paginator(..p, previous_page_label: previous_page_label)
}

/// show_first_last_buttons sets the first_last_buttons_visibility field
/// 
pub fn show_first_last_buttons(
  p: Paginator,
  first_last_buttons_visibility: FirstLastButtonsVisibility,
) -> Paginator {
  Paginator(..p, first_last_buttons_visibility: first_last_buttons_visibility)
}

// --- RENDERING ---

/// render creates a Lustre Element from a Paginator
/// 
/// ## Parameters:
/// - p: a Paginator
/// - attributes: a list of additional attributes
/// - children: a list of child Elements
///
pub fn render(
  p: Paginator,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-paginator",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", p.interaction == Disabled),
        attribute.attribute("first-page-label", p.first_page_label),
        helpers.boolean_attribute(
          "hide-page-size",
          p.page_size_visibility == Hidden,
        ),
        attribute.attribute("items-per-page-label", p.items_per_page_label),
        attribute.attribute("last-page-label", p.last_page_label),
        attribute.attribute("length", int.to_string(p.length)),
        attribute.attribute("next-page-label", p.next_page_label),
        attribute.attribute("page-index", int.to_string(p.page_index)),
        attribute.attribute("page-size", page_size_to_string(p.page_size)),
        attribute.attribute(
          "page-sizes",
          string.join(list.map(p.page_sizes, page_size_to_string), ","),
        ),
        attribute.attribute(
          "page-size-variant",
          variant_to_string(p.page_size_variant),
        ),
        attribute.attribute("previous-page-label", p.previous_page_label),
        helpers.boolean_attribute(
          "show-first-last-buttons",
          p.first_last_buttons_visibility == Shown,
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
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

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    FirstPageIcon -> attribute.attribute("slot", "first-page-icon")
    LastPageIcon -> attribute.attribute("slot", "last-page-icon")
    NextPageIcon -> attribute.attribute("slot", "next-page-icon")
    PreviousPageIcon -> attribute.attribute("slot", "previous-page-icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn page_size_to_string(p: PageSize) -> String {
  case p {
    PageSize(i) -> int.to_string(i)
    PageSizeAll -> "all"
  }
}

/// variant_to_string converts a Variant to a string
/// 
fn variant_to_string(v: Variant) -> String {
  case v {
    Filled -> "filled"
    Outlined -> "outlined"
  }
}

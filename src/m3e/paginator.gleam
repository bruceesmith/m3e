//// paginator provides Lustre support for the [M3E Paginator component](https://matraic.github.io/m3e/#/components/paginator.html)

import gleam/int.{to_string}
import gleam/list.{filter, flatten}
import gleam/string.{join}

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

import m3e/form_field.{type Variant, default_variant, variant_to_string}
import m3e/helpers.{boolean_attribute}

/// PageSize captures the semantics of the page-size attribute
/// 
pub type PageSize {
  PageSize(Int)
  PageSizeAll
}

fn page_size_to_string(p: PageSize) -> String {
  case p {
    PageSize(i) -> to_string(i)
    PageSizeAll -> "all"
  }
}

pub const default_page_size = 50

pub const default_page_sizes = [
  PageSize(5),
  PageSize(10),
  PageSize(25),
  PageSize(50),
  PageSize(100),
]

/// Paginator provides Lustre support for the [M3E Paginator component](https://matraic.github.io/m3e/#/components/paginator.html)
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - first_page_label: The accessible label given to the button used to move to the first page
/// - hide_page_size: Whether to hide page size selection
/// - items_per_page_label: The label for the page size selector
/// - last_page_label: The accessible label given to the button used to move to the last page
/// - length: The length of the total number of items which are being paginated
/// - next_page_label: The accessible label given to the button used to move to the next page
/// - page_index: The zero-based page index of the displayed list of items
/// - page_size: The number of items to display in a page
/// - page_sizes: A comma separated list of available page sizes
/// - page_size_variant: The appearance variant of the page size
/// - previous_page_label: The accessible label given to the button used to move to the previous page
/// - show_first_last_buttons: Whether to show first/last buttons
///
pub opaque type Paginator {
  Paginator(
    disabled: Bool,
    first_page_label: String,
    hide_page_size: Bool,
    items_per_page_label: String,
    last_page_label: String,
    length: Int,
    next_page_label: String,
    page_index: Int,
    page_size: PageSize,
    page_sizes: List(PageSize),
    page_size_variant: Variant,
    previous_page_label: String,
    show_first_last_buttons: Bool,
  )
}

/// new creates a Paginator with default values
/// 
pub fn new() -> Paginator {
  Paginator(
    False,
    "First page",
    False,
    "Items per page",
    "Last page",
    0,
    "Next page",
    0,
    PageSize(default_page_size),
    default_page_sizes,
    default_variant,
    "Previous page",
    False,
  )
}

/// disabled sets the disabled attribute of a Paginator
/// 
pub fn disabled(p: Paginator, disabled: Bool) -> Paginator {
  Paginator(..p, disabled: disabled)
}

/// first_page_label sets the first-page-label attribute of a Paginator
/// 
pub fn first_page_label(p: Paginator, first_page_label: String) -> Paginator {
  Paginator(..p, first_page_label: first_page_label)
}

/// hide_page_size sets the hide-page-size attribute of a Paginator
/// 
pub fn hide_page_size(p: Paginator, hide_page_size: Bool) -> Paginator {
  Paginator(..p, hide_page_size: hide_page_size)
}

/// items_per_page_label sets the items-per-page-label attribute of a Paginator
/// 
pub fn items_per_page_label(
  p: Paginator,
  items_per_page_label: String,
) -> Paginator {
  Paginator(..p, items_per_page_label: items_per_page_label)
}

/// last_page_label sets the last-page-label attribute of a Paginator
/// 
pub fn last_page_label(p: Paginator, last_page_label: String) -> Paginator {
  Paginator(..p, last_page_label: last_page_label)
}

/// length sets the length attribute of a Paginator
/// 
pub fn length(p: Paginator, length: Int) -> Paginator {
  Paginator(..p, length: length)
}

/// next_page_label sets the next-page-label attribute of a Paginator
/// 
pub fn next_page_label(p: Paginator, next_page_label: String) -> Paginator {
  Paginator(..p, next_page_label: next_page_label)
}

/// page_index sets the page-index attribute of a Paginator
/// 
pub fn page_index(p: Paginator, page_index: Int) -> Paginator {
  Paginator(..p, page_index: page_index)
}

/// page_size sets the page-size attribute of a Paginator
/// 
pub fn page_size(p: Paginator, page_size: PageSize) -> Paginator {
  Paginator(..p, page_size: page_size)
}

/// page_sizes sets the page-sizes attribute of a Paginator
/// 
pub fn page_sizes(p: Paginator, page_sizes: List(PageSize)) -> Paginator {
  Paginator(..p, page_sizes: page_sizes)
}

/// page_size_variant sets the page-size-variant attribute of a Paginator
///
pub fn page_size_variant(p: Paginator, page_size_variant: Variant) -> Paginator {
  Paginator(..p, page_size_variant: page_size_variant)
}

/// previous_page_label sets the previous-page-label attribute of a Paginator
/// 
pub fn previous_page_label(
  p: Paginator,
  previous_page_label: String,
) -> Paginator {
  Paginator(..p, previous_page_label: previous_page_label)
}

/// show_first_last_buttons sets the show-first-last-buttons attribute of a Paginator
/// 
pub fn show_first_last_buttons(
  p: Paginator,
  show_first_last_buttons: Bool,
) -> Paginator {
  Paginator(..p, show_first_last_buttons: show_first_last_buttons)
}

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
  element(
    "m3e-paginator",
    flatten([
      [
        boolean_attribute("disabled", p.disabled),
        attribute("first-page-label", p.first_page_label),
        boolean_attribute("hide-page-size", p.hide_page_size),
        attribute("items-per-page-label", p.items_per_page_label),
        attribute("last-page-label", p.last_page_label),
        attribute("length", to_string(p.length)),
        attribute("next-page-label", p.next_page_label),
        attribute("page-index", to_string(p.page_index)),
        attribute("page-size", page_size_to_string(p.page_size)),
        attribute(
          "page-sizes",
          join(list.map(p.page_sizes, page_size_to_string), ","),
        ),
        attribute("page-size-variant", variant_to_string(p.page_size_variant)),
        attribute("previous-page-label", p.previous_page_label),
        boolean_attribute("show-first-last-buttons", p.show_first_last_buttons),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != attribute.none() }),
    children,
  )
}

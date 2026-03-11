//// nav_item provides Lustre support for the [M3E Nav Item component](https://matraic.github.io/m3e/#/components/nav-bar.html)

import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/link.{type Link}

// --- Types ---

/// NavItem provides Lustre support for the [M3E Nav Item component](https://matraic.github.io/m3e/#/components/nav-bar.html)
/// 
/// ## Fields:
/// - disabled - A value indicating whether the element is disabled.
/// - disabled-interactive - A value indicating whether the element is disabled and interactive.
/// - link: all the attributes of an HTML link
/// - orientation - The layout orientation of the item.
/// - selected - A value indicating whether the element is selected.
/// 
pub opaque type NavItem {
  NavItem(
    disabled: Bool,
    disabled_interactive: Bool,
    link: Option(Link),
    orientation: Orientation,
    selected: Bool,
  )
}

/// Orientation is the layout orientation of the item
/// 
pub type Orientation {
  Horizontal
  Vertical
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders the icon of the item 
  SelectedIcon
  // Renders the icon of the item when selected
}

// --- CONSTRUCTORS ---

/// new creates a new NavItem
/// 
pub fn new() -> NavItem {
  NavItem(
    disabled: False,
    disabled_interactive: False,
    link: None,
    orientation: Vertical,
    selected: False,
  )
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(item: NavItem, disabled: Bool) -> NavItem {
  NavItem(..item, disabled: disabled)
}

/// disabled_interactive sets the disabled_interactive field
/// 
pub fn disabled_interactive(
  item: NavItem,
  disabled_interactive: Bool,
) -> NavItem {
  NavItem(..item, disabled_interactive: disabled_interactive)
}

/// link sets the link field
/// 
pub fn link(item: NavItem, link: Option(Link)) -> NavItem {
  NavItem(..item, link: link)
}

/// orientation sets the orientation field
/// 
pub fn orientation(item: NavItem, orientation: Orientation) -> NavItem {
  NavItem(..item, orientation: orientation)
}

/// selected sets the selected field
/// 
pub fn selected(item: NavItem, selected: Bool) -> NavItem {
  NavItem(..item, selected: selected)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a NavItem
/// 
/// ## Parameters:
/// - item: a NavItem
/// - attributes: additional attributes
/// 
pub fn render(
  item: NavItem,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-nav-item",
    flatten([
      [
        boolean_attribute("disabled", item.disabled),
        boolean_attribute("disabled-interactive", item.disabled_interactive),
        boolean_attribute("selected", item.selected),
        attribute("orientation", orientation_to_string(item.orientation)),
      ],
      link.attributes(item.link),
      attributes,
    ])
      |> filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Icon -> attribute("slot", "icon")
    SelectedIcon -> attribute("slot", "selected-icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn orientation_to_string(orientation: Orientation) -> String {
  case orientation {
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
}

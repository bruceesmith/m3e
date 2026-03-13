//// expandable_list_item provides Lustre support for the [M3E Expandable List Item component](https://matraic.github.io/m3e/#/components/list.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// ExpandableListItem provides a hierarchical navigation structure that allows users to expand and collapse content sections
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - open: Whether the item is expanded
///
pub opaque type ExpandableListItem {
  ExpandableListItem(disabled: Bool, open: Bool)
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Items
  // Container for child list items displayed when expanded 
  Leading
  // Renders the leading content of the list item 
  Overline
  // Renders the overline of the list item 
  SupportingText
  // Renders the supporting text of the list item 
  ToggleIcon
  // Renders a custom icon for the expand/collapse toggle 
  Trailing
  // This component does not expose the base trailing slot   
}

// --- CONFIGURATION ---

/// Config is the configuration of an ExpandableListItem
///
pub type Config {
  Config(disabled: Bool, open: Bool)
}

/// default_config creates a Config with default values
///
pub fn default_config() -> Config {
  Config(disabled: False, open: False)
}

// --- CONSTRUCTORS ---

/// from_config creates an ExpandableListItem from a Config
///
/// ## Parameters:
/// - config: a Config
///
pub fn from_config(config: Config) -> ExpandableListItem {
  ExpandableListItem(disabled: config.disabled, open: config.open)
}

/// new creates an ExpandableListItem with default values
///
pub fn new() -> ExpandableListItem {
  ExpandableListItem(disabled: False, open: False)
}

// --- SETTERS ---

/// disabled sets the `disabled` field
///
pub fn disabled(e: ExpandableListItem, disabled: Bool) -> ExpandableListItem {
  ExpandableListItem(..e, disabled: disabled)
}

/// open sets the `open` field
///
pub fn open(e: ExpandableListItem, open: Bool) -> ExpandableListItem {
  ExpandableListItem(..e, open: open)
}

// --- RENDERING ---    

/// render creates a Lustre Element from an ExpandableListItem
///
/// ## Parameters:
/// - e: an ExpandableListItem
/// - attributes: a list of additional Attributes
/// - children: the main content
///
pub fn render(
  e: ExpandableListItem,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-expandable-list-item",
    flatten([
      [boolean_attribute("disabled", e.disabled)],
      [boolean_attribute("open", e.open)],
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

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Items -> attribute("slot", "items")
    Leading -> attribute("slot", "leading")
    Overline -> attribute("slot", "overline")
    SupportingText -> attribute("slot", "supporting-text")
    ToggleIcon -> attribute("slot", "toggle-icon")
    Trailing -> attribute("slot", "trailing")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

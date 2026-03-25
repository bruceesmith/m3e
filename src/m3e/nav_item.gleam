//// nav_item provides Lustre support for the [M3E Nav Item component](https://matraic.github.io/m3e/#/components/nav-bar.html)

import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/layout.{type Orientation, Vertical}
import m3e/link.{type Link}
import m3e/state.{type Interaction, type SelectionState, Disabled, Selected}

// --- Types ---

/// Focusability specifies if a disabled item is interactive (focusable)
pub type Focusability {
  Interactive
  Static
}

pub const default_focusability: Focusability = Static

/// NavItem provides Lustre support for the [M3E Nav Item component](https://matraic.github.io/m3e/#/components/nav-bar.html)
/// 
/// ## Fields:
/// - interaction: Whether the element is enabled or disabled.
/// - focusability: Whether the element is disabled and interactive.
/// - link: all the attributes of an HTML link
/// - orientation: The layout orientation of the item.
/// - selection: Whether the element is selected.
/// 
pub opaque type NavItem {
  NavItem(
    focusability: Focusability,
    interaction: Interaction,
    link: Option(Link),
    orientation: Orientation,
    selection: SelectionState,
  )
}

pub const default_orientation: Orientation = Vertical

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders the icon of the item 
  SelectedIcon
  // Renders the icon of the item when selected
}

// --- CONFIGURATION ---

/// Config holds the configuration for a NavItem
/// 
pub type Config {
  Config(
    focusability: Focusability,
    interaction: Interaction,
    link: Option(Link),
    orientation: Orientation,
    selection: SelectionState,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    focusability: default_focusability,
    interaction: state.default_interaction,
    link: None,
    orientation: default_orientation,
    selection: state.default_selection_state,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new NavItem
/// 
pub fn new() -> NavItem {
  from_config(default_config())
}

/// from_config creates a NavItem from a Config record
/// 
pub fn from_config(c: Config) -> NavItem {
  NavItem(
    focusability: c.focusability,
    interaction: c.interaction,
    link: c.link,
    orientation: c.orientation,
    selection: c.selection,
  )
}

// --- SETTERS ---

/// disabled sets the interaction field
/// 
pub fn disabled(item: NavItem, interaction: Interaction) -> NavItem {
  NavItem(..item, interaction: interaction)
}

/// disabled_interactive sets the focusability field
/// 
pub fn disabled_interactive(
  item: NavItem,
  focusability: Focusability,
) -> NavItem {
  NavItem(..item, focusability: focusability)
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

/// selected sets the selection field
/// 
pub fn selected(item: NavItem, selection: SelectionState) -> NavItem {
  NavItem(..item, selection: selection)
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
        boolean_attribute("disabled", item.interaction == Disabled),
        boolean_attribute(
          "disabled-interactive",
          item.focusability == Interactive,
        ),
        boolean_attribute("selected", item.selection == Selected),
        attribute("orientation", layout.orientation_to_string(item.orientation)),
      ],
      link.attributes(item.link),
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
    Icon -> attribute("slot", "icon")
    SelectedIcon -> attribute("slot", "selected-icon")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

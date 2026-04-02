//// nav_item provides Lustre support for the [M3E Nav Item component](https://matraic.github.io/m3e/#/components/nav-bar.html)

import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/layout.{type Orientation, Vertical}
import m3e/link.{type Link}
import m3e/state.{type SelectionState, Disabled, Selected}

// --- Types ---

/// NavItem provides Lustre support for the [M3E Nav Item component](https://matraic.github.io/m3e/#/components/nav-bar.html)
/// 
/// ## Fields:
/// - disabled: A value indicating whether the element is disabled
/// - disabled_interactive: A value indicating whether the element is disabled and interactive
/// - link: all the attributes of an HTML link
/// - orientation: The layout orientation of the item.
/// - selected: A value indicating whether the element is selected
/// 
pub opaque type NavItem {
  NavItem(
    disabled: state.Interaction,
    disabled_interactive: state.Interaction,
    link: Option(Link),
    orientation: Orientation,
    selected: SelectionState,
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
    disabled: state.Interaction,
    disabled_interactive: state.Interaction,
    link: Option(Link),
    orientation: Orientation,
    selected: SelectionState,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    disabled: state.default_interaction,
    disabled_interactive: state.default_interaction,
    link: None,
    orientation: default_orientation,
    selected: state.default_selection_state,
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
    disabled: c.disabled,
    disabled_interactive: c.disabled_interactive,
    link: c.link,
    orientation: c.orientation,
    selected: c.selected,
  )
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(item: NavItem, disabled: state.Interaction) -> NavItem {
  NavItem(..item, disabled: disabled)
}

/// disabled_interactive sets the focusability field
/// 
pub fn disabled_interactive(
  item: NavItem,
  disabled_interactive: state.Interaction,
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
pub fn selected(item: NavItem, selected: SelectionState) -> NavItem {
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
  element.element(
    "m3e-nav-item",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", item.disabled == Disabled),
        helpers.boolean_attribute(
          "disabled-interactive",
          item.disabled_interactive == Disabled,
        ),
        helpers.boolean_attribute("selected", item.selected == Selected),
        attribute.attribute(
          "orientation",
          layout.orientation_to_string(item.orientation),
        ),
      ],
      link.attributes(item.link),
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
    Icon -> attribute.attribute("slot", "icon")
    SelectedIcon -> attribute.attribute("slot", "selected-icon")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

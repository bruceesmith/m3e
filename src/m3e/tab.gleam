//// tab provides Lustre support for the [M3E Tab component](https://matraic.github.io/m3e/#/components/tabs.html)

import gleam/list

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}
import m3e/state.{type Interaction, Disabled, Enabled}

// --- Types ---

pub const default_interaction = Enabled

/// Whether the element is selected
pub type Selected {
  Selected
  NotSelected
}

pub const default_selected = NotSelected

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders an icon before the tab's label 
}

/// Tab provides one view within a structured navigation surface
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - for: The identifier of the interactive control to which this element is attached.
/// - selected: Whether the element is selected
/// 
pub opaque type Tab {
  Tab(disabled: Interaction, for: String, selected: Selected)
}

// --- CONFIGURATION ---

/// Config holds the configuration for a Tab
/// 
pub type Config {
  Config(disabled: Interaction, for: String, selected: Selected)
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(disabled: default_interaction, for: "", selected: default_selected)
}

// --- CONSTRUCTORS ---

/// new creates a new Tab
/// 
pub fn new() -> Tab {
  from_config(default_config())
}

/// from_config creates a Tab from a Config
///
pub fn from_config(config: Config) -> Tab {
  Tab(disabled: config.disabled, for: config.for, selected: config.selected)
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(t: Tab, disabled: Interaction) -> Tab {
  Tab(..t, disabled: disabled)
}

/// for sets the for field
/// 
pub fn for(t: Tab, for: String) -> Tab {
  Tab(..t, for: for)
}

/// selected sets the selected field
/// 
pub fn selected(t: Tab, selected: Selected) -> Tab {
  Tab(..t, selected: selected)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Tab
///
/// ## Parameters:
/// - t: a Tab
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  t: Tab,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-tab",
    list.flatten([
      [
        boolean_attribute("disabled", t.disabled == Disabled),
        attribute("for", t.for),
        boolean_attribute("selected", t.selected == Selected),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
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
    Icon -> attribute("slot", "icon")
  }
}
// --- PRIVATE INTERNAL HELPERS --- 

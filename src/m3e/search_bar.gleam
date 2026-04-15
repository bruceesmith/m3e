//// search_bar provides Lustre support for the M3E Search Bar component https://matraic.github.io/m3e/#/components/search.html

import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers

// --- Types ---

/// Clearing specifies whether the bar presents a button used to clear the search term.
///
pub type Clearing {
  Clearable
  NotClearable
}

pub const default_clearable = NotClearable

/// SearchBar is a  bar that provides a prominent entry point for search
///
/// ## Fields:
/// - clearable: Whether the bar presents a button used to clear the search term.
/// - clear_label: The accessible label given to the button used to clear the search term.
///
pub opaque type SearchBar {
  SearchBar(clearable: Clearing, clear_label: String)
}

pub const default_clear_label = "Clear"

/// Slot gives type-safe names to each of the defined HTML named slots
///
pub type Slot {
  Leading
  // Renders content before the input of the bar
  Input
  // Renders the input of the bar
  Trailing
  // Renders content after the input of the bar
}

// --- CONFIGURATION ---

/// Config is the configuration for a SearchBar
///
pub type Config {
  Config(clearable: Clearing, clear_label: String)
}

/// default_config returns the default configuration for a SearchBar
///
pub fn default_config() -> Config {
  Config(clearable: default_clearable, clear_label: default_clear_label)
}

// --- CONSTRUCTORS ---

/// from_config creates a SearchBar from a Config
///
pub fn from_config(config: Config) -> SearchBar {
  SearchBar(clearable: config.clearable, clear_label: config.clear_label)
}

/// new creates a new SearchBar with the default configuration
///
pub fn new() -> SearchBar {
  from_config(default_config())
}

// --- SETTERS ---

/// clearable sets whether the bar presents a button used to clear the search term.
///
pub fn clearable(sb: SearchBar, clearable: Clearing) -> SearchBar {
  SearchBar(..sb, clearable: clearable)
}

/// clear_label sets the accessible label given to the button used to clear the search term.
///
pub fn clear_label(sb: SearchBar, clear_label: String) -> SearchBar {
  SearchBar(..sb, clear_label: clear_label)
}

// --- RENDERING ---

/// render renders the search bar as a Lustre Element(msg).
///
pub fn render(
  sb: SearchBar,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-search-bar",
    list.flatten([
      [
        helpers.boolean_attribute("clearable", sb.clearable == Clearable),
        helpers.attribute_with_default(
          "clear-label",
          sb.clear_label,
          default_clear_label,
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element(msg) from a Config
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
    Leading -> attribute.attribute("slot", "leading")
    Input -> attribute.attribute("slot", "input")
    Trailing -> attribute.attribute("slot", "trailing")
  }
}

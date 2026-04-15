//// search_view provides Lustre support for the M3E Search View component https://matraic.github.io/m3e/#/components/search.html

import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers

// --- TYPES ---

/// Mode is the behavior mode of the search view
///
/// - `Auto`: The view expands to show results as the user types.
/// - `Docked`: The view is always visible, but results are hidden until the user expands it.
/// - `Fullscreen`: The view takes up the full screen and results are shown immediately.
///
pub type Mode {
  Auto
  Docked
  Fullscreen
}

pub const default_mode = Docked

/// Container specifies whether the view features a persistent, filled search container.
///
pub type Container {
  Contained
  Free
}

pub const default_contained = Free

/// Expansion specifies whether the view is expanded to show results.
///
pub type Expansion {
  Expanded
  Collapsed
}

pub const default_open = Collapsed

/// SearchIcon specifies whether to hide the search icon.
///
pub type SearchIcon {
  Visible
  Hidden
}

pub const default_search_icon = Visible

/// SearchView is a surface that presents suggestions and results for a search
///
/// ## Fields:
/// - contained: Whether the view features a persistent, filled search container.
/// - mode: The behavior mode of the view.
/// - open: Whether the view is expanded to show results.
/// - clear_label: The accessible label given to the button used to clear the search term.
/// - close_label: The accessible label given to the button used to collapse the view.
/// - hide_search_icon: Whether to hide the search icon.
///
pub opaque type SearchView {
  SearchView(
    contained: Container,
    mode: Mode,
    open: Expansion,
    clear_label: String,
    close_label: String,
    hide_search_icon: SearchIcon,
  )
}

pub const default_clear_label = "Clear"

pub const default_close_label = "Close"

/// Slot gives type-safe names to each of the defined HTML named slots
///
pub type Slot {
  Input
  // Renders the input of the view
  OpenLeading
  // When open, renders content before the input of the view
  OpenTrailing
  // When open, renders content after the input of the view
  ClosedLeading
  // When closed, renders content before the input of the view
  ClosedTrailing
  // When closed, renders content after the input of the view
}

// --- CONFIGURATION ---

/// Config is the configuration for a SearchView
///
pub type Config {
  Config(
    contained: Container,
    mode: Mode,
    open: Expansion,
    clear_label: String,
    close_label: String,
    hide_search_icon: SearchIcon,
  )
}

/// default_config returns the default configuration for a SearchView
///
pub fn default_config() -> Config {
  Config(
    contained: default_contained,
    mode: default_mode,
    open: default_open,
    clear_label: default_clear_label,
    close_label: default_close_label,
    hide_search_icon: default_search_icon,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a SearchView from a Config
///
pub fn from_config(config: Config) -> SearchView {
  SearchView(
    contained: config.contained,
    mode: config.mode,
    open: config.open,
    clear_label: config.clear_label,
    close_label: config.close_label,
    hide_search_icon: config.hide_search_icon,
  )
}

/// new creates a new SearchView with the default configuration
///
pub fn new() -> SearchView {
  from_config(default_config())
}

// --- SETTERS ---

/// contained sets the `contained` field
///
pub fn contained(view: SearchView, contained: Container) -> SearchView {
  SearchView(..view, contained: contained)
}

/// mode sets the `mode` field
///
pub fn mode(view: SearchView, mode: Mode) -> SearchView {
  SearchView(..view, mode: mode)
}

/// open sets the `open` field
///
pub fn open(view: SearchView, open: Expansion) -> SearchView {
  SearchView(..view, open: open)
}

/// clear_label sets the `clear_label` field
///
pub fn clear_label(view: SearchView, clear_label: String) -> SearchView {
  SearchView(..view, clear_label: clear_label)
}

/// close_label sets the `close_label` field
///
pub fn close_label(view: SearchView, close_label: String) -> SearchView {
  SearchView(..view, close_label: close_label)
}

/// hide_search_icon sets the `hide_search_icon` field
///
pub fn hide_search_icon(
  view: SearchView,
  hide_search_icon: SearchIcon,
) -> SearchView {
  SearchView(..view, hide_search_icon: hide_search_icon)
}

// --- RENDERING ---

/// render renders the SearchView as a Lustre Element(msg)
///
pub fn render(
  view: SearchView,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-search-view",
    list.flatten([
      [
        helpers.boolean_attribute("contained", view.contained == Contained),
        attribute.attribute("mode", mode_to_string(view.mode)),
        helpers.boolean_attribute("open", view.open == Expanded),
        helpers.attribute_with_default(
          "clear-label",
          view.clear_label,
          default_clear_label,
        ),
        helpers.attribute_with_default(
          "close-label",
          view.close_label,
          default_close_label,
        ),
        helpers.boolean_attribute(
          "hide-search-icon",
          view.hide_search_icon == Hidden,
        ),
      ],
      attrs,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element(msg) from a Config
///
pub fn render_config(
  config: Config,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attrs, children)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Input -> attribute.attribute("slot", "input")
    OpenLeading -> attribute.attribute("slot", "open-leading")
    OpenTrailing -> attribute.attribute("slot", "open-trailing")
    ClosedLeading -> attribute.attribute("slot", "closed-leading")
    ClosedTrailing -> attribute.attribute("slot", "closed-trailing")
  }
}

// --- PRIVATE HELPER FUNCTIONS ---

/// mode_to_string converts a Mode to a string suitable for use in the view's class attribute
///
fn mode_to_string(mode: Mode) -> String {
  case mode {
    Auto -> "auto"
    Docked -> "docked"
    Fullscreen -> "fullscreen"
  }
}

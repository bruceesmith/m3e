//// SearchView is a surface that presents suggestions and results for a search.
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
import m3e/search_view_mode.{type SearchViewMode}

// --- Types ---

/// SearchView is a View Model for this component
///
/// ## Fields:
///
/// - contained: Whether the view features a persistent, filled search container.
/// - mode: The behavior mode of the view.
/// - open: Whether the view is expanded to show results.
/// - clear_label: The accessible label given to the button used to clear the search term.
/// - close_label: The accessible label given to the button used to collapse the view.
/// - hide_search_icon: Whether to hide the search icon.
///
pub opaque type SearchView {
  SearchView(
    contained: Contained,
    mode: SearchViewMode,
    open: Open,
    clear_label: String,
    close_label: String,
    hide_search_icon: HideSearchIcon,
  )
}

/// Contained is whether the view features a persistent, filled search container.
///
pub type Contained {
  IsContained
  IsNotContained
}

/// Open is whether the view is expanded to show results.
///
pub type Open {
  IsOpen
  IsNotOpen
}

/// HideSearchIcon is whether to hide the search icon.
///
pub type HideSearchIcon {
  IsHideSearchIcon
  IsNotHideSearchIcon
}

// --- Defaults ---

pub const default_contained: Contained = IsNotContained

pub const default_mode: SearchViewMode = search_view_mode.Docked

pub const default_open: Open = IsNotOpen

pub const default_clear_label: String = "Clear"

pub const default_close_label: String = "Close"

pub const default_hide_search_icon: HideSearchIcon = IsNotHideSearchIcon

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Input
  // Renders the input of the view.
  OpenLeading
  // When open, renders content before the input of the view.
  OpenTrailing
  // When open, renders content after the input of the view.
  ClosedLeading
  // When closed, renders content before the input of the view.
  ClosedTrailing
  // When closed, renders content after the input of the view.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    contained: Contained,
    mode: SearchViewMode,
    open: Open,
    clear_label: String,
    close_label: String,
    hide_search_icon: HideSearchIcon,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    contained: IsNotContained,
    mode: search_view_mode.Docked,
    open: IsNotOpen,
    clear_label: "Clear",
    close_label: "Close",
    hide_search_icon: IsNotHideSearchIcon,
  )
}

// --- Constructors ---

/// from_config creates a new SearchView from the given configuration.
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

/// new creates a new SearchView with the default configuration.
///
pub fn new() -> SearchView {
  from_config(default_config())
}

// --- Setters ---

/// contained sets the value of contained for this SearchView.
///
pub fn contained(record: SearchView, contained: Contained) -> SearchView {
  SearchView(..record, contained: contained)
}

/// mode sets the value of mode for this SearchView.
///
pub fn mode(record: SearchView, mode: SearchViewMode) -> SearchView {
  SearchView(..record, mode: mode)
}

/// open sets the value of open for this SearchView.
///
pub fn open(record: SearchView, open: Open) -> SearchView {
  SearchView(..record, open: open)
}

/// clear_label sets the value of clear_label for this SearchView.
///
pub fn clear_label(record: SearchView, clear_label: String) -> SearchView {
  SearchView(..record, clear_label: clear_label)
}

/// close_label sets the value of close_label for this SearchView.
///
pub fn close_label(record: SearchView, close_label: String) -> SearchView {
  SearchView(..record, close_label: close_label)
}

/// hide_search_icon sets the value of hide_search_icon for this SearchView.
///
pub fn hide_search_icon(
  record: SearchView,
  hide_search_icon: HideSearchIcon,
) -> SearchView {
  SearchView(..record, hide_search_icon: hide_search_icon)
}

// --- Renderers ---

/// render creates a Lustre Element for a SearchView
///
pub fn render(
  model: SearchView,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-search-view",
    list.flatten([
      [
        attr.boolean("contained", model.contained == IsContained),
        attr.with_default(
          "mode",
          search_view_mode.to_string(model.mode),
          search_view_mode.to_string(default_mode),
        ),
        attr.boolean("open", model.open == IsOpen),
        attr.with_default("clear-label", model.clear_label, default_clear_label),
        attr.with_default("close-label", model.close_label, default_close_label),
        attr.boolean(
          "hide-search-icon",
          model.hide_search_icon == IsHideSearchIcon,
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a SearchView Config
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
    Input -> attribute.attribute("slot", "input")
    OpenLeading -> attribute.attribute("slot", "open-leading")
    OpenTrailing -> attribute.attribute("slot", "open-trailing")
    ClosedLeading -> attribute.attribute("slot", "closed-leading")
    ClosedTrailing -> attribute.attribute("slot", "closed-trailing")
  }
}

//// Autocomplete is enhances a text input with suggested options.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/autocomplete_filter_mode.{type AutocompleteFilterMode}

// --- Types ---

/// Autocomplete is a View Model for this component
///
/// ## Fields:
///
/// - auto_activate: Whether the first option should be automatically activated.
/// - case_sensitive: Whether filtering is case sensitive.
/// - filter: Mode in which to filter options.
/// - hide_selection_indicator: Whether to hide the selection indicator.
/// - hide_loading: Whether to hide the menu when loading options.
/// - hide_no_data: Whether to hide the menu when there are no options to show.
/// - loading: Whether options are being loaded.
/// - loading_label: The text announced and presented when loading options.
/// - no_data_label: The text announced and presented when no options are available for the current term.
/// - panel_class: Class or list of classes to be applied to the autocomplete's overlay panel.
/// - required: Whether the user is required to make a selection when interacting with the autocomplete.
/// - results_label: The text announced when available options change for the current term.
/// - for: The identifier of the interactive control to which this element is attached.
///
pub opaque type Autocomplete {
  Autocomplete(
    auto_activate: AutoActivate,
    case_sensitive: CaseSensitive,
    filter: AutocompleteFilterMode,
    hide_selection_indicator: HideSelectionIndicator,
    hide_loading: HideLoading,
    hide_no_data: HideNoData,
    loading: Loading,
    loading_label: String,
    no_data_label: String,
    panel_class: String,
    required: Required,
    results_label: String,
    for: Option(String),
  )
}

/// AutoActivate is whether the first option should be automatically activated.
///
pub type AutoActivate {
  IsAutoActivate
  IsNotAutoActivate
}

/// CaseSensitive is whether filtering is case sensitive.
///
pub type CaseSensitive {
  IsCaseSensitive
  IsNotCaseSensitive
}

/// HideSelectionIndicator is whether to hide the selection indicator.
///
pub type HideSelectionIndicator {
  IsHideSelectionIndicator
  IsNotHideSelectionIndicator
}

/// HideLoading is whether to hide the menu when loading options.
///
pub type HideLoading {
  IsHideLoading
  IsNotHideLoading
}

/// HideNoData is whether to hide the menu when there are no options to show.
///
pub type HideNoData {
  IsHideNoData
  IsNotHideNoData
}

/// Loading is whether options are being loaded.
///
pub type Loading {
  IsLoading
  IsNotLoading
}

/// Required is whether the user is required to make a selection when interacting with the autocomplete.
///
pub type Required {
  IsRequired
  IsNotRequired
}

// --- Defaults ---

pub const default_auto_activate: AutoActivate = IsNotAutoActivate

pub const default_case_sensitive: CaseSensitive = IsNotCaseSensitive

pub const default_filter: AutocompleteFilterMode = autocomplete_filter_mode.Contains

pub const default_hide_selection_indicator: HideSelectionIndicator = IsNotHideSelectionIndicator

pub const default_hide_loading: HideLoading = IsNotHideLoading

pub const default_hide_no_data: HideNoData = IsNotHideNoData

pub const default_loading: Loading = IsNotLoading

pub const default_loading_label: String = "Loading..."

pub const default_no_data_label: String = "No options"

pub const default_panel_class: String = ""

pub const default_required: Required = IsNotRequired

pub const default_results_label: String = ""

pub const default_for: Option(String) = None

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Loading
  // Renders content when loading options.
  NoData
  // Renders content when there are no options to show.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    auto_activate: AutoActivate,
    case_sensitive: CaseSensitive,
    filter: AutocompleteFilterMode,
    hide_selection_indicator: HideSelectionIndicator,
    hide_loading: HideLoading,
    hide_no_data: HideNoData,
    loading: Loading,
    loading_label: String,
    no_data_label: String,
    panel_class: String,
    required: Required,
    results_label: String,
    for: Option(String),
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    auto_activate: IsNotAutoActivate,
    case_sensitive: IsNotCaseSensitive,
    filter: autocomplete_filter_mode.Contains,
    hide_selection_indicator: IsNotHideSelectionIndicator,
    hide_loading: IsNotHideLoading,
    hide_no_data: IsNotHideNoData,
    loading: IsNotLoading,
    loading_label: "Loading...",
    no_data_label: "No options",
    panel_class: "",
    required: IsNotRequired,
    results_label: "",
    for: None,
  )
}

// --- Constructors ---

/// from_config creates a new Autocomplete from the given configuration.
///
pub fn from_config(config: Config) -> Autocomplete {
  Autocomplete(
    auto_activate: config.auto_activate,
    case_sensitive: config.case_sensitive,
    filter: config.filter,
    hide_selection_indicator: config.hide_selection_indicator,
    hide_loading: config.hide_loading,
    hide_no_data: config.hide_no_data,
    loading: config.loading,
    loading_label: config.loading_label,
    no_data_label: config.no_data_label,
    panel_class: config.panel_class,
    required: config.required,
    results_label: config.results_label,
    for: config.for,
  )
}

/// new creates a new Autocomplete with the default configuration.
///
pub fn new() -> Autocomplete {
  from_config(default_config())
}

// --- Setters ---

/// auto_activate sets the value of auto_activate for this Autocomplete.
///
pub fn auto_activate(
  record: Autocomplete,
  auto_activate: AutoActivate,
) -> Autocomplete {
  Autocomplete(..record, auto_activate: auto_activate)
}

/// case_sensitive sets the value of case_sensitive for this Autocomplete.
///
pub fn case_sensitive(
  record: Autocomplete,
  case_sensitive: CaseSensitive,
) -> Autocomplete {
  Autocomplete(..record, case_sensitive: case_sensitive)
}

/// filter sets the value of filter for this Autocomplete.
///
pub fn filter(
  record: Autocomplete,
  filter: AutocompleteFilterMode,
) -> Autocomplete {
  Autocomplete(..record, filter: filter)
}

/// hide_selection_indicator sets the value of hide_selection_indicator for this Autocomplete.
///
pub fn hide_selection_indicator(
  record: Autocomplete,
  hide_selection_indicator: HideSelectionIndicator,
) -> Autocomplete {
  Autocomplete(..record, hide_selection_indicator: hide_selection_indicator)
}

/// hide_loading sets the value of hide_loading for this Autocomplete.
///
pub fn hide_loading(
  record: Autocomplete,
  hide_loading: HideLoading,
) -> Autocomplete {
  Autocomplete(..record, hide_loading: hide_loading)
}

/// hide_no_data sets the value of hide_no_data for this Autocomplete.
///
pub fn hide_no_data(
  record: Autocomplete,
  hide_no_data: HideNoData,
) -> Autocomplete {
  Autocomplete(..record, hide_no_data: hide_no_data)
}

/// loading sets the value of loading for this Autocomplete.
///
pub fn loading(record: Autocomplete, loading: Loading) -> Autocomplete {
  Autocomplete(..record, loading: loading)
}

/// loading_label sets the value of loading_label for this Autocomplete.
///
pub fn loading_label(
  record: Autocomplete,
  loading_label: String,
) -> Autocomplete {
  Autocomplete(..record, loading_label: loading_label)
}

/// no_data_label sets the value of no_data_label for this Autocomplete.
///
pub fn no_data_label(
  record: Autocomplete,
  no_data_label: String,
) -> Autocomplete {
  Autocomplete(..record, no_data_label: no_data_label)
}

/// panel_class sets the value of panel_class for this Autocomplete.
///
pub fn panel_class(record: Autocomplete, panel_class: String) -> Autocomplete {
  Autocomplete(..record, panel_class: panel_class)
}

/// required sets the value of required for this Autocomplete.
///
pub fn required(record: Autocomplete, required: Required) -> Autocomplete {
  Autocomplete(..record, required: required)
}

/// results_label sets the value of results_label for this Autocomplete.
///
pub fn results_label(
  record: Autocomplete,
  results_label: String,
) -> Autocomplete {
  Autocomplete(..record, results_label: results_label)
}

/// for sets the value of for for this Autocomplete.
///
pub fn for(record: Autocomplete, for: Option(String)) -> Autocomplete {
  Autocomplete(..record, for: for)
}

// --- Renderers ---

/// render creates a Lustre Element for a Autocomplete
///
pub fn render(
  model: Autocomplete,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-autocomplete",
    list.flatten([
      [
        attr.boolean("auto-activate", model.auto_activate == IsAutoActivate),
        attr.boolean("case-sensitive", model.case_sensitive == IsCaseSensitive),
        attr.with_default(
          "filter",
          autocomplete_filter_mode.to_string(model.filter),
          autocomplete_filter_mode.to_string(default_filter),
        ),
        attr.boolean(
          "hide-selection-indicator",
          model.hide_selection_indicator == IsHideSelectionIndicator,
        ),
        attr.boolean("hide-loading", model.hide_loading == IsHideLoading),
        attr.boolean("hide-no-data", model.hide_no_data == IsHideNoData),
        attr.boolean("loading", model.loading == IsLoading),
        attr.with_default(
          "loading-label",
          model.loading_label,
          default_loading_label,
        ),
        attr.with_default(
          "no-data-label",
          model.no_data_label,
          default_no_data_label,
        ),
        attr.with_default("panel-class", model.panel_class, default_panel_class),
        attr.boolean("required", model.required == IsRequired),
        attr.with_default(
          "results-label",
          model.results_label,
          default_results_label,
        ),
        attr.option(model.for, fn(_) { "for" }, function.identity, default_for),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Autocomplete Config
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
    Loading -> attribute.attribute("slot", "loading")
    NoData -> attribute.attribute("slot", "no-data")
  }
}

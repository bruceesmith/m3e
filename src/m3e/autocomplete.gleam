//// autocomplete provides Lustre support for the [M3E Autocomplete component](https://matraic.github.io/m3e/#/components/autocomplete.html)
///// panel_class sets the panel_class field of an Autocomplete
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute
import lustre/element.{type Element}

import m3e/config.{
  type SelectionIndicator, HideSelectionIndicator, ShowSelectionIndicator,
}
import m3e/helpers
import m3e/option as m3eoption
import m3e/state.{type Requirement, Optional, Required}

// --- Types ---

/// Activation specifies if the first option should be automatically activated
/// 
pub type Activation {
  AutoActivate
  ManualActivate
}

pub const default_activation: Activation = ManualActivate

/// Autocomplete enhances an input field with a panel of suggested options
///
/// ## Fields:
/// - auto_activate: Whether the first option should be automatically activated
/// - case_sensitive: Whether filtering is case sensitive
/// - filter: Mode in which to filter options
/// - for: The identifier of the interactive control to which this element is attached
/// - hide_loading: Whether to hide the menu when loading options
/// - hide_no_data: Whether to hide the menu when there are no options to show
/// - hide_selection_indicator: Whether to hide the selection indicator
/// - loading: Whether options are being loaded
/// - loading_label: The text announced and presented when loading options
/// - no_data_label: The text announced and presented when no options are available for the current term
/// - panel_class: Class or list of classes to be applied to the autocomplete's overlay panel
/// - required: Whether the user is required to make a selection when interacting with the autocomplete
/// - results_label: The text announced when available options change for the current term
///
pub opaque type Autocomplete {
  Autocomplete(
    auto_activate: Activation,
    case_sensitive: CaseSensitivity,
    filter: FilterMode,
    for: String,
    hide_loading: LoadingVisibility,
    hide_no_data: EmptyMenuVisibility,
    hide_selection_indicator: SelectionIndicator,
    loading: LoadingStatus,
    loading_label: String,
    no_data_label: String,
    panel_class: Option(String),
    required: Requirement,
    results_label: String,
  )
}

/// CaseSensitivity specifies if the filtering should be case sensitive
pub type CaseSensitivity {
  CaseSensitive
  CaseInsensitive
}

pub const default_case_sensitivity: CaseSensitivity = CaseInsensitive

/// EmptyMenuVisibility specifies if the menu should be hidden when there are no options to show
pub type EmptyMenuVisibility {
  ShowEmptyMenu
  HideEmptyMenu
}

pub const default_empty_menu_visibility: EmptyMenuVisibility = ShowEmptyMenu

/// LoadingVisibility specifies if the loading indicator should be hidden or shown
pub type LoadingVisibility {
  ShowLoadingIndicator
  HideLoadingIndicator
}

pub const default_loading_visibility: LoadingVisibility = ShowLoadingIndicator

/// LoadingStatus specifies if the component is currently fetching or processing data
pub type LoadingStatus {
  Loading
  NotLoading
}

pub const default_loading_status: LoadingStatus = NotLoading

// type AutocompleteFilterMode = "contains" | "starts-with" | "ends-with" | "none"

/// FilterMode specifies how to filter options
/// 
pub type FilterMode {
  Contains
  StartsWith
  EndsWith
  NonFilter
}

pub const default_filter_mode: FilterMode = Contains

pub const default_loading_label = "Loading..."

pub const default_no_data_label = "No options"

// --- CONFIGURATION ---

/// Config holds the configuration for an Autocomplete
///
pub type Config {
  Config(
    auto_activate: Activation,
    filter: FilterMode,
    for: String,
    hide_loading: LoadingVisibility,
    case_sensitive: CaseSensitivity,
    hide_no_data: EmptyMenuVisibility,
    hide_selection_indicator: SelectionIndicator,
    loading: LoadingStatus,
    loading_label: String,
    no_data_label: String,
    panel_class: Option(String),
    required: Requirement,
    results_label: String,
  )
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(
    auto_activate: ManualActivate,
    filter: default_filter_mode,
    for: "",
    hide_loading: default_loading_visibility,
    case_sensitive: default_case_sensitivity,
    hide_no_data: default_empty_menu_visibility,
    hide_selection_indicator: ShowSelectionIndicator,
    loading: default_loading_status,
    loading_label: default_loading_label,
    panel_class: None,
    no_data_label: default_no_data_label,
    required: Optional,
    results_label: "",
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Autocomplete
///
pub fn new(for: String) -> Autocomplete {
  from_config(default_config())
  |> for_(for)
}

/// from_config creates an Autocomplete from a Config record
///
pub fn from_config(c: Config) -> Autocomplete {
  Autocomplete(
    auto_activate: c.auto_activate,
    filter: c.filter,
    for: c.for,
    hide_loading: c.hide_loading,
    case_sensitive: c.case_sensitive,
    hide_no_data: c.hide_no_data,
    hide_selection_indicator: c.hide_selection_indicator,
    loading: c.loading,
    loading_label: c.loading_label,
    no_data_label: c.no_data_label,
    panel_class: c.panel_class,
    required: c.required,
    results_label: c.results_label,
  )
}

// --- SETTERS ---

/// auto_activate sets the auto_activate field of an Autocomplete
/// 
pub fn auto_activate(a: Autocomplete, activation: Activation) -> Autocomplete {
  Autocomplete(..a, auto_activate: activation)
}

/// filter sets the filter field of an Autocomplete
///
pub fn filter(a: Autocomplete, filter: FilterMode) -> Autocomplete {
  Autocomplete(..a, filter: filter)
}

/// for sets the for field of an Autocomplete
///
pub fn for_(a: Autocomplete, for: String) -> Autocomplete {
  Autocomplete(..a, for: for)
}

/// case_sensitive sets the case_sensitive field of an Autocomplete
pub fn case_sensitive(
  a: Autocomplete,
  sensitivity: CaseSensitivity,
) -> Autocomplete {
  Autocomplete(..a, case_sensitive: sensitivity)
}

/// hide_loading sets the hide_loading field of an Autocomplete
pub fn hide_loading(
  a: Autocomplete,
  visibility: LoadingVisibility,
) -> Autocomplete {
  Autocomplete(..a, hide_loading: visibility)
}

/// loading sets the loading state of an Autocomplete
pub fn loading(a: Autocomplete, status: LoadingStatus) -> Autocomplete {
  Autocomplete(..a, loading: status)
}

/// hide_no_data sets the hide_no_data field of an Autocomplete
pub fn hide_no_data(
  a: Autocomplete,
  visibility: EmptyMenuVisibility,
) -> Autocomplete {
  Autocomplete(..a, hide_no_data: visibility)
}

/// hide_selection_indicator sets the hide_selection_indicator field of an Autocomplete
///
pub fn hide_selection_indicator(
  a: Autocomplete,
  indicator: SelectionIndicator,
) -> Autocomplete {
  Autocomplete(..a, hide_selection_indicator: indicator)
}

/// loading_label sets the loading_label field of an Autocomplete
///
pub fn loading_label(a: Autocomplete, loading_label: String) -> Autocomplete {
  Autocomplete(..a, loading_label: loading_label)
}

/// no_data_label sets the no_data_label field of an Autocomplete
///
pub fn no_data_label(a: Autocomplete, no_data_label: String) -> Autocomplete {
  Autocomplete(..a, no_data_label: no_data_label)
}

/// panel_class sets the panel_class field of an Autocomplete
///
pub fn panel_class(a: Autocomplete, panel_class: Option(String)) -> Autocomplete {
  Autocomplete(..a, panel_class: panel_class)
}

/// required sets the required field of an Autocomplete
///
pub fn required(a: Autocomplete, required: Requirement) -> Autocomplete {
  Autocomplete(..a, required: required)
}

/// results_label sets the results_label field of an Autocomplete
///
pub fn results_label(a: Autocomplete, results_label: String) -> Autocomplete {
  Autocomplete(..a, results_label: results_label)
}

// --- RENDERING ---

/// render creates an M3E Autocomplete component from an Autocomplete
///
pub fn render(a: Autocomplete, children: List(m3eoption.Option)) -> Element(msg) {
  element.element(
    "m3e-autocomplete",
    [
      helpers.boolean_attribute(
        "auto-activate",
        a.auto_activate == AutoActivate,
      ),
      attribute.attribute("filter", filter_mode_to_string(a.filter)),
      attribute.attribute("for", a.for),
      helpers.boolean_attribute(
        "case-sensitive",
        a.case_sensitive == CaseSensitive,
      ),
      helpers.boolean_attribute("hide-no-data", a.hide_no_data == HideEmptyMenu),
      helpers.boolean_attribute(
        "hide-selection-indicator",
        a.hide_selection_indicator == HideSelectionIndicator,
      ),
      helpers.boolean_attribute(
        "hide-loading",
        a.hide_loading == HideLoadingIndicator,
      ),
      helpers.boolean_attribute("loading", a.loading == Loading),
      attribute.attribute("loading-label", a.loading_label),
      attribute.attribute("no-data-label", a.no_data_label),
      helpers.option_attribute(
        a.panel_class,
        fn(_) { "panel-class" },
        function.identity,
        None,
      ),
      helpers.boolean_attribute("required", a.required == Required),
      attribute.attribute("results-label", a.results_label),
    ]
      |> list.filter(fn(a) { a != attribute.none() }),
    list.map(children, fn(o) { m3eoption.render(o, [], []) }),
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  children: List(m3eoption.Option),
) -> Element(msg) {
  render(from_config(config), children)
}

// --- PRIVATE HELPER FUNCTIONS ---

fn filter_mode_to_string(m: FilterMode) -> String {
  case m {
    Contains -> "contains"
    StartsWith -> "starts-with"
    EndsWith -> "ends-with"
    NonFilter -> "none"
  }
}

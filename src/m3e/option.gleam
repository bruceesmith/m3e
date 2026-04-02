//// option provides Lustre support for the [M3E Option component](https://matraic.github.io/m3e/#/components/option.html)

import gleam/function
import gleam/list
import gleam/option.{type Option as GleamOption, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/state.{
  type Interaction, type SelectionState, Disabled, Selected, Unselected,
}

// --- TYPES ---

/// Option holds all information to create an Option
///
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - disable_highlight: Whether text highlighting is disabled
/// - highlight_mode: The mode in which to highlight a term
/// - selected: Whether the element is selected
/// - term: The search term to highlight
/// - value: A string representing the value of the option
/// 
pub opaque type Option {
  Option(
    disabled: Interaction,
    disable_highlight: Highlighting,
    highlight_mode: TextHighlightMode,
    selected: SelectionState,
    term: String,
    value: GleamOption(String),
  )
}

/// Highlighting specifies if text highlighting is active
pub type Highlighting {
  HighlightEnabled
  HighlightDisabled
}

/// TextHighlightMode is the mode in which to highlight a term
/// 
pub type TextHighlightMode {
  Contains
  StartsWith
  EndsWith
}

// --- CONFIGURATION ---

/// Config holds the configuration for an Option
/// 
pub type Config {
  Config(
    disabled: Interaction,
    disable_highlight: Highlighting,
    highlight_mode: TextHighlightMode,
    selected: SelectionState,
    term: String,
    value: GleamOption(String),
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    disabled: state.default_interaction,
    disable_highlight: HighlightEnabled,
    highlight_mode: Contains,
    selected: Unselected,
    value: None,
    term: "",
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Option with default values
///
pub fn new() -> Option {
  from_config(default_config())
}

/// from_config creates an Option from a Config record
/// 
pub fn from_config(c: Config) -> Option {
  Option(
    disabled: c.disabled,
    disable_highlight: c.disable_highlight,
    highlight_mode: c.highlight_mode,
    selected: c.selected,
    term: c.term,
    value: c.value,
  )
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(o: Option, disabled: Interaction) -> Option {
  Option(..o, disabled: disabled)
}

/// disable_highlight sets the disable_highlight field
/// 
pub fn disable_highlight(o: Option, disable_highlight: Highlighting) -> Option {
  Option(..o, disable_highlight: disable_highlight)
}

/// highlight_mode sets the highlight_mode field
pub fn highlight_mode(o: Option, mode: TextHighlightMode) -> Option {
  Option(..o, highlight_mode: mode)
}

/// term sets the highlight term field
pub fn term(o: Option, term: String) -> Option {
  Option(..o, term: term)
}

/// selected sets the selected field
/// 
pub fn selected(o: Option, selected: SelectionState) -> Option {
  Option(..o, selected: selected)
}

/// value sets the value field
/// 
pub fn value(o: Option, value: GleamOption(String)) -> Option {
  Option(..o, value: value)
}

// --- RENDERING ---

/// render creates an M3E Option component from an Option
///
pub fn render(
  o: Option,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-option",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", o.disabled == Disabled),
        helpers.boolean_attribute("selected", o.selected == Selected),
        helpers.boolean_attribute(
          "disable-highlight",
          o.disable_highlight == HighlightDisabled,
        ),
        case o.term {
          "" -> attribute.none()
          _ -> attribute.attribute("term", o.term)
        },
        attribute.attribute(
          "highlight-mode",
          highlight_mode_to_string(o.highlight_mode),
        ),
        helpers.option_attribute(
          o.value,
          fn(_) { "value" },
          function.identity,
          None,
        ),
      ],
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

fn highlight_mode_to_string(mode: TextHighlightMode) -> String {
  case mode {
    Contains -> "contains"
    StartsWith -> "starts-with"
    EndsWith -> "ends-with"
  }
}

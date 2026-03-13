//// selection_list provides Lustre support for the [M3E Selection List component](https://matraic.github.io/m3e/#/components/list.html)

import gleam/list.{filter, flatten}
import m3e/helpers.{boolean_attribute}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/list_variant.{type Variant, Standard, variant_to_string}

// --- Types ---

/// SelectionList provides a container for managing selectable list items with single or multi-select capabilities
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - hide_selection_indicator: Whether to hide the selection indicator
/// - multi: Whether multiple items can be selected
/// - variant: The appearance variant of the list
///
pub opaque type SelectionList {
  SelectionList(
    disabled: Bool,
    hide_selection_indicator: Bool,
    multi: Bool,
    variant: Variant,
  )
}

// --- CONFIGURATION ---

/// Config is the configuration of a SelectionList
///
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - hide_selection_indicator: Whether to hide the selection indicator
/// - multi: Whether multiple items can be selected
/// - variant: The appearance variant of the list
///
pub type Config {
  Config(
    disabled: Bool,
    hide_selection_indicator: Bool,
    multi: Bool,
    variant: Variant,
  )
}

/// default_config creates a Config with default values
///
pub fn default_config() -> Config {
  Config(
    disabled: False,
    hide_selection_indicator: False,
    multi: False,
    variant: Standard,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a SelectionList from a Config
///
/// ## Parameters:
/// - config: a Config
///
pub fn from_config(config: Config) -> SelectionList {
  SelectionList(
    disabled: config.disabled,
    hide_selection_indicator: config.hide_selection_indicator,
    multi: config.multi,
    variant: config.variant,
  )
}

/// new creates a SelectionList with default values
///
pub fn new() -> SelectionList {
  SelectionList(
    disabled: False,
    hide_selection_indicator: False,
    multi: False,
    variant: Standard,
  )
}

// --- SETTERS ---

/// disabled sets the `disabled` field
///
pub fn disabled(sl: SelectionList, disabled: Bool) -> SelectionList {
  SelectionList(..sl, disabled: disabled)
}

/// hide_selection_indicator sets the `hide_selection_indicator` field
///
pub fn hide_selection_indicator(
  sl: SelectionList,
  hide_selection_indicator: Bool,
) -> SelectionList {
  SelectionList(..sl, hide_selection_indicator: hide_selection_indicator)
}

/// multi sets the `multi` field
///
pub fn multi(sl: SelectionList, multi: Bool) -> SelectionList {
  SelectionList(..sl, multi: multi)
}

/// variant sets the `variant` field
///
pub fn variant(sl: SelectionList, variant: Variant) -> SelectionList {
  SelectionList(..sl, variant: variant)
}

// --- RENDERING ---

/// render creates a Lustre Element from a SelectionList
///
/// ## Parameters:
/// - sl: a SelectionList
/// - attributes: a list of additional Attributes
/// - children: the main content
///
pub fn render(
  sl: SelectionList,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-selection-list",
    flatten([
      [
        boolean_attribute("disabled", sl.disabled),
        boolean_attribute(
          "hide-selection-indicator",
          sl.hide_selection_indicator,
        ),
      ],
      [boolean_attribute("multi", sl.multi)],
      [attribute("variant", variant_to_string(sl.variant))],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
/// ## Parameters:
/// - config: a Config
///
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}
// --- PRIVATE INTERNAL HELPERS ---

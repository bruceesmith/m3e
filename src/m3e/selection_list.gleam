//// selection_list provides Lustre support for the [M3E Selection List component](https://matraic.github.io/m3e/#/components/list.html)

import gleam/list
import m3e/helpers

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/config.{type SelectionMode, Multi}
import m3e/list_variant.{type Variant, Standard}
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// IndicatorVisibility specifies if the selection indicator is visible or hidden
pub type IndicatorVisibility {
  Visible
  Hidden
}

pub const default_indicator_visibility: IndicatorVisibility = Visible

/// SelectionList provides a container for managing selectable list items with single or multi-select capabilities
/// 
/// ## Fields:
/// - disabled: Whether the element is enabled or disabled
/// - hide_selection_indicator: Whether to hide the selection indicator
/// - multi: Whether multiple items can be selected
/// - variant: The appearance variant of the list
///
pub opaque type SelectionList {
  SelectionList(
    disabled: Interaction,
    hide_selection_indicator: IndicatorVisibility,
    multi: SelectionMode,
    variant: Variant,
  )
}

// --- CONFIGURATION ---

/// Config is the configuration of a SelectionList
///
/// ## Fields:
/// - disabled: Whether the element is enabled or disabled
/// - hide_selection_indicator: Whether to hide the selection indicator
/// - multi: Whether multiple items can be selected
/// - variant: The appearance variant of the list
///
pub type Config {
  Config(
    disabled: Interaction,
    hide_selection_indicator: IndicatorVisibility,
    multi: SelectionMode,
    variant: Variant,
  )
}

pub const default_variant: Variant = Standard

/// default_config creates a Config with default values
///
pub fn default_config() -> Config {
  Config(
    disabled: state.default_interaction,
    hide_selection_indicator: default_indicator_visibility,
    multi: config.default_selection_mode,
    variant: default_variant,
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
  from_config(default_config())
}

// --- SETTERS ---

/// disabled sets the `disabled` field
///
pub fn disabled(sl: SelectionList, disabled: Interaction) -> SelectionList {
  SelectionList(..sl, disabled: disabled)
}

/// hide_selection_indicator sets the `hide_selection_indicator` field
///
pub fn hide_selection_indicator(
  sl: SelectionList,
  hide_selection_indicator: IndicatorVisibility,
) -> SelectionList {
  SelectionList(..sl, hide_selection_indicator: hide_selection_indicator)
}

/// multi sets the `multi` field
///
pub fn multi(sl: SelectionList, multi: SelectionMode) -> SelectionList {
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
  element.element(
    "m3e-selection-list",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", sl.disabled == Disabled),
        helpers.boolean_attribute(
          "hide-selection-indicator",
          sl.hide_selection_indicator == Hidden,
        ),
      ],
      [helpers.boolean_attribute("multi", sl.multi == Multi)],
      [
        attribute.attribute(
          "variant",
          list_variant.variant_to_string(sl.variant),
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

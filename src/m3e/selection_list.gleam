//// selection_list provides Lustre support for the [M3E Selection List component](https://matraic.github.io/m3e/#/components/list.html)

import gleam/list.{filter, flatten}
import m3e/helpers.{boolean_attribute}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/list_variant.{type Variant, Standard, variant_to_string}
import m3e/types.{
  type Interaction, type SelectionMode, Disabled, Multi, default_interaction,
  default_selection_mode,
}

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
/// - interaction: Whether the element is enabled or disabled
/// - indicator_visibility: Whether to hide the selection indicator
/// - selection_mode: Whether multiple items can be selected
/// - variant: The appearance variant of the list
///
pub opaque type SelectionList {
  SelectionList(
    interaction: Interaction,
    indicator_visibility: IndicatorVisibility,
    selection_mode: SelectionMode,
    variant: Variant,
  )
}

// --- CONFIGURATION ---

/// Config is the configuration of a SelectionList
///
/// ## Fields:
/// - interaction: Whether the element is enabled or disabled
/// - indicator_visibility: Whether to hide the selection indicator
/// - selection_mode: Whether multiple items can be selected
/// - variant: The appearance variant of the list
///
pub type Config {
  Config(
    interaction: Interaction,
    indicator_visibility: IndicatorVisibility,
    selection_mode: SelectionMode,
    variant: Variant,
  )
}

pub const default_variant: Variant = Standard

/// default_config creates a Config with default values
///
pub fn default_config() -> Config {
  Config(
    interaction: default_interaction,
    indicator_visibility: default_indicator_visibility,
    selection_mode: default_selection_mode,
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
    interaction: config.interaction,
    indicator_visibility: config.indicator_visibility,
    selection_mode: config.selection_mode,
    variant: config.variant,
  )
}

/// new creates a SelectionList with default values
///
pub fn new() -> SelectionList {
  from_config(default_config())
}

// --- SETTERS ---

/// disabled sets the `interaction` field
///
pub fn disabled(sl: SelectionList, interaction: Interaction) -> SelectionList {
  SelectionList(..sl, interaction: interaction)
}

/// hide_selection_indicator sets the `indicator_visibility` field
///
pub fn hide_selection_indicator(
  sl: SelectionList,
  indicator_visibility: IndicatorVisibility,
) -> SelectionList {
  SelectionList(..sl, indicator_visibility: indicator_visibility)
}

/// multi sets the `selection_mode` field
///
pub fn multi(sl: SelectionList, selection_mode: SelectionMode) -> SelectionList {
  SelectionList(..sl, selection_mode: selection_mode)
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
        boolean_attribute("disabled", sl.interaction == Disabled),
        boolean_attribute(
          "hide-selection-indicator",
          sl.indicator_visibility == Hidden,
        ),
      ],
      [boolean_attribute("multi", sl.selection_mode == Multi)],
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

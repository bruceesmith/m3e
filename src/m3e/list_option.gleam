//// list_option provides Lustre support for the [M3E List Option component](https://matraic.github.io/m3e/#/components/list.html)

import gleam/list
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// ListOption represents a selectable item within a list container
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - selected: Whether the element is selected
///
pub opaque type ListOption {
  ListOption(disabled: Bool, selected: Bool)
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Leading
  // Renders the leading content of the list item 
  Overline
  // Renders the overline of the list item 
  SupportingText
  // Renders the supporting text of the list item 
  Trailing
  // Renders the trailing content of the list item 
}

// --- CONFIGURATION ---

/// Config is the configuration of a ListOption
///
pub type Config {
  Config(disabled: Bool, selected: Bool)
}

/// default_config creates a Config with default values
///
pub fn default_config() -> Config {
  Config(disabled: False, selected: False)
}

// --- CONSTRUCTORS ---

/// from_config creates a ListOption from a Config
///
/// ## Parameters:
/// - config: a Config
///
pub fn from_config(config: Config) -> ListOption {
  ListOption(disabled: config.disabled, selected: config.selected)
}

/// new creates a ListOption with default values
///
pub fn new() -> ListOption {
  ListOption(disabled: False, selected: False)
}

// --- SETTERS ---  

/// disabled sets the `disabled` field
///
pub fn disabled(lo: ListOption, disabled: Bool) -> ListOption {
  ListOption(..lo, disabled: disabled)
}

/// selected sets the `selected` field
///
pub fn selected(lo: ListOption, selected: Bool) -> ListOption {
  ListOption(..lo, selected: selected)
}

// --- RENDERING ---

/// render creates a Lustre Element from a ListOption
///
/// ## Parameters:
/// - lo: a ListOption
/// - attributes: a list of additional Attributes
/// - children: the main content
///
pub fn render(
  lo: ListOption,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-list-option",
    list.flatten([
      [boolean_attribute("selected", lo.selected)],
      [boolean_attribute("disabled", lo.disabled)],
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
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

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Leading -> attribute("slot", "leading")
    Overline -> attribute("slot", "overline")
    SupportingText -> attribute("slot", "supporting-text")
    Trailing -> attribute("slot", "trailing")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

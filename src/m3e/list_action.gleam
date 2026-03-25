//// list_action provides Lustre support for the [M3E List Action component](https://matraic.github.io/m3e/#/components/list.html)

import gleam/list
import gleam/option.{Some}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/link.{type Link}

// --- Types ---

/// ListAction represents an interactive list item that performs a user-initiated action
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - link: attributes of the link button
/// 
pub opaque type ListAction {
  ListAction(disabled: Bool, link: Link)
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

/// Config is the configuration of a ListAction
/// 
pub type Config {
  Config(disabled: Bool, link: Link)
}

/// default_config creates a Config with default values
/// 
pub fn default_config() -> Config {
  Config(disabled: False, link: link.new(""))
}

// --- CONSTRUCTORS ---

/// from_config creates a ListAction from a Config
/// 
pub fn from_config(config: Config) -> ListAction {
  ListAction(disabled: config.disabled, link: config.link)
}

/// new creates a ListAction with default values
/// 
pub fn new() -> ListAction {
  ListAction(disabled: False, link: link.new(""))
}

// --- SETTERS ---

/// disabled sets the `disabled` field
/// 
pub fn disabled(la: ListAction, disabled: Bool) -> ListAction {
  ListAction(..la, disabled: disabled)
}

/// link sets the `link` field
/// 
pub fn link(la: ListAction, link: Link) -> ListAction {
  ListAction(..la, link: link)
}

// --- RENDERING ---  

/// render creates a Lustre Element from a ListAction
/// 
pub fn render(
  la: ListAction,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-list-action",
    list.flatten([
      [boolean_attribute("disabled", la.disabled)],
      link.attributes(Some(la.link)),
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
/// - attributes: a list of additional Attributes
/// - children: the main content
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

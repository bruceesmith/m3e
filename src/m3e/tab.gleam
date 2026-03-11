//// tab provides Lustre support for the [M3E Tab component](https://matraic.github.io/m3e/#/components/tabs.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Icon
  // Renders an icon before the tab's label 
}

/// Tab provides one view within a structured navigation surface
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - for: The identifier of the interactive control to which this element is attached.
/// - selected: Whether the element is selected
/// 
pub opaque type Tab {
  Tab(disabled: Bool, for: String, selected: Bool)
}

// --- CONSTRUCTORS ---

/// new creates a new Tab
/// 
pub fn new() -> Tab {
  Tab(disabled: False, for: "", selected: False)
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(t: Tab, disabled: Bool) -> Tab {
  Tab(..t, disabled: disabled)
}

/// for sets the for field
/// 
pub fn for(t: Tab, for: String) -> Tab {
  Tab(..t, for: for)
}

/// selected sets the selected field
/// 
pub fn selected(t: Tab, selected: Bool) -> Tab {
  Tab(..t, selected: selected)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Tab
///
/// ## Parameters:
/// - t: a Tab
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  t: Tab,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-tab",
    flatten([
      [
        boolean_attribute("disabled", t.disabled),
        attribute("for", t.for),
        boolean_attribute("selected", t.selected),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Icon -> attribute("slot", "icon")
  }
}
// --- PRIVATE INTERNAL HELPERS --- 

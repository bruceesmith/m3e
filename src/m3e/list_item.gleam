//// list_item provides Lustre support for the [M3E List Item component](https://matraic.github.io/m3e/#/components/list.html)

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

// --- Types ---

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

// --- CONSTRUCTORS ---

// --- SETTERS ---

// --- RENDERING ---

/// render creates a Lustre Element from a ListItem
///
pub fn render(children: List(Element(msg))) -> Element(msg) {
  element("m3e-list-item", [], children)
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

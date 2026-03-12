//// optgroup provides Lustre support for the [M3E Optgroup component](https://matraic.github.io/m3e/#/components/option.html)

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

// --- Types ---

/// Optgroup holds all information to create an Optgroup
///
/// ## Fields:
/// - no fields are defined
/// 
pub opaque type Optgroup {
  Optgroup
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Label
  // Renders the label of the group 
}

// --- CONSTRUCTORS ---

/// new creates a new Optgroup
///
/// ## Parameters:
/// - no parameters are defined
/// 
pub fn new() -> Optgroup {
  Optgroup
}

// --- RENDERING ---

/// render creates an M3E Optgroup component from an Optgroup
///
pub fn render(
  _: Optgroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element("m3e-option-panel", attributes, children)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Label -> attribute("slot", "label")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

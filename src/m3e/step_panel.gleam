//// StepPanel is a panel presented for a step in a wizard-like workflow.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

// --- Types ---

/// StepPanel is a View Model for this component
///
pub opaque type StepPanel {
  StepPanel
}

// --- Defaults ---

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Actions
  // Renders the actions bar of the panel.
}

// --- Constructors ---

/// new creates a new StepPanel with the default configuration.
///
pub fn new() -> StepPanel {
  StepPanel
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a StepPanel
///
pub fn render(
  _: StepPanel,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-step-panel", attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Actions -> attribute.attribute("slot", "actions-")
  }
}

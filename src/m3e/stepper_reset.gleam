//// StepperReset is an element, nested within a clickable element, used to reset a stepper to its initial state.
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

/// StepperReset is a View Model for this component
///
pub opaque type StepperReset {
  StepperReset
}

// --- Defaults ---

// --- Constructors ---

/// new creates a new StepperReset with the default configuration.
///
pub fn new() -> StepperReset {
  StepperReset
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a StepperReset
///
pub fn render(
  _: StepperReset,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-stepper-reset", attributes, children)
}

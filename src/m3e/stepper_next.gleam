//// StepperNext is an element, nested within a clickable element, used to move a stepper to the next step.
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

/// StepperNext is a View Model for this component
///
pub opaque type StepperNext {
  StepperNext
}

// --- Defaults ---

// --- Constructors ---

/// new creates a new StepperNext with the default configuration.
///
pub fn new() -> StepperNext {
  StepperNext
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a StepperNext
///
pub fn render(
  _: StepperNext,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-stepper-previous", attributes, children)
}

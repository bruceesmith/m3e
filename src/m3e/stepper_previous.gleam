//// StepperPrevious is an element, nested within a clickable element, used to move a stepper to the previous step.
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

/// StepperPrevious is a View Model for this component
///
pub opaque type StepperPrevious {
  StepperPrevious
}

// --- Defaults ---

// --- Constructors ---

/// new creates a new StepperPrevious with the default configuration.
///
pub fn new() -> StepperPrevious {
  StepperPrevious
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a StepperPrevious
///
pub fn render(
  _: StepperPrevious,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-stepper-previous", attributes, children)
}

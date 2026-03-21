//// stepper_reset provides Lustre support for the [M3E Stepper Reset component](https://matraic.github.io/m3e/#/components/stepper.html)

import lustre/element.{type Element, element, text}

// ---  TYPES ----

/// StepperReset provides Lustre support for the [M3E Stepper Reset component](https://matraic.github.io/m3e/#/components/stepper.html)
/// 
/// ## Fields:
/// - label: The label to display for the Reset button
/// 
pub opaque type StepperReset {
  StepperReset(label: String)
}

// --- CONSTRUCTORS ---

/// new creates a new StepperReset
///
pub fn new(label: String) -> StepperReset {
  StepperReset(label: label)
}

// --- SETTERS ---

/// label sets the label field
///
pub fn label(_: StepperReset, label: String) -> StepperReset {
  StepperReset(label: label)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a StepperReset
///
pub fn render(s: StepperReset) -> Element(msg) {
  element("m3e-stepper-reset", [], [text(s.label)])
}

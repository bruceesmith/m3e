//// stepper_previous provides Lustre support for the [M3E Stepper Previous component](https://matraic.github.io/m3e/#/components/stepper.html)

import lustre/element.{type Element, element, text}

// --- TYPES ---

/// StepperPrevious provides Lustre support for the [M3E Stepper Previous component](https://matraic.github.io/m3e/#/components/stepper.html)
/// 
/// ## Fields:
/// - label: The label to display for the Previous button
/// 
pub opaque type StepperPrevious {
  StepperPrevious(label: String)
}

// --- CONSTRUCTORS ---

/// new creates a new StepperPrevious
///
pub fn new(label: String) -> StepperPrevious {
  StepperPrevious(label: label)
}

// --- SETTERS ---

/// label sets the label field
///
pub fn label(_: StepperPrevious, label: String) -> StepperPrevious {
  StepperPrevious(label: label)
}

// --- RENDERERS ---

/// render creates a Lustre Element(msg) from a StepperPrevious
///
pub fn render(s: StepperPrevious) -> Element(msg) {
  element("m3e-stepper-previous", [], [text(s.label)])
}

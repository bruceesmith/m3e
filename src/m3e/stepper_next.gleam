//// stepper_next provides Lustre support for the [M3E Stepper Next component](https://matraic.github.io/m3e/#/components/stepper.html)

import lustre/element.{type Element, element, text}

// --- Types ---

/// StepperNext provides Lustre support for the [M3E Stepper Next component](https://matraic.github.io/m3e/#/components/stepper.html)
/// 
/// ## Fields:
/// - label: The label to display for the Next button
/// 
pub opaque type StepperNext {
  StepperNext(label: String)
}

// --- CONSTRUCTORS ---

/// new creates a new StepperNext
///
pub fn new(label: String) -> StepperNext {
  StepperNext(label: label)
}

// --- SETTERS ---

/// label sets the label field
///
pub fn label(_: StepperNext, label: String) -> StepperNext {
  StepperNext(label: label)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a StepperNext
///
pub fn render(s: StepperNext) -> Element(msg) {
  element("m3e-stepper-next", [], [text(s.label)])
}

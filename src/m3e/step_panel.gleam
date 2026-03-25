//// step_panel provides Lustre support for the [M3E Step Panel component](https://matraic.github.io/m3e/#/components/stepper.html)

import lustre/attribute
import lustre/element.{type Element}

// --- Types ---

/// StepPanel provides Lustre support for the [M3E Step Panel component
/// 
/// ## Fields:
/// - id: The identifier of the step panel
/// 
pub opaque type StepPanel {
  StepPanel(id: String)
}

// --- CONSTRUCTORS ---

/// new creates a new StepPanel
/// 
pub fn new(id: String) -> StepPanel {
  StepPanel(id: id)
}

// --- SETTERS ---

/// id sets the id field
/// 
pub fn id(_: StepPanel, id: String) -> StepPanel {
  StepPanel(id: id)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a StepPanel
/// 
pub fn render(s: StepPanel) -> Element(msg) {
  element.element("m3e-step-panel", [attribute.attribute("id", s.id)], [])
}

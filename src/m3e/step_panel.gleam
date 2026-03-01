//// step_panel provides Lustre support for the [M3E Step Panel component](https://matraic.github.io/m3e/#/components/stepper.html)

import lustre/attribute.{attribute}
import lustre/element.{type Element, element}

/// StepPanel provides Lustre support for the [M3E Step Panel component
/// 
/// ## Fields:
/// - id: The identifier of the step panel
/// 
pub opaque type StepPanel {
  StepPanel(id: String)
}

/// new creates a new StepPanel
/// 
pub fn new(id: String) -> StepPanel {
  StepPanel(id: id)
}

/// id sets the id field
/// 
pub fn id(_: StepPanel, id: String) -> StepPanel {
  StepPanel(id: id)
}

/// render creates a Lustre Element(msg) from a StepPanel
/// 
pub fn render(s: StepPanel) -> Element(msg) {
  element("m3e-step-panel", [attribute("id", s.id)], [])
}

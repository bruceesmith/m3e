//// step provides Lustre support for the [M3E Step component](https://matraic.github.io/m3e/#/components/stepper.html)

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  DoneIcon
  // Renders the icon of a completed step 
  EditIcon
  // Renders the icon of a completed editable step 
  Error
  // Renders the error message for an invalid step 
  ErrorIcon
  // Renders icon of an invalid step 
  Hint
  // Renders the hint text of the step 
  Icon
  // Renders the icon of the step
}

/// Step provides Lustre support for the [M3E Step component
/// 
/// ## Fields:
/// - completed: Whether the step has been completed
/// - disabled: Whether the element is disabled
/// - editable: Whether the step is editable and users can return to it after completion
/// - for: The identifier of the interactive control to which this element is attached
/// - optional: Whether the step is optional
/// - selected: Whether the element is selected
/// - text: The text to display in the step
/// 
pub opaque type Step {
  Step(
    completed: Bool,
    disabled: Bool,
    editable: Bool,
    for: String,
    optional: Bool,
    selected: Bool,
    text: String,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Step
/// 
pub fn new(for: String) -> Step {
  Step(False, False, False, for, False, False, "")
}

// --- SETTERS ---

/// completed sets the completed field
/// 
pub fn completed(s: Step, completed: Bool) -> Step {
  Step(..s, completed: completed)
}

/// disabled sets the disabled field
/// 
pub fn disabled(s: Step, disabled: Bool) -> Step {
  Step(..s, disabled: disabled)
}

/// editable sets the editable field
/// 
pub fn editable(s: Step, editable: Bool) -> Step {
  Step(..s, editable: editable)
}

/// for sets the for field
/// 
pub fn for_(s: Step, for: String) -> Step {
  Step(..s, for: for)
}

/// optional sets the optional field
/// 
pub fn optional(s: Step, optional: Bool) -> Step {
  Step(..s, optional: optional)
}

/// selected sets the selected field
/// 
pub fn selected(s: Step, selected: Bool) -> Step {
  Step(..s, selected: selected)
}

/// text sets the text field
/// 
pub fn text(s: Step, text: String) -> Step {
  Step(..s, text: text)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Step
/// 
pub fn render(s: Step) -> Element(msg) {
  element(
    "m3e-step",
    [
      boolean_attribute("completed", s.completed),
      boolean_attribute("disabled", s.disabled),
      boolean_attribute("editable", s.editable),
      attribute("for", s.for),
      boolean_attribute("optional", s.optional),
      boolean_attribute("selected", s.selected),
    ],
    [element.text(s.text)],
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    DoneIcon -> attribute("slot", "done-icon")
    EditIcon -> attribute("slot", "edit-icon")
    Error -> attribute("slot", "error")
    ErrorIcon -> attribute("slot", "error-icon")
    Hint -> attribute("slot", "hint")
    Icon -> attribute("slot", "icon")
  }
}

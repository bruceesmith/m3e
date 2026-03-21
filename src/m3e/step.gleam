//// step provides Lustre support for the [M3E Step component](https://matraic.github.io/m3e/#/components/stepper.html)

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}
import m3e/types.{type Interaction, Disabled, Enabled, default_interaction}

// --- Types ---

/// Whether the step has been completed
pub type Completed {
  Completed
  NotCompleted
}

pub const default_completed: Completed = NotCompleted

/// Whether the step is editable and users can return to it after completion
pub type Editable {
  Editable
  NotEditable
}

pub const default_editable: Editable = NotEditable

/// Whether the step is optional
pub type Optional {
  Optional
  NotOptional
}

pub const default_optional: Optional = NotOptional

/// Whether the element is selected
pub type Selected {
  Selected
  NotSelected
}

pub const default_selected: Selected = NotSelected

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

// -- CONFIGURATION ---

/// Config is a record that contains all of the configurable options for a Step
pub type Config {
  Config(
    completed: Completed,
    disabled: Interaction,
    editable: Editable,
    for: String,
    optional: Optional,
    selected: Selected,
    text: String,
  )
}

/// default_config creates a default Config for a Step
///
pub fn default_config(for: String) -> Config {
  Config(
    default_completed,
    default_interaction,
    default_editable,
    for,
    default_optional,
    default_selected,
    "",
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Step
///
pub fn new(for: String) -> Step {
  Step(False, False, False, for, False, False, "")
}

/// from_config creates a new Step from a Config
///
pub fn from_config(config: Config) -> Step {
  Step(
    completed: config.completed == Completed,
    disabled: config.disabled == Disabled,
    editable: config.editable == Editable,
    for: config.for,
    optional: config.optional == Optional,
    selected: config.selected == Selected,
    text: config.text,
  )
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
pub fn render(s: Step, children: List(Element(msg))) -> Element(msg) {
  let config =
    Config(
      completed: case s.completed {
        True -> Completed
        False -> NotCompleted
      },
      disabled: case s.disabled {
        True -> Disabled
        False -> Enabled
      },
      editable: case s.editable {
        True -> Editable
        False -> NotEditable
      },
      for: s.for,
      optional: case s.optional {
        True -> Optional
        False -> NotOptional
      },
      selected: case s.selected {
        True -> Selected
        False -> NotSelected
      },
      text: s.text,
    )
  render_config(config, children)
}

/// render_config creates a Lustre Element(msg) from a Config
///
pub fn render_config(
  config: Config,
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-step",
    [
      boolean_attribute("completed", config.completed == Completed),
      boolean_attribute("disabled", config.disabled == Disabled),
      boolean_attribute("editable", config.editable == Editable),
      attribute("for", config.for),
      boolean_attribute("optional", config.optional == Optional),
      boolean_attribute("selected", config.selected == Selected),
    ],
    [element.text(config.text), ..children],
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

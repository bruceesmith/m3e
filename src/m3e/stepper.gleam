//// Stepper is provides a wizard-like workflow by dividing content into logical steps.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/step_header_position.{type StepHeaderPosition}
import m3e/step_label_position.{type StepLabelPosition}
import m3e/stepper_orientation.{type StepperOrientation}

// --- Types ---

/// Stepper is a View Model for this component
///
/// ## Fields:
///
/// - header_position: The position of the step header, when oriented horizontally.
/// - label_position: The position of the step labels, when oriented horizontally.
/// - linear: Whether the validity of previous steps should be checked or not.
/// - orientation: The orientation of the stepper.
///
pub opaque type Stepper {
  Stepper(
    header_position: StepHeaderPosition,
    label_position: StepLabelPosition,
    linear: Linear,
    orientation: StepperOrientation,
  )
}

/// Linear is whether the validity of previous steps should be checked or not.
///
pub type Linear {
  IsLinear
  IsNotLinear
}

// --- Defaults ---

pub const default_header_position: StepHeaderPosition = step_header_position.Above

pub const default_label_position: StepLabelPosition = step_label_position.End

pub const default_linear: Linear = IsNotLinear

pub const default_orientation: StepperOrientation = stepper_orientation.Horizontal

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Step
  // Renders a step.
  Panel
  // Renders a panel.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    header_position: StepHeaderPosition,
    label_position: StepLabelPosition,
    linear: Linear,
    orientation: StepperOrientation,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    header_position: step_header_position.Above,
    label_position: step_label_position.End,
    linear: IsNotLinear,
    orientation: stepper_orientation.Horizontal,
  )
}

// --- Constructors ---

/// from_config creates a new Stepper from the given configuration.
///
pub fn from_config(config: Config) -> Stepper {
  Stepper(
    header_position: config.header_position,
    label_position: config.label_position,
    linear: config.linear,
    orientation: config.orientation,
  )
}

/// new creates a new Stepper with the default configuration.
///
pub fn new() -> Stepper {
  from_config(default_config())
}

// --- Setters ---

/// header_position sets the value of header_position for this Stepper.
///
pub fn header_position(
  record: Stepper,
  header_position: StepHeaderPosition,
) -> Stepper {
  Stepper(..record, header_position: header_position)
}

/// label_position sets the value of label_position for this Stepper.
///
pub fn label_position(
  record: Stepper,
  label_position: StepLabelPosition,
) -> Stepper {
  Stepper(..record, label_position: label_position)
}

/// linear sets the value of linear for this Stepper.
///
pub fn linear(record: Stepper, linear: Linear) -> Stepper {
  Stepper(..record, linear: linear)
}

/// orientation sets the value of orientation for this Stepper.
///
pub fn orientation(record: Stepper, orientation: StepperOrientation) -> Stepper {
  Stepper(..record, orientation: orientation)
}

// --- Renderers ---

/// render creates a Lustre Element for a Stepper
///
pub fn render(
  model: Stepper,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-stepper",
    list.flatten([
      [
        attr.with_default(
          "header-position",
          step_header_position.to_string(model.header_position),
          step_header_position.to_string(default_header_position),
        ),
        attr.with_default(
          "label-position",
          step_label_position.to_string(model.label_position),
          step_label_position.to_string(default_label_position),
        ),
        attr.boolean("linear", model.linear == IsLinear),
        attr.with_default(
          "orientation",
          stepper_orientation.to_string(model.orientation),
          stepper_orientation.to_string(default_orientation),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Stepper Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Step -> attribute.attribute("slot", "step")
    Panel -> attribute.attribute("slot", "panel")
  }
}

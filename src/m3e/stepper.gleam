//// stepper provides Lustre support for the [M3E Stepper component](https://matraic.github.io/m3e/#/components/stepper.html)

import gleam/list

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// HeaderPosition is the position of the step header, when oriented horizontally.
/// 
pub type HeaderPosition {
  Above
  Below
}

pub const default_header_position = Above

/// LabelPosition is the position of the step labels, when oriented horizontally.
/// 
pub type LabelPosition {
  LabelBelow
  LabelEnd
}

pub const default_label_position = LabelEnd

/// LinearValidity determines whether the validity of previous steps should be checked or not
/// 
pub type LinearValidity {
  Check
  DontCheck
}

pub const default_linear_validity = DontCheck

/// Orientation is the orientation of the stepper.
/// 
pub type Orientation {
  Auto
  Horizontal
  Vertical
}

pub const default_orientation = Horizontal

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Panel
  // Renders a panel 
  Step
  // Renders a step 
}

/// Stepper provides Lustre support for the [M3E Stepper component
/// 
/// ## Fields:
/// - header-position: The position of the step header, when oriented horizontally.
/// - label_position: The position of the step labels, when oriented horizontally.
/// - linear: Whether the validity of previous steps should be checked or not.
/// - orientation: The orientation of the stepper.
/// 
pub opaque type Stepper {
  Stepper(
    header_position: HeaderPosition,
    label_position: LabelPosition,
    linear: LinearValidity,
    orientation: Orientation,
  )
}

// -- CONFIGURATION --

/// Config holds the configuration for a Stepper
/// 
pub type Config {
  Config(
    header_position: HeaderPosition,
    label_position: LabelPosition,
    linear: LinearValidity,
    orientation: Orientation,
  )
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(
    header_position: default_header_position,
    label_position: default_label_position,
    linear: default_linear_validity,
    orientation: default_orientation,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Stepper
/// 
pub fn new() -> Stepper {
  from_config(default_config())
}

/// from_config creates a Stepper from a Config
///
pub fn from_config(config: Config) -> Stepper {
  Stepper(
    header_position: config.header_position,
    label_position: config.label_position,
    linear: config.linear,
    orientation: config.orientation,
  )
}

// --- SETTERS ---

/// header_position sets the header_position field of a Stepper
///
pub fn header_position(
  stepper: Stepper,
  header_position: HeaderPosition,
) -> Stepper {
  Stepper(..stepper, header_position: header_position)
}

/// label_position sets the label_position field of a Stepper
///
pub fn label_position(
  stepper: Stepper,
  label_position: LabelPosition,
) -> Stepper {
  Stepper(..stepper, label_position: label_position)
}

/// linear sets the linear field of a Stepper
///
pub fn linear(stepper: Stepper, linear: LinearValidity) -> Stepper {
  Stepper(..stepper, linear: linear)
}

/// orientation sets the orientation field of a Stepper
///
pub fn orientation(stepper: Stepper, orientation: Orientation) -> Stepper {
  Stepper(..stepper, orientation: orientation)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Stepper
///
pub fn render(
  stepper: Stepper,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-stepper",
    list.flatten([
      [
        attribute(
          "header-position",
          head_position_to_string(stepper.header_position),
        ),
        attribute(
          "label-position",
          label_position_to_string(stepper.label_position),
        ),
        boolean_attribute("linear", stepper.linear == Check),
        attribute("orientation", orientation_to_string(stepper.orientation)),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

// --- ATTRIBUTES ---

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Panel -> attribute("slot", "panel")
    Step -> attribute("slot", "step")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn head_position_to_string(header_position: HeaderPosition) -> String {
  case header_position {
    Above -> "above"
    Below -> "below"
  }
}

fn label_position_to_string(label_position: LabelPosition) -> String {
  case label_position {
    LabelBelow -> "below"
    LabelEnd -> "end"
  }
}

fn orientation_to_string(orientation: Orientation) -> String {
  case orientation {
    Auto -> "auto"
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
}

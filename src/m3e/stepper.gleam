//// stepper provides Lustre support for the [M3E Stepper component](https://matraic.github.io/m3e/#/components/stepper.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

/// HeaderPosition is the position of the step header, when oriented horizontally.
/// 
pub type HeaderPosition {
  Above
  Below
}

fn head_position_to_string(header_position: HeaderPosition) -> String {
  case header_position {
    Above -> "above"
    Below -> "below"
  }
}

pub const default_header_position = Above

/// LabelPosition is the position of the step labels, when oriented horizontally.
/// 
pub type LabelPosition {
  LabelBelow
  LabelEnd
}

fn label_position_to_string(label_position: LabelPosition) -> String {
  case label_position {
    LabelBelow -> "below"
    LabelEnd -> "end"
  }
}

pub const default_label_position = LabelEnd

/// Orientation is the orientation of the stepper.
/// 
pub type Orientation {
  Auto
  Horizontal
  Vertical
}

fn orientation_to_string(orientation: Orientation) -> String {
  case orientation {
    Auto -> "auto"
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
}

pub const default_orientation = Horizontal

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
    linear: Bool,
    orientation: Orientation,
  )
}

/// new creates a new Stepper
/// 
pub fn new() -> Stepper {
  Stepper(
    default_header_position,
    default_label_position,
    False,
    default_orientation,
  )
}

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
pub fn linear(stepper: Stepper, linear: Bool) -> Stepper {
  Stepper(..stepper, linear: linear)
}

/// orientation sets the orientation field of a Stepper
///
pub fn orientation(stepper: Stepper, orientation: Orientation) -> Stepper {
  Stepper(..stepper, orientation: orientation)
}

/// render creates a Lustre Element(msg) from a Stepper
///
pub fn render(
  stepper: Stepper,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-stepper",
    flatten([
      [
        attribute(
          "header-position",
          head_position_to_string(stepper.header_position),
        ),
        attribute(
          "label-position",
          label_position_to_string(stepper.label_position),
        ),
        boolean_attribute("linear", stepper.linear),
        attribute("orientation", orientation_to_string(stepper.orientation)),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

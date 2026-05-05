//// Icon is a small symbol used to easily identify an action or category.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/float
import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/icon_grade.{type IconGrade}
import m3e/icon_variant.{type IconVariant}
import m3e/icon_weight.{type IconWeight}

// --- Types ---

/// Icon is a View Model for this component
///
/// ## Fields:
///
/// - filled: Whether the icon is filled.
/// - grade: The grade of the icon.
/// - optical_size: A value from 20 to 48 indicating the optical size of the icon.
/// - name: The name of the icon.
/// - variant: The appearance variant of the icon.
/// - weight: A value from 100 to 700 indicating the weight of the icon.
///
pub opaque type Icon {
  Icon(
    filled: Filled,
    grade: IconGrade,
    optical_size: Float,
    name: String,
    variant: IconVariant,
    weight: IconWeight,
  )
}

/// Filled is whether the icon is filled.
///
pub type Filled {
  IsFilled
  IsNotFilled
}

// --- Defaults ---

pub const default_filled: Filled = IsNotFilled

pub const default_grade: IconGrade = icon_grade.Medium

pub const default_optical_size: Float = 24.0

pub const default_name: String = ""

pub const default_variant: IconVariant = icon_variant.Outlined

pub const default_weight: IconWeight = icon_weight.FourZeroZero

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    filled: Filled,
    grade: IconGrade,
    optical_size: Float,
    name: String,
    variant: IconVariant,
    weight: IconWeight,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    filled: IsNotFilled,
    grade: icon_grade.Medium,
    optical_size: 24.0,
    name: "",
    variant: icon_variant.Outlined,
    weight: icon_weight.FourZeroZero,
  )
}

// --- Constructors ---

/// from_config creates a new Icon from the given configuration.
///
pub fn from_config(config: Config) -> Icon {
  Icon(
    filled: config.filled,
    grade: config.grade,
    optical_size: config.optical_size,
    name: config.name,
    variant: config.variant,
    weight: config.weight,
  )
}

/// new creates a new Icon with the default configuration.
///
pub fn new() -> Icon {
  from_config(default_config())
}

// --- Setters ---

/// filled sets the value of filled for this Icon.
///
pub fn filled(record: Icon, filled: Filled) -> Icon {
  Icon(..record, filled: filled)
}

/// grade sets the value of grade for this Icon.
///
pub fn grade(record: Icon, grade: IconGrade) -> Icon {
  Icon(..record, grade: grade)
}

/// optical_size sets the value of optical_size for this Icon.
///
pub fn optical_size(record: Icon, optical_size: Float) -> Icon {
  Icon(..record, optical_size: optical_size)
}

/// name sets the value of name for this Icon.
///
pub fn name(record: Icon, name: String) -> Icon {
  Icon(..record, name: name)
}

/// variant sets the value of variant for this Icon.
///
pub fn variant(record: Icon, variant: IconVariant) -> Icon {
  Icon(..record, variant: variant)
}

/// weight sets the value of weight for this Icon.
///
pub fn weight(record: Icon, weight: IconWeight) -> Icon {
  Icon(..record, weight: weight)
}

// --- Renderers ---

/// render creates a Lustre Element for a Icon
///
pub fn render(
  model: Icon,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-icon",
    list.flatten([
      [
        attr.boolean("filled", model.filled == IsFilled),
        attr.with_default(
          "grade",
          icon_grade.to_string(model.grade),
          icon_grade.to_string(default_grade),
        ),
        attr.with_default(
          "optical-size",
          float.to_string(model.optical_size),
          float.to_string(default_optical_size),
        ),
        attr.with_default("name", model.name, default_name),
        attr.with_default(
          "variant",
          icon_variant.to_string(model.variant),
          icon_variant.to_string(default_variant),
        ),
        attr.with_default(
          "weight",
          icon_weight.to_string(model.weight),
          icon_weight.to_string(default_weight),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Icon Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

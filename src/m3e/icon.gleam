//// icon provides Lustre support for the [M3E Icon component](https://matraic.github.io/m3e/#/components/icon.html)

import gleam/int.{to_string}
import gleam/list.{append}
import lustre/attribute.{type Attribute, attribute, name}
import lustre/element.{type Element}

import m3e/helpers.{clamp_with_default}

/// The Grade of the variable font icon
/// [Refer](https://m3.material.io/styles/icons/applying-icons)
///
pub type Grade {
  Low
  Medium
  High
}

fn grade_to_string(grade: Grade) -> String {
  case grade {
    Low -> "low"
    Medium -> "medium"
    High -> "high"
  }
}

/// Default grade
pub const default_grade = Medium

/// The Optical Size of the variable font icon
/// [Refer](https://m3.material.io/styles/icons/applying-icons)
///
pub type OpticalSize =
  Int

/// The snakkest optical size of the icon
pub const smallest_optical_size = 20

/// The largest optical size
pub const largest_optical_size = 48

/// The default optical size of the icon
pub const default_optical_size = 24

/// Purpose defines the intended purpose of the icon
pub type Purpose {
  /// A standalone icon, or a leading icon on (for example) a button
  Leading
  /// Alternate icon when its containing element is selected (e.g. on a toggle button)
  Selected
  /// Trailing icon on (for example) a button
  Trailing
}

fn purpose_to_string(purpose: Purpose) -> String {
  case purpose {
    Leading -> "icon"
    Selected -> "selected-icon"
    Trailing -> "trailing-icon"
  }
}

/// Default purpose
pub const default_purpose = Leading

/// The Variant of the icon
pub type Variant {
  Outlined
  Rounded
  Sharp
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Outlined -> "outlined"
    Rounded -> "rounded"
    Sharp -> "sharp"
  }
}

/// Default variant
const default_variant = Outlined

/// The Weight of the variable font icon
/// [Refer](https://m3.material.io/styles/icons/applying-icons)
///
pub type Weight =
  Int

/// The smallest weight of the icon
pub const smallest_weight = 100

/// The largest weight of the icon
pub const largest_weight = 700

/// The default weight of the icon
pub const default_weight = 400

/// Icon is the basis for a m3e-icon element that uses Material Symbols
///
/// ## Fields:
/// - name: The icon to load,
///     Refer to [Material Symbols](https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0..1,0)
/// - filled: is the icon filled or not (the FILL axis of the variable font)
/// - grade:  the stroke thickness of an icon (the GRAD axis of the variable font)
/// - optical_size:  the optical size of the icon. Between 20 and 48
/// - purpose: the role of the icon
/// - variant:  the visual style of the icon
/// - weight: the thickness and boldness of the icon's strokes. Between 100 and 700
///
pub type Icon {
  Icon(
    name: String,
    filled: Bool,
    grade: Grade,
    optical_size: OpticalSize,
    purpose: Purpose,
    variant: Variant,
    weight: Weight,
  )
}

/// icon creates an Icon
///
/// ## Parameters:
/// - name: The icon to load,
///     Refer to [Material Symbols](https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0..1,0)
/// - filled: is the icon filled or not (the FILL axis of the variable font)
/// - grade:  the stroke thickness of an icon (the GRAD axis of the variable font)
/// - optical_size:  the optical size of the icon. Between 20 and 48
/// - purpose: the role of the icon
/// - variant:  the visual style of the icon
/// - weight: the thickness and boldness of the icon's strokes. Between 100 and 700
///
pub fn icon(
  name: String,
  filled: Bool,
  grade: Grade,
  optical_size: OpticalSize,
  purpose: Purpose,
  variant: Variant,
  weight: Weight,
) -> Icon {
  Icon(
    name: name,
    filled: filled,
    grade: grade,
    optical_size: optical_size_validate(optical_size),
    purpose: purpose,
    variant: variant,
    weight: weight_validate(weight),
  )
}

/// basic constructs an Icon for the named Material Symbol. All fields are set to defaults
///
/// ## Parameter:
/// - name: the name of the Material Symbol used in this Icon
///
pub fn basic(name: String) -> Icon {
  Icon(
    name,
    False,
    default_grade,
    default_optical_size,
    default_purpose,
    default_variant,
    default_weight,
  )
}

/// element creates an m3e-icon Lustre custom element from an Icon
///
/// ## Parameters:
/// - i: the Icon on which the element is based
/// - attributes: additional HTML attributes
/// - children: child HTML elements
///
pub fn element(
  i: Icon,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-icon",
    append(
      [
        name(i.name),
        filled_attr(i.filled),
        grade_attr(i.grade),
        optical_size_attr(i.optical_size),
        purpose_attr(i.purpose),
        variant_attr(i.variant),
        weight_attr(i.weight),
      ],
      attributes,
    ),
    children,
  )
}

/// filled sets the filled`field
///
pub fn filled(i: Icon, f: Bool) -> Icon {
  Icon(..i, filled: f)
}

fn filled_attr(f: Bool) -> Attribute(msg) {
  case f {
    False -> attribute("filled", "0")
    True -> attribute("filled", "1")
  }
}

/// grade sets the `grade` field
///
pub fn grade(i: Icon, g: Grade) -> Icon {
  Icon(..i, grade: g)
}

fn grade_attr(g: Grade) -> Attribute(msg) {
  attribute("grade", grade_to_string(g))
}

/// leading returns True if the Icon Puspose is Leading
///
pub fn leading(i: Icon) -> Bool {
  case i.purpose {
    Leading -> True
    _ -> False
  }
}

/// optical_size checks and then sets the `optical_size` field
///
pub fn optical_size(i: Icon, os: OpticalSize) -> Icon {
  Icon(..i, optical_size: optical_size_validate(os))
}

fn optical_size_attr(os: OpticalSize) -> Attribute(msg) {
  attribute("optical-size", to_string(os))
}

fn optical_size_validate(os: OpticalSize) -> OpticalSize {
  clamp_with_default(
    os,
    smallest_optical_size,
    largest_optical_size,
    default_optical_size,
  )
}

/// purpose sets the `purpose` field
///
pub fn purpose(i: Icon, p: Purpose) -> Icon {
  Icon(..i, purpose: p)
}

fn purpose_attr(p: Purpose) -> Attribute(msg) {
  attribute("slot", purpose_to_string(p))
}

/// variant sets the `variant` field
///
pub fn variant(i: Icon, v: Variant) -> Icon {
  Icon(..i, variant: v)
}

fn variant_attr(v: Variant) -> Attribute(msg) {
  attribute("variant", variant_to_string(v))
}

/// weight sets the `weight` field
///
pub fn weight(i: Icon, w: Weight) -> Icon {
  Icon(..i, weight: weight_validate(w))
}

fn weight_attr(w: Weight) -> Attribute(msg) {
  attribute("weight", to_string(w))
}

fn weight_validate(weight: Weight) -> Weight {
  clamp_with_default(weight, smallest_weight, largest_weight, default_weight)
}

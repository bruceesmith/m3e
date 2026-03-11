//// icon provides Lustre support for the [M3E Icon component](https://matraic.github.io/m3e/#/components/icon.html)

import gleam/int.{to_string}
import gleam/list
import lustre/attribute.{type Attribute, attribute, name, none}
import lustre/element.{type Element, element}

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

/// The smallest optical size of the icon
pub const smallest_optical_size = 20

/// The largest optical size
pub const largest_optical_size = 48

/// The default optical size of the icon
pub const default_optical_size = 24

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
pub const default_variant = Outlined

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
pub opaque type Icon(msg) {
  Icon(
    name: String,
    filled: Bool,
    grade: Grade,
    optical_size: OpticalSize,
    purpose: Attribute(msg),
    variant: Variant,
    weight: Weight,
  )
}

/// new constructs an Icon for the named Material Symbol. All fields are set to defaults
///
/// ## Parameters:
/// - name: the name of the Material Symbol used in this Icon
///
pub fn new(name: String) -> Icon(msg) {
  Icon(
    name,
    False,
    default_grade,
    default_optical_size,
    none(),
    default_variant,
    default_weight,
  )
}

/// render creates an m3e-icon Lustre custom element from an Icon
///
/// ## Parameters:
/// - i: the Icon on which the element is based
/// - attributes: additional HTML attributes
/// - children: child HTML elements
///
pub fn render(
  i: Icon(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-icon",
    list.append(
      [
        name(i.name),
        filled_attr(i.filled),
        grade_attr(i.grade),
        optical_size_attr(i.optical_size),
        i.purpose,
        variant_attr(i.variant),
        weight_attr(i.weight),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

/// filled sets the `filled` field
///
pub fn filled(i: Icon(msg), f: Bool) -> Icon(msg) {
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
pub fn grade(i: Icon(msg), g: Grade) -> Icon(msg) {
  Icon(..i, grade: g)
}

fn grade_attr(g: Grade) -> Attribute(msg) {
  attribute("grade", grade_to_string(g))
}

/// optical_size checks and then sets the `optical_size` field
///
pub fn optical_size(i: Icon(msg), os: OpticalSize) -> Icon(msg) {
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
pub fn purpose(i: Icon(msg), p: Attribute(msg)) -> Icon(msg) {
  Icon(..i, purpose: p)
}

/// variant sets the `variant` field
///
pub fn variant(i: Icon(msg), v: Variant) -> Icon(msg) {
  Icon(..i, variant: v)
}

fn variant_attr(v: Variant) -> Attribute(msg) {
  attribute("variant", variant_to_string(v))
}

/// weight sets the `weight` field
///
pub fn weight(i: Icon(msg), w: Weight) -> Icon(msg) {
  Icon(..i, weight: weight_validate(w))
}

fn weight_attr(w: Weight) -> Attribute(msg) {
  attribute("weight", to_string(w))
}

fn weight_validate(weight: Weight) -> Weight {
  clamp_with_default(weight, smallest_weight, largest_weight, default_weight)
}

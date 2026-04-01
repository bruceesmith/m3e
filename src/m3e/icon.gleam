//// icon provides Lustre support for the [M3E Icon component](https://matraic.github.io/m3e/#/components/icon.html)

import gleam/int
import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers

// --- Types ---

/// Fill specifies if the icon is filled or not
/// 
pub type Fill {
  Filled
  NotFilled
}

pub const default_fill: Fill = NotFilled

/// The Grade of the variable font icon
/// [Refer](https://m3.material.io/styles/icons/applying-icons)
///
pub type Grade {
  Low
  Medium
  High
}

/// Default grade
pub const default_grade = Medium

/// Icon is the basis for a m3e-icon element that uses Material Symbols
///
/// ## Fields:
/// - name: The name of the icon
/// - fill: is the icon filled or not (the FILL axis of the variable font)
/// - grade: The grade of the icon
/// - optical_size: A value from 20 to 48 indicating the optical size of the icon
/// - purpose: the role of the icon
/// - variant:  The appearance variant of the icon
/// - weight: A value from 100 to 700 indicating the weight of the icon
///
pub opaque type Icon(msg) {
  Icon(
    name: String,
    fill: Fill,
    grade: Grade,
    optical_size: OpticalSize,
    purpose: Attribute(msg),
    variant: Variant,
    weight: Weight,
  )
}

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
/// 
pub type Variant {
  Outlined
  Rounded
  Sharp
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

// --- CONFIGURATION ---

/// Config holds the configuration for an Icon
/// 
pub type Config(msg) {
  Config(
    name: String,
    fill: Fill,
    grade: Grade,
    optical_size: OpticalSize,
    purpose: Attribute(msg),
    variant: Variant,
    weight: Weight,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config(msg) {
  Config(
    name: "",
    fill: default_fill,
    grade: default_grade,
    optical_size: default_optical_size,
    purpose: attribute.none(),
    variant: default_variant,
    weight: default_weight,
  )
}

// --- CONSTRUCTORS ---

/// new constructs an Icon for the named Material Symbol. All fields are set to defaults
///
/// ## Parameters:
/// - name: the name of the Material Symbol used in this Icon
///
pub fn new(name: String) -> Icon(msg) {
  from_config(Config(..default_config(), name: name))
}

/// from_config creates an Icon from a Config record
/// 
pub fn from_config(c: Config(msg)) -> Icon(msg) {
  Icon(
    name: c.name,
    fill: c.fill,
    grade: c.grade,
    optical_size: optical_size_validate(c.optical_size),
    purpose: c.purpose,
    variant: c.variant,
    weight: weight_validate(c.weight),
  )
}

// -- Rendering ---

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
  element.element(
    "m3e-icon",
    list.append(
      [
        attribute.name(i.name),
        filled_attr(i.fill),
        attribute.attribute("grade", grade_to_string(i.grade)),
        attribute.attribute("optical-size", int.to_string(i.optical_size)),
        i.purpose,
        attribute.attribute("variant", variant_to_string(i.variant)),
        attribute.attribute("weight", int.to_string(i.weight)),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

// --- Setters ---

/// filled sets the `fill` field
///
pub fn filled(i: Icon(msg), fill: Fill) -> Icon(msg) {
  Icon(..i, fill: fill)
}

/// grade sets the `grade` field
///
pub fn grade(i: Icon(msg), g: Grade) -> Icon(msg) {
  Icon(..i, grade: g)
}

/// optical_size checks and then sets the `optical_size` field
///
pub fn optical_size(i: Icon(msg), os: OpticalSize) -> Icon(msg) {
  Icon(..i, optical_size: optical_size_validate(os))
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

/// weight sets the `weight` field
///
pub fn weight(i: Icon(msg), w: Weight) -> Icon(msg) {
  Icon(..i, weight: weight_validate(w))
}

// --- PRIVATE HELPER FUNCTIONS ---

fn filled_attr(f: Fill) -> Attribute(msg) {
  case f {
    // NotFilled -> attribute.attribute("filled", "0")
    NotFilled -> attribute.none()
    Filled -> attribute.attribute("filled", "1")
  }
}

fn grade_to_string(grade: Grade) -> String {
  case grade {
    Low -> "low"
    Medium -> "medium"
    High -> "high"
  }
}

fn optical_size_validate(os: OpticalSize) -> OpticalSize {
  helpers.clamp_with_default(
    os,
    smallest_optical_size,
    largest_optical_size,
    default_optical_size,
  )
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Outlined -> "outlined"
    Rounded -> "rounded"
    Sharp -> "sharp"
  }
}

fn weight_validate(weight: Weight) -> Weight {
  helpers.clamp_with_default(
    weight,
    smallest_weight,
    largest_weight,
    default_weight,
  )
}

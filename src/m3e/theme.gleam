//// theme provides Lustre support for the [M3E Theme component](https://matraic.github.io/m3e/#/components/theme.html)

import gleam/int
import gleam/string.{is_empty}
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}

import m3e/helpers.{clamp_with_default}

/// Density controls layout compactness across density-aware components within a theme
///
pub type Density =
  Int

/// Smallest defined density
///
pub const smallest_density = -3

/// Largest defined density
///
pub const largest_density = 1

/// Default Density
///
pub const default_density = 0

/// Motion defines how components animate across the system
///
pub type Motion {
  Expressive
  Standard
}

fn motion_to_string(m: Motion) -> String {
  case m {
    Expressive -> "expressive"
    Standard -> "standard"
  }
}

/// Default Motion
pub const default_motion = Standard

/// Scheme specifies the color scheme
///
pub type Scheme {
  Auto
  Dark
  Light
}

fn scheme_to_string(s: Scheme) -> String {
  case s {
    Auto -> "auto"
    Dark -> "dark"
    Light -> "light"
  }
}

/// Default Scheme
///
pub const default_scheme = Auto

/// Theme is the basis for an m3e-theme component
///
/// ## Fields:
/// - color: a HEX color from which to derive color palettes
/// - density: The density of the theme
/// - motion: The motion of the theme
/// - scheme: The scheme of the theme
///
pub type Theme {
  Theme(color: String, density: Density, motion: Motion, scheme: Scheme)
}

/// basic constructs a Theme using default values
///
pub fn basic(color: String) -> Theme {
  Theme(
    color: color,
    density: default_density,
    motion: default_motion,
    scheme: default_scheme,
  )
}

/// element creates a Lustre Element from a Theme
///
pub fn element(t: Theme, children: List(Element(msg))) -> Element(msg) {
  element.element(
    "m3e-theme",
    [
      color_attr(t.color),
      density_attr(t.density),
      motion_attr(t.motion),
      scheme_attr(t.scheme),
    ],
    children,
  )
}

/// color sets the `color` field
///
pub fn color(t: Theme, hex_color: String) -> Theme {
  case is_empty(hex_color) {
    False -> Theme(..t, color: hex_color)
    True -> t
  }
}

fn color_attr(color: String) -> Attribute(msg) {
  attribute("color", color)
}

/// density sets the `density` field
///
pub fn density(t: Theme, density: Density) -> Theme {
  Theme(..t, density: density_validate(density))
}

fn density_attr(density: Density) -> Attribute(msg) {
  attribute("density", int.to_string(density))
}

/// density_validate ensures a number is within the valid density range
///
fn density_validate(d: Density) -> Density {
  clamp_with_default(d, smallest_density, largest_density, default_density)
}

/// motion sets the `motion` field
///
pub fn motion(t: Theme, motion: Motion) -> Theme {
  Theme(..t, motion: motion)
}

fn motion_attr(motion: Motion) -> Attribute(msg) {
  attribute("motion", motion_to_string(motion))
}

/// scheme sets the `scheme` field
///
pub fn scheme(t: Theme, scheme: Scheme) -> Theme {
  Theme(..t, scheme: scheme)
}

fn scheme_attr(scheme: Scheme) -> Attribute(msg) {
  attribute("scheme", scheme_to_string(scheme))
}

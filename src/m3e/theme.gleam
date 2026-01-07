//// theme provides Lustre support for the [M3E Theme component](https://matraic.github.io/m3e/#/components/theme.html)

import gleam/int
import gleam/string.{is_empty}
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute, clamp_with_default}

/// Contrast is the contrast level in which to generate a color palette
/// 
pub type Contrast {
  High
  Medium
  StandardContrast
}

fn contrast_to_string(c: Contrast) -> String {
  case c {
    High -> "high"
    Medium -> "medium"
    StandardContrast -> "standard"
  }
}

/// Default Contrast
///
pub const default_contrast = StandardContrast

///
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

/// Variant 
/// "monochrome" | "neutral" | "tonal-spot" | "vibrant" | "expressive" | "fidelity" | "rainbow" | "fruit-salad" | "content"
/// Theme is the basis for an m3e-theme component
///
/// ## Fields:
/// - color: a HEX color from which to derive color palettes
/// - contrast: The contrast level of the theme
/// - density: The density of the theme
/// - motion: The motion of the theme
/// - scheme: The scheme of the theme
/// - strong_focus: Whether to enable strong focus indicators
///
pub type Theme {
  Theme(
    color: String,
    contrast: Contrast,
    density: Density,
    motion: Motion,
    scheme: Scheme,
    strong_focus: Bool,
  )
}

/// theme constructs a Theme
/// 
/// ## Parameters:
/// - color: a HEX color from which to derive color palettes
/// - contrast: The contrast level of the theme
/// - density: The density scale (0, -1, -2)
/// - motion: The motion scheme
/// - scheme: The color scheme of the theme
/// - strong_focus: Whether to enable strong focus indicators
/// 
pub fn theme(
  color: String,
  contrast: Contrast,
  density: Density,
  motion: Motion,
  scheme: Scheme,
  strong_focus: Bool,
) -> Theme {
  Theme(
    color: color,
    contrast: contrast,
    density: density_validate(density),
    motion: motion,
    scheme: scheme,
    strong_focus: strong_focus,
  )
}

/// basic constructs a Theme using default values
///
pub fn basic(color: String) -> Theme {
  Theme(
    color: color,
    contrast: default_contrast,
    density: default_density,
    motion: default_motion,
    scheme: default_scheme,
    strong_focus: False,
  )
}

/// element creates a Lustre Element from a Theme
///
pub fn element(t: Theme, children: List(Element(msg))) -> Element(msg) {
  element.element(
    "m3e-theme",
    [
      color_attr(t.color),
      contrast_attr(t.contrast),
      density_attr(t.density),
      motion_attr(t.motion),
      scheme_attr(t.scheme),
      boolean_attribute("strong-focus", t.strong_focus),
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

/// contrast sets the `contrast` field
/// 
pub fn contrast(t: Theme, contrast: Contrast) -> Theme {
  Theme(..t, contrast: contrast)
}

fn contrast_attr(contrast: Contrast) -> Attribute(msg) {
  attribute("contrast", contrast_to_string(contrast))
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

/// strong_focus sets the `strong_focus` field
///
pub fn strong_focus(t: Theme, strong_focus: Bool) -> Theme {
  Theme(..t, strong_focus: strong_focus)
}

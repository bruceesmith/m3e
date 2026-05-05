//// Theme is a non-visual element responsible for application-level theming.
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
import m3e/color_scheme.{type ColorScheme}
import m3e/contrast_level.{type ContrastLevel}
import m3e/motion_scheme.{type MotionScheme}

// --- Types ---

/// Theme is a View Model for this component
///
/// ## Fields:
///
/// - color: The hex color from which to derive dynamic color palettes.
/// - contrast: The contrast level of the theme.
/// - density: The density scale (0, -1, -2).
/// - scheme: The color scheme of the theme.
/// - strong_focus: Whether to enable strong focus indicators.
/// - motion: The motion scheme.
///
pub opaque type Theme {
  Theme(
    color: String,
    contrast: ContrastLevel,
    density: Float,
    scheme: ColorScheme,
    strong_focus: StrongFocus,
    motion: MotionScheme,
  )
}

/// StrongFocus is whether to enable strong focus indicators.
///
pub type StrongFocus {
  IsStrongFocus
  IsNotStrongFocus
}

// --- Defaults ---

pub const default_color: String = "#6750A4"

pub const default_contrast: ContrastLevel = contrast_level.Standard

pub const default_density: Float = 0.0

pub const default_scheme: ColorScheme = color_scheme.Auto

pub const default_strong_focus: StrongFocus = IsNotStrongFocus

pub const default_motion: MotionScheme = motion_scheme.Standard

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    color: String,
    contrast: ContrastLevel,
    density: Float,
    scheme: ColorScheme,
    strong_focus: StrongFocus,
    motion: MotionScheme,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    color: "#6750A4",
    contrast: contrast_level.Standard,
    density: 0.0,
    scheme: color_scheme.Auto,
    strong_focus: IsNotStrongFocus,
    motion: motion_scheme.Standard,
  )
}

// --- Constructors ---

/// from_config creates a new Theme from the given configuration.
///
pub fn from_config(config: Config) -> Theme {
  Theme(
    color: config.color,
    contrast: config.contrast,
    density: config.density,
    scheme: config.scheme,
    strong_focus: config.strong_focus,
    motion: config.motion,
  )
}

/// new creates a new Theme with the default configuration.
///
pub fn new() -> Theme {
  from_config(default_config())
}

// --- Setters ---

/// color sets the value of color for this Theme.
///
pub fn color(record: Theme, color: String) -> Theme {
  Theme(..record, color: color)
}

/// contrast sets the value of contrast for this Theme.
///
pub fn contrast(record: Theme, contrast: ContrastLevel) -> Theme {
  Theme(..record, contrast: contrast)
}

/// density sets the value of density for this Theme.
///
pub fn density(record: Theme, density: Float) -> Theme {
  Theme(..record, density: density)
}

/// scheme sets the value of scheme for this Theme.
///
pub fn scheme(record: Theme, scheme: ColorScheme) -> Theme {
  Theme(..record, scheme: scheme)
}

/// strong_focus sets the value of strong_focus for this Theme.
///
pub fn strong_focus(record: Theme, strong_focus: StrongFocus) -> Theme {
  Theme(..record, strong_focus: strong_focus)
}

/// motion sets the value of motion for this Theme.
///
pub fn motion(record: Theme, motion: MotionScheme) -> Theme {
  Theme(..record, motion: motion)
}

// --- Renderers ---

/// render creates a Lustre Element for a Theme
///
pub fn render(
  model: Theme,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-theme",
    list.flatten([
      [
        attr.with_default("color", model.color, default_color),
        attr.with_default(
          "contrast",
          contrast_level.to_string(model.contrast),
          contrast_level.to_string(default_contrast),
        ),
        attr.with_default(
          "density",
          float.to_string(model.density),
          float.to_string(default_density),
        ),
        attr.with_default(
          "scheme",
          color_scheme.to_string(model.scheme),
          color_scheme.to_string(default_scheme),
        ),
        attr.boolean("strong-focus", model.strong_focus == IsStrongFocus),
        attr.with_default(
          "motion",
          motion_scheme.to_string(model.motion),
          motion_scheme.to_string(default_motion),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Theme Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

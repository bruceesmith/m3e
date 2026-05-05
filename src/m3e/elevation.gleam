//// Elevation is visually depicts elevation using a shadow.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/elevation_level.{type ElevationLevel}

// --- Types ---

/// Elevation is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether hover and press events will not trigger changes in elevation, when attached to an interactive element.
/// - for: The identifier of the interactive control to which this element is attached.
/// - level: The level at which to visually depict elevation.
///
pub opaque type Elevation {
  Elevation(
    disabled: Disabled,
    for: Option(String),
    level: Option(ElevationLevel),
  )
}

/// Disabled is whether hover and press events will not trigger changes in elevation, when attached to an interactive element.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_for: Option(String) = None

pub const default_level: Option(ElevationLevel) = None

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(disabled: Disabled, for: Option(String), level: Option(ElevationLevel))
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(disabled: IsNotDisabled, for: None, level: None)
}

// --- Constructors ---

/// from_config creates a new Elevation from the given configuration.
///
pub fn from_config(config: Config) -> Elevation {
  Elevation(disabled: config.disabled, for: config.for, level: config.level)
}

/// new creates a new Elevation with the default configuration.
///
pub fn new() -> Elevation {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this Elevation.
///
pub fn disabled(record: Elevation, disabled: Disabled) -> Elevation {
  Elevation(..record, disabled: disabled)
}

/// for sets the value of for for this Elevation.
///
pub fn for(record: Elevation, for: Option(String)) -> Elevation {
  Elevation(..record, for: for)
}

/// level sets the value of level for this Elevation.
///
pub fn level(record: Elevation, level: Option(ElevationLevel)) -> Elevation {
  Elevation(..record, level: level)
}

// --- Renderers ---

/// render creates a Lustre Element for a Elevation
///
pub fn render(
  model: Elevation,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-elevation",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.option(model.for, fn(_) { "for" }, function.identity, default_for),
        attr.option(
          model.level,
          fn(_) { "level" },
          elevation_level.to_string,
          default_level,
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Elevation Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

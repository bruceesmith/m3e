//// Toolbar is presents frequently used actions relevant to the current page.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/toolbar_shape.{type ToolbarShape}
import m3e/toolbar_variant.{type ToolbarVariant}

// --- Types ---

/// Toolbar is a View Model for this component
///
/// ## Fields:
///
/// - elevated: Whether the toolbar is elevated.
/// - shape: The shape of the toolbar.
/// - variant: The appearance variant of the toolbar.
/// - vertical: Whether the element is oriented vertically.
///
pub opaque type Toolbar {
  Toolbar(
    elevated: Elevated,
    shape: ToolbarShape,
    variant: ToolbarVariant,
    vertical: Vertical,
  )
}

/// Elevated is whether the toolbar is elevated.
///
pub type Elevated {
  IsElevated
  IsNotElevated
}

/// Vertical is whether the element is oriented vertically.
///
pub type Vertical {
  IsVertical
  IsNotVertical
}

// --- Defaults ---

pub const default_elevated: Elevated = IsNotElevated

pub const default_shape: ToolbarShape = toolbar_shape.Square

pub const default_variant: ToolbarVariant = toolbar_variant.Standard

pub const default_vertical: Vertical = IsNotVertical

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    elevated: Elevated,
    shape: ToolbarShape,
    variant: ToolbarVariant,
    vertical: Vertical,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    elevated: IsNotElevated,
    shape: toolbar_shape.Square,
    variant: toolbar_variant.Standard,
    vertical: IsNotVertical,
  )
}

// --- Constructors ---

/// from_config creates a new Toolbar from the given configuration.
///
pub fn from_config(config: Config) -> Toolbar {
  Toolbar(
    elevated: config.elevated,
    shape: config.shape,
    variant: config.variant,
    vertical: config.vertical,
  )
}

/// new creates a new Toolbar with the default configuration.
///
pub fn new() -> Toolbar {
  from_config(default_config())
}

// --- Setters ---

/// elevated sets the value of elevated for this Toolbar.
///
pub fn elevated(record: Toolbar, elevated: Elevated) -> Toolbar {
  Toolbar(..record, elevated: elevated)
}

/// shape sets the value of shape for this Toolbar.
///
pub fn shape(record: Toolbar, shape: ToolbarShape) -> Toolbar {
  Toolbar(..record, shape: shape)
}

/// variant sets the value of variant for this Toolbar.
///
pub fn variant(record: Toolbar, variant: ToolbarVariant) -> Toolbar {
  Toolbar(..record, variant: variant)
}

/// vertical sets the value of vertical for this Toolbar.
///
pub fn vertical(record: Toolbar, vertical: Vertical) -> Toolbar {
  Toolbar(..record, vertical: vertical)
}

// --- Renderers ---

/// render creates a Lustre Element for a Toolbar
///
pub fn render(
  model: Toolbar,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-toolbar",
    list.flatten([
      [
        attr.boolean("elevated", model.elevated == IsElevated),
        attr.with_default(
          "shape",
          toolbar_shape.to_string(model.shape),
          toolbar_shape.to_string(default_shape),
        ),
        attr.with_default(
          "variant",
          toolbar_variant.to_string(model.variant),
          toolbar_variant.to_string(default_variant),
        ),
        attr.boolean("vertical", model.vertical == IsVertical),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Toolbar Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

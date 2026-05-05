//// LoadingIndicator is shows indeterminate progress for a short wait time.
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
import m3e/loading_indicator_variant.{type LoadingIndicatorVariant}

// --- Types ---

/// LoadingIndicator is a View Model for this component
///
/// ## Fields:
///
/// - variant: The appearance variant of the indicator.
///
pub opaque type LoadingIndicator {
  LoadingIndicator(variant: LoadingIndicatorVariant)
}

// --- Defaults ---

pub const default_variant: LoadingIndicatorVariant = loading_indicator_variant.Uncontained

// --- Constructors ---

/// new creates a new LoadingIndicator with the default configuration.
///
pub fn new(variant: LoadingIndicatorVariant) -> LoadingIndicator {
  LoadingIndicator(variant: variant)
}

// --- Setters ---

/// variant sets the value of variant for this LoadingIndicator.
///
pub fn variant(
  _: LoadingIndicator,
  variant: LoadingIndicatorVariant,
) -> LoadingIndicator {
  LoadingIndicator(variant: variant)
}

// --- Renderers ---

/// render creates a Lustre Element for a LoadingIndicator
///
pub fn render(
  model: LoadingIndicator,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-loading-indicator",
    list.flatten([
      [
        attr.with_default(
          "variant",
          loading_indicator_variant.to_string(model.variant),
          loading_indicator_variant.to_string(default_variant),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

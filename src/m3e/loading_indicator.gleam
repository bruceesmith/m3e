//// loading_indicator provides Lustre support for the [M3E Loading Indicator component](https://matraic.github.io/m3e/#/components/loading-indicator.html)

import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

/// Variant is the appearance variant of the indicator
/// 
pub type Variant {
  Contained
  Uncontained
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Contained -> "contained"
    Uncontained -> "uncontained"
  }
}

pub const default_variant: Variant = Uncontained

/// LoadingIndicator shows indeterminate progress for a short wait time
/// 
/// ## Fields:
/// - variant: The appearance variant of the indicator
/// 
pub opaque type LoadingIndicator {
  LoadingIndicator(variant: Variant)
}

/// new creates a new LoadingIndicator
/// 
pub fn new() -> LoadingIndicator {
  LoadingIndicator(variant: default_variant)
}

/// render creates a Lustre Element from a LoadingIndicator
///
/// ## Parameters:
/// - l: a LoadingIndicator
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn render(
  l: LoadingIndicator,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-loading-indicator",
    flatten([
      [
        attribute("variant", variant_to_string(l.variant)),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// variant sets the variant field
/// 
pub fn variant(_: LoadingIndicator, variant: Variant) -> LoadingIndicator {
  LoadingIndicator(variant: variant)
}

//// action_list provides Lustre support for the [M3E Action List component](https://matraic.github.io/m3e/#/components/list.html)

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/list_variant.{type Variant}

// --- TYPES ---

/// ActionList provides a specialized list container for action-based interactions following Material 3 design principles
/// 
/// ## Fields:
/// - variant: The appearance variant of the list
/// 
pub opaque type ActionList {
  ActionList(variant: Variant)
}

// --- CONFIGURATION ---
// --- CONSTRUCTORS ---

/// new creates an ActionList with default values
/// 
pub fn new(variant: Variant) -> ActionList {
  ActionList(variant)
}

// --- SETTERS ---

/// variant sets the `variant` field
/// 
pub fn variant(_: ActionList, variant: Variant) -> ActionList {
  ActionList(variant: variant)
}

// --- RENDERING ---

/// render creates a Lustre Element from an ActionList
/// 
pub fn render(
  a: ActionList,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-action-list",
    list.flatten([
      [
        attribute.attribute(
          "variant",
          list_variant.variant_to_string(a.variant),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

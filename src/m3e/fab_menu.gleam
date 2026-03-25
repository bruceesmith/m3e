/// fab_menu provides Lustre support for the [M3E FAB Menu component](https://matraic.github.io/m3e/#/components/fab-menu.html)
import gleam/list

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}

// --- Types ---

/// FabMenu ia a menu, opened from a floating action button (FAB), used to display multiple related actions
/// 
/// ## Fields:
/// - id: the id of the menu, linked to the FabMenuTrigger
/// - variant: The appearance variant of the menu
/// 
pub opaque type FabMenu {
  FabMenu(id: String, variant: Variant)
}

/// Variant is the appearance variant of the menu
/// 
pub type Variant {
  Primary
  Secondary
  Tertiary
}

pub const default_variant = Primary

// --- CONSTRUCTORS ---

/// new creates a new FabMenu
/// 
pub fn new(id: String) -> FabMenu {
  FabMenu(id: id, variant: default_variant)
}

// --- SETTERS ---

/// id sets the id field
///
pub fn id(f: FabMenu, id: String) -> FabMenu {
  FabMenu(..f, id: id)
}

/// variant sets the variant field
///
pub fn variant(f: FabMenu, variant: Variant) -> FabMenu {
  FabMenu(..f, variant: variant)
}

// --- RENDERING ---

/// render creates a Lustre Element from a FabMenu
///
/// ## Parameters:
/// - f: a FabMenu
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn render(
  f: FabMenu,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-fab-menu",
    list.flatten([
      [
        attribute("id", f.id),
        attribute("variant", variant_to_string(f.variant)),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    children,
  )
}

// --- PRIVATE HELPER FUNCTIONS ---

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Primary -> "primary"
    Secondary -> "secondary"
    Tertiary -> "tertiary"
  }
}

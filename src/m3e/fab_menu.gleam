//// FabMenu is a menu, opened from a floating action button (FAB), used to display multiple related actions.
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
import m3e/fab_menu_variant.{type FabMenuVariant}

// --- Types ---

/// FabMenu is a View Model for this component
///
/// ## Fields:
///
/// - variant: The appearance variant of the menu.
///
pub opaque type FabMenu {
  FabMenu(variant: FabMenuVariant)
}

// --- Defaults ---

pub const default_variant: FabMenuVariant = fab_menu_variant.Primary

// --- Constructors ---

/// new creates a new FabMenu with the default configuration.
///
pub fn new(variant: FabMenuVariant) -> FabMenu {
  FabMenu(variant: variant)
}

// --- Setters ---

/// variant sets the value of variant for this FabMenu.
///
pub fn variant(_: FabMenu, variant: FabMenuVariant) -> FabMenu {
  FabMenu(variant: variant)
}

// --- Renderers ---

/// render creates a Lustre Element for a FabMenu
///
pub fn render(
  model: FabMenu,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-fab-menu",
    list.flatten([
      [
        attr.with_default(
          "variant",
          fab_menu_variant.to_string(model.variant),
          fab_menu_variant.to_string(default_variant),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

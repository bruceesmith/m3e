/// fab_menu_trigger provides Lustre support for the [M3E FAB Menu Trigger component](https://matraic.github.io/m3e/#/components/fab-menu.html)
import gleam/list

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}

import m3e/icon.{type Icon}

/// FabMenuTrigger is an element, nested within a clickable element, used to open a floating action button (FAB) menu
/// 
/// ## Fields:
/// - for: the id of the associated m3e-fab-menu element
/// - icon: the clickable Icon 
/// 
pub opaque type FabMenuTrigger(msg) {
  FabMenuTrigger(for: String, icon: Icon(msg))
}

/// new creates a new FabMenuTrigger
/// 
pub fn new(for: String, icon: Icon(msg)) -> FabMenuTrigger(msg) {
  FabMenuTrigger(for: for, icon: icon)
}

/// render creates a Lustre Element from a FabMenuTrigger
///
/// ## Parameters:
/// - f: a FabMenuTrigger
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn render(
  f: FabMenuTrigger(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-fab-menu-trigger",
    [attribute("for", f.for), ..attributes]
      |> list.filter(fn(a) { a != none() }),
    [f.icon |> icon.render([], []), ..children]
      |> list.filter(fn(a) { a != element.none() }),
  )
}

/// for sets the for field
/// 
pub fn for_(f: FabMenuTrigger(msg), for: String) -> FabMenuTrigger(msg) {
  FabMenuTrigger(..f, for: for)
}

/// icon sets the icon field
/// 
pub fn icon(f: FabMenuTrigger(msg), icon: Icon(msg)) -> FabMenuTrigger(msg) {
  FabMenuTrigger(..f, icon: icon)
}

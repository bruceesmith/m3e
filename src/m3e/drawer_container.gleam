//// drawer_container provides Lustre support for the [M3E DrawerContainer component](https://matraic.github.io/m3e/#/components/drawer_container.html)

import gleam/list
import lustre/attribute.{type Attribute, none}
import lustre/element.{type Element, element}

import m3e/drawer.{type Drawer, empty}

/// DrawerContainer is a responsive layout container that manages collapsible left and right drawers alongside main content
/// 
/// ## Fields:
/// - start: the start drawer
/// - end: the end drawer
///
pub opaque type DrawerContainer(msg) {
  DrawerContainer(start: Drawer(msg), end: Drawer(msg))
}

/// new creates a DrawerContainer
/// 
pub fn new() -> DrawerContainer(msg) {
  DrawerContainer(start: empty(), end: empty())
}

/// render creates a Lustre Element from a DrawerContainer
///
/// ## Parameters:
/// - c: a DrawerContainer
/// - attributes: a list of additional Attributes
/// - children: the main content
///
pub fn render(
  c: DrawerContainer(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let #(start_attrs, start_drawer) = drawer.render(c.start)
  let #(end_attrs, end_drawer) = drawer.render(c.end)

  element(
    "m3e-drawer-container",
    list.append(start_attrs, end_attrs)
      |> list.append(attributes)
      |> list.filter(fn(a) { a != none() }),
    [start_drawer]
      |> list.append(children)
      |> list.append([end_drawer]),
  )
}

/// end sets the `end` field
/// 
pub fn end(c: DrawerContainer(msg), end: Drawer(msg)) -> DrawerContainer(msg) {
  DrawerContainer(..c, end: end)
}

/// start sets the `start` field
/// 
pub fn start(
  c: DrawerContainer(msg),
  start: Drawer(msg),
) -> DrawerContainer(msg) {
  DrawerContainer(..c, start: start)
}

/// toggle_start toggles the open state of the start drawer
/// 
pub fn toggle_start(c: DrawerContainer(msg)) -> DrawerContainer(msg) {
  DrawerContainer(..c, start: drawer.toggle(c.start))
}

/// toggle_end toggles the open state of the end drawer
/// 
pub fn toggle_end(c: DrawerContainer(msg)) -> DrawerContainer(msg) {
  DrawerContainer(..c, end: drawer.toggle(c.end))
}

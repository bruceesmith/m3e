//// drawer_container provides Lustre support for the [M3E DrawerContainer component](https://matraic.github.io/m3e/#/components/drawer_container.html)

import gleam/list
import gleam/string
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}
import lustre/element/html

import m3e/drawer.{type Drawer}
import m3e/helpers.{boolean_attribute}

/// DrawerContainer is a responsive layout container that manages collapsible left and right drawers alongside main content
/// 
/// ## Fields:
/// - start: the start drawer
/// - main: the main content
/// - end: the end drawer
///
pub opaque type DrawerContainer(msg) {
  DrawerContainer(start: Drawer(msg), main: Element(msg), end: Drawer(msg))
}

/// drawer_container creates a DrawerContainer
/// 
/// ## Parameters:
/// - start: Whether the start drawer is open
/// - main: the main content
/// - end: Whether the end drawer is open
/// 
/// ## Returns:
/// A DrawerContainer
/// 
pub fn drawer_container(
  start: Drawer(msg),
  main: Element(msg),
  end: Drawer(msg),
) -> DrawerContainer(msg) {
  DrawerContainer(start: start, main: main, end: end)
}

/// element creates a Lustre Element from a DrawerContainer
///
/// ## Parameters:
/// - c: a DrawerContainer
/// - attributes: a list of additional Attributes
///
pub fn element(
  c: DrawerContainer(msg),
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  let #(start_attrs, start_drawer) = drawer.element(c.start)
  let #(end_attrs, end_drawer) = drawer.element(c.end)

  element.element(
    "m3e-drawer-container",
    list.append(start_attrs, end_attrs)
      |> list.append(attributes)
      |> list.filter(fn(a) { a != none() }),
    [
      start_drawer,
      c.main,
      end_drawer,
    ],
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

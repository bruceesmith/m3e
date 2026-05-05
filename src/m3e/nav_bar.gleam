//// NavBar is a horizontal bar, typically used on smaller devices, that allows a user to switch between 3-5 views.
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
import m3e/nav_bar_mode.{type NavBarMode}

// --- Types ---

/// NavBar is a View Model for this component
///
/// ## Fields:
///
/// - mode: The mode in which items in the bar are presented.
///
pub opaque type NavBar {
  NavBar(mode: NavBarMode)
}

// --- Defaults ---

pub const default_mode: NavBarMode = nav_bar_mode.Compact

// --- Constructors ---

/// new creates a new NavBar with the default configuration.
///
pub fn new(mode: NavBarMode) -> NavBar {
  NavBar(mode: mode)
}

// --- Setters ---

/// mode sets the value of mode for this NavBar.
///
pub fn mode(_: NavBar, mode: NavBarMode) -> NavBar {
  NavBar(mode: mode)
}

// --- Renderers ---

/// render creates a Lustre Element for a NavBar
///
pub fn render(
  model: NavBar,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-nav-bar",
    list.flatten([
      [
        attr.with_default(
          "mode",
          nav_bar_mode.to_string(model.mode),
          nav_bar_mode.to_string(default_mode),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

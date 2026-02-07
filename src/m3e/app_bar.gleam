//// app_bar provides Lustre support for the [M3E App Bar component](https://matraic.github.io/m3e/#/components/app-bar.html)

import gleam/function
import gleam/list.{filter}
import gleam/option.{type Option, None}

import lustre/attribute.{attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

/// Size is the size of the bar
/// 
pub type Size {
  Large
  Medium
  Small
}

fn size_to_string(size: Size) -> String {
  case size {
    Large -> "large"
    Medium -> "medium"
    Small -> "small"
  }
}

/// Default size
/// 
pub const default_size = Small

/// AppBar holds all information to create a App Bar
/// 
/// ## Fields:
/// - centered: Whether the title and subtitle are centered
/// - for: The identifier of the interactive control to which this element is attached
/// - size: Size of the bar
/// 
pub type AppBar {
  AppBar(centered: Bool, for: Option(String), size: Size)
}

/// new creates a new AppBar
/// 
pub fn new() -> AppBar {
  AppBar(centered: False, for: None, size: default_size)
}

/// render creates an M3E App Bar component from an AppBar
/// 
pub fn render(a: AppBar, children: List(Element(msg))) -> Element(msg) {
  element(
    "m3e-app-bar",
    [
      boolean_attribute("centered", a.centered),
      attribute("size", size_to_string(a.size)),
      option_attribute(a.for, fn(_) { "for" }, function.identity, None),
    ]
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// centered sets the centered attribute
/// 
pub fn centered(a: AppBar, centered: Bool) -> AppBar {
  AppBar(..a, centered: centered)
}

/// for sets the for attribute
/// 
pub fn for(a: AppBar, for: Option(String)) -> AppBar {
  AppBar(..a, for: for)
}

/// size sets the size attribute
/// 
pub fn size(a: AppBar, size: Size) -> AppBar {
  AppBar(..a, size: size)
}

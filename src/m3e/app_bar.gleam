//// app_bar provides Lustre support for the [M3E App Bar component](https://matraic.github.io/m3e/#/components/app-bar.html)

import gleam/function
import gleam/list.{filter}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

// --- Types ---

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

/// Size is the size of the bar
/// 
pub type Size {
  Large
  Medium
  Small
}

/// Default size
/// 
pub const default_size = Small

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  LeadingIcon
  // Renders a leading icon 
  Subtitle
  // Renders the subtitle 
  Title
  // Renders the title 
  TrailingIcon
  // Renders a trailing icon
}

// --- CONSTRUCTORS ---

/// new creates a new AppBar
/// 
pub fn new() -> AppBar {
  AppBar(centered: False, for: None, size: default_size)
}

// --- SETTERS ---

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

// --- RENDERING ---

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

/// slot creates a Lustre 'slot' attribute for a named Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    LeadingIcon -> attribute("slot", "leading-icon")
    Subtitle -> attribute("slot", "subtitle")
    Title -> attribute("slot", "title")
    TrailingIcon -> attribute("slot", "trailing-icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn size_to_string(size: Size) -> String {
  case size {
    Large -> "large"
    Medium -> "medium"
    Small -> "small"
  }
}

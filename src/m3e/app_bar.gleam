//// app_bar provides Lustre support for the [M3E App Bar component](https://matraic.github.io/m3e/#/components/app-bar.html)

import gleam/function
import gleam/list.{filter, flatten}
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute, option_attribute}

// --- Types ---

/// TitleAlignment specifies if the title and subtitle are centered
pub type TitleAlignment {
  Centered
  Standard
}

/// AppBar holds all information to create a App Bar
/// 
/// ## Fields:
/// - alignment: Whether the title and subtitle are centered
/// - for: The identifier of the interactive control to which this element is attached
/// - size: Size of the bar
/// 
pub opaque type AppBar {
  AppBar(alignment: TitleAlignment, for: Option(String), size: Size)
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

// --- CONFIGURATION ---

/// Config holds the configuration for an AppBar
/// 
pub type Config {
  Config(alignment: TitleAlignment, for: Option(String), size: Size)
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(alignment: Standard, for: None, size: default_size)
}

// --- CONSTRUCTORS ---

/// new creates a new AppBar with default values
/// 
pub fn new() -> AppBar {
  from_config(default_config())
}

/// from_config creates a new AppBar from a Config record
/// 
pub fn from_config(c: Config) -> AppBar {
  AppBar(alignment: c.alignment, for: c.for, size: c.size)
}

// --- SETTERS ---

/// alignment sets the title alignment
/// 
pub fn alignment(a: AppBar, alignment: TitleAlignment) -> AppBar {
  AppBar(..a, alignment: alignment)
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
pub fn render(
  a: AppBar,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-app-bar",
    flatten([
      [
        boolean_attribute("centered", a.alignment == Centered),
        attribute("size", size_to_string(a.size)),
        option_attribute(a.for, fn(_) { "for" }, function.identity, None),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
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

//// app_bar provides Lustre support for the [M3E App Bar component](https://matraic.github.io/m3e/#/components/app-bar.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/config.{type Size}
import m3e/helpers

// --- Types ---

/// AppBar is a prominent user interface component that provides consistent access to key actions, 
/// navigation, and contextual information at the top of an application screen
/// 
/// ## Fields:
/// - alignment: Whether the title and subtitle are centered
/// - for: The identifier of the interactive control to which this element is attached
/// - size: Size of the bar
/// 
pub opaque type AppBar {
  AppBar(alignment: TitleAlignment, for: Option(String), size: Size)
}

/// Default size
/// 
pub const default_size: Size = config.Small

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

/// TitleAlignment specifies if the title and subtitle are centered
pub type TitleAlignment {
  Centered
  Standard
}

pub const default_title_alignment: TitleAlignment = Standard

// --- CONFIGURATION ---

/// Config holds the configuration for an AppBar
/// 
pub type Config {
  Config(alignment: TitleAlignment, for: Option(String), size: Size)
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(alignment: default_title_alignment, for: None, size: default_size)
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
  AppBar(..a, size: config.clamp_to_restricted_size(size, default_size))
}

// --- RENDERING ---

/// render creates an M3E App Bar component from an AppBar
/// 
pub fn render(
  a: AppBar,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-app-bar",
    list.flatten([
      [
        helpers.boolean_attribute("centered", a.alignment == Centered),
        attribute.attribute(
          "size",
          config.size_to_string(config.clamp_to_restricted_size(
            a.size,
            default_size,
          )),
        ),
        helpers.option_attribute(a.for, fn(_) { "for" }, function.identity, None),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
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
    LeadingIcon -> attribute.attribute("slot", "leading-icon")
    Subtitle -> attribute.attribute("slot", "subtitle")
    Title -> attribute.attribute("slot", "title")
    TrailingIcon -> attribute.attribute("slot", "trailing-icon")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

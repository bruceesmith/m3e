//// slide_group provides Lustre support for the [M3E Slide Group component](https://matraic.github.io/m3e/#/components/slide_group.html)

import gleam/int
import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/layout.{type Orientation, Vertical}
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// SlideGroup provides Lustre support for the [M3E Slide Group component](https://matraic.github.io/m3e/#/components/slide_group.html)
/// 
/// ## Fields:
/// - disabled: Whether scroll buttons are disabled
/// - next_page_label: The accessible label given to the button used to move to the previous page
/// - previous_page_label: The accessible label given to the button used to move to the next page
/// - threshold: A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls
/// - vertical: Whether content is oriented vertically
///
pub opaque type SlideGroup {
  SlideGroup(
    disabled: Interaction,
    next_page_label: String,
    previous_page_label: String,
    threshold: Int,
    vertical: Orientation,
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  NextIcon
  // Renders the icon to present for the next button 
  PrevIcon
  // Renders the icon to present for the previous button 
}

// --- CONFIGURATION ---

/// Config holds the configuration for a SlideGroup
/// 
pub type Config {
  Config(
    disabled: Interaction,
    next_page_label: String,
    previous_page_label: String,
    threshold: Int,
    vertical: Orientation,
  )
}

pub const default_next_page_label: String = "Next page"

pub const default_previous_page_label: String = "Previous page"

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    disabled: state.default_interaction,
    next_page_label: default_next_page_label,
    previous_page_label: default_previous_page_label,
    threshold: 0,
    vertical: layout.default_orientation,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new SlideGroup with default values
/// 
pub fn new() -> SlideGroup {
  from_config(default_config())
}

/// from_config creates a SlideGroup from a Config record
/// 
pub fn from_config(c: Config) -> SlideGroup {
  SlideGroup(
    disabled: c.disabled,
    next_page_label: c.next_page_label,
    previous_page_label: c.previous_page_label,
    threshold: c.threshold,
    vertical: c.vertical,
  )
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(s: SlideGroup, disabled: Interaction) -> SlideGroup {
  SlideGroup(..s, disabled: disabled)
}

/// next_page_label sets the next_page_label field
/// 
pub fn next_page_label(s: SlideGroup, next_page_label: String) -> SlideGroup {
  SlideGroup(..s, next_page_label: next_page_label)
}

/// previous_page_label sets the previous_page_label field
/// 
pub fn previous_page_label(
  s: SlideGroup,
  previous_page_label: String,
) -> SlideGroup {
  SlideGroup(..s, previous_page_label: previous_page_label)
}

/// threshold sets the threshold field
/// 
pub fn threshold(s: SlideGroup, threshold: Int) -> SlideGroup {
  SlideGroup(..s, threshold: threshold)
}

/// vertical sets the vertical field
/// 
pub fn vertical(s: SlideGroup, vertical: Orientation) -> SlideGroup {
  SlideGroup(..s, vertical: vertical)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a SlideGroup
/// 
/// ## Parameters:
/// - s: a SlideGroup
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  s: SlideGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-slide-group",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", s.disabled == Disabled),
        attribute.attribute("next-page-label", s.next_page_label),
        attribute.attribute("previous-page-label", s.previous_page_label),
        attribute.attribute("threshold", int.to_string(s.threshold)),
        helpers.boolean_attribute("vertical", s.vertical == Vertical),
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

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    NextIcon -> attribute.attribute("slot", "next-icon")
    PrevIcon -> attribute.attribute("slot", "prev-icon")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

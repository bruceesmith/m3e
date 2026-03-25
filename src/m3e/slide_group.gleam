//// slide_group provides Lustre support for the [M3E Slide Group component](https://matraic.github.io/m3e/#/components/slide_group.html)

import gleam/int
import gleam/list

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}
import m3e/layout.{type Orientation, Vertical}
import m3e/state.{type Interaction, Disabled}

// --- Types ---

/// SlideGroup provides Lustre support for the [M3E Slide Group component](https://matraic.github.io/m3e/#/components/slide_group.html)
/// 
/// ## Fields:
/// - interaction: Whether scroll buttons are enabled or disabled
/// - next_page_label: The accessible label given to the button used to move to the previous page
/// - previous_page_label: The accessible label given to the button used to move to the next page
/// - threshold: A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls
/// - orientation: Whether content is oriented vertically or horizontally
///
pub opaque type SlideGroup {
  SlideGroup(
    interaction: Interaction,
    next_page_label: String,
    previous_page_label: String,
    threshold: Int,
    orientation: Orientation,
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
    interaction: Interaction,
    next_page_label: String,
    previous_page_label: String,
    threshold: Int,
    orientation: Orientation,
  )
}

pub const default_next_page_label: String = "Next page"

pub const default_previous_page_label: String = "Previous page"

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    interaction: state.default_interaction,
    next_page_label: default_next_page_label,
    previous_page_label: default_previous_page_label,
    threshold: 0,
    orientation: layout.default_orientation,
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
    interaction: c.interaction,
    next_page_label: c.next_page_label,
    previous_page_label: c.previous_page_label,
    threshold: c.threshold,
    orientation: c.orientation,
  )
}

// --- SETTERS ---

/// disabled sets the interaction field
/// 
pub fn disabled(s: SlideGroup, interaction: Interaction) -> SlideGroup {
  SlideGroup(..s, interaction: interaction)
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

/// vertical sets the orientation field
/// 
pub fn vertical(s: SlideGroup, orientation: Orientation) -> SlideGroup {
  SlideGroup(..s, orientation: orientation)
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
        boolean_attribute("disabled", s.interaction == Disabled),
        attribute("next-page-label", s.next_page_label),
        attribute("previous-page-label", s.previous_page_label),
        attribute("threshold", int.to_string(s.threshold)),
        boolean_attribute("vertical", s.orientation == Vertical),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
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
    NextIcon -> attribute("slot", "next-icon")
    PrevIcon -> attribute("slot", "prev-icon")
  }
}
// --- PRIVATE INTERNAL HELPERS ---

//// SlideGroup is presents pagination controls used to scroll overflowing content.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/float
import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr

// --- Types ---

/// SlideGroup is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether scroll buttons are disabled.
/// - next_page_label: The accessible label given to the button used to move to the next page.
/// - previous_page_label: The accessible label given to the button used to move to the previous page.
/// - threshold: A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls.
/// - vertical: Whether content is oriented vertically.
///
pub opaque type SlideGroup {
  SlideGroup(
    disabled: Disabled,
    next_page_label: String,
    previous_page_label: String,
    threshold: Float,
    vertical: Vertical,
  )
}

/// Disabled is whether scroll buttons are disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// Vertical is whether content is oriented vertically.
///
pub type Vertical {
  IsVertical
  IsNotVertical
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_next_page_label: String = "Next page"

pub const default_previous_page_label: String = "Previous page"

pub const default_threshold: Float = 0.0

pub const default_vertical: Vertical = IsNotVertical

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  NextIcon
  // Renders the icon to present for the next button.
  PrevIcon
  // Renders the icon to present for the previous button.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    next_page_label: String,
    previous_page_label: String,
    threshold: Float,
    vertical: Vertical,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disabled: IsNotDisabled,
    next_page_label: "Next page",
    previous_page_label: "Previous page",
    threshold: 0.0,
    vertical: IsNotVertical,
  )
}

// --- Constructors ---

/// from_config creates a new SlideGroup from the given configuration.
///
pub fn from_config(config: Config) -> SlideGroup {
  SlideGroup(
    disabled: config.disabled,
    next_page_label: config.next_page_label,
    previous_page_label: config.previous_page_label,
    threshold: config.threshold,
    vertical: config.vertical,
  )
}

/// new creates a new SlideGroup with the default configuration.
///
pub fn new() -> SlideGroup {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this SlideGroup.
///
pub fn disabled(record: SlideGroup, disabled: Disabled) -> SlideGroup {
  SlideGroup(..record, disabled: disabled)
}

/// next_page_label sets the value of next_page_label for this SlideGroup.
///
pub fn next_page_label(
  record: SlideGroup,
  next_page_label: String,
) -> SlideGroup {
  SlideGroup(..record, next_page_label: next_page_label)
}

/// previous_page_label sets the value of previous_page_label for this SlideGroup.
///
pub fn previous_page_label(
  record: SlideGroup,
  previous_page_label: String,
) -> SlideGroup {
  SlideGroup(..record, previous_page_label: previous_page_label)
}

/// threshold sets the value of threshold for this SlideGroup.
///
pub fn threshold(record: SlideGroup, threshold: Float) -> SlideGroup {
  SlideGroup(..record, threshold: threshold)
}

/// vertical sets the value of vertical for this SlideGroup.
///
pub fn vertical(record: SlideGroup, vertical: Vertical) -> SlideGroup {
  SlideGroup(..record, vertical: vertical)
}

// --- Renderers ---

/// render creates a Lustre Element for a SlideGroup
///
pub fn render(
  model: SlideGroup,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-slide-group",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.with_default(
          "next-page-label",
          model.next_page_label,
          default_next_page_label,
        ),
        attr.with_default(
          "previous-page-label",
          model.previous_page_label,
          default_previous_page_label,
        ),
        attr.with_default(
          "threshold",
          float.to_string(model.threshold),
          float.to_string(default_threshold),
        ),
        attr.boolean("vertical", model.vertical == IsVertical),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a SlideGroup Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    NextIcon -> attribute.attribute("slot", "next-icon")
    PrevIcon -> attribute.attribute("slot", "prev-icon")
  }
}

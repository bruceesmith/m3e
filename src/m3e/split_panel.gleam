//// split_panel provides Lustre support for the [M3E Split Panel component](https://matraic.github.io/m3e/#/components/split-panel.html)

import gleam/int
import gleam/list
import gleam/result

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers

// --- Types ---

/// Orientation is the orientation of the split panel.
///
pub type Orientation {
  Auto
  Horizontal
  Vertical
}

pub const default_orientation = Horizontal

/// split_panel is a  dual-view layout that separates content with a movable drag handle
///
/// - detents: Detents (discrete sizes) the start pane can snap to.
/// - label: The accessible label given to the moveable drag handle.
/// - max: A fractional value, between 0 and 100, indicating the maximum size of the start pane.
/// - min: A fractional value, between 0 and 100, indicating the minimum size of the start pane.
/// - orientation: The orientation of the split.
/// - step: A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard.
/// - value: A fractional value, between 0 and 100, indicating the size of the start pane.
/// - wrap-detents: Whether cycling through detents will wrap.
///
pub opaque type SplitPanel {
  SplitPanel(
    detents: List(Int),
    label: String,
    max: Int,
    min: Int,
    orientation: Orientation,
    step: Int,
    value: Int,
    wrap_detents: Bool,
  )
}

pub const default_label = "Resize panes"

pub const default_min = 0

pub const default_max = 100

pub const default_step = 1

pub const default_value = 50

/// Slot gives type-safe names to each of the defined HTML named slots
///
pub type Slot {
  Start
  //Renders content at the logical start side of the pane
  End
  // Renders content at the logical end side of the pane
}

// --- Configuration ---

/// Config for a split panel.
///
/// - detents: Detents (discrete sizes) the start pane can snap to.
/// - label: The accessible label given to the moveable drag handle.
/// - max: A fractional value, between 0 and 100, indicating the maximum size of the start pane.
/// - min: A fractional value, between 0 and 100, indicating the minimum size of the start pane.
/// - orientation: The orientation of the split.
/// - step: A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard.
/// - value: A fractional value, between 0 and 100, indicating the size of the start pane.
/// - wrap-detents: Whether cycling through detents will wrap.
///
pub type Config {
  Config(
    detents: List(Int),
    label: String,
    max: Int,
    min: Int,
    orientation: Orientation,
    step: Int,
    value: Int,
    wrap_detents: Bool,
  )
}

/// default_config creates a new split panel with default configuration.
pub fn default_config() -> Config {
  Config(
    detents: [],
    label: default_label,
    max: default_max,
    min: default_min,
    orientation: default_orientation,
    step: default_step,
    value: default_value,
    wrap_detents: False,
  )
}

// --- Constructors ---

/// from_config creates a new split panel from a config.
pub fn from_config(config: Config) -> SplitPanel {
  SplitPanel(
    detents: config.detents,
    label: config.label,
    max: helpers.clamp_with_default(
      config.max,
      default_min,
      default_max,
      default_max,
    ),
    min: helpers.clamp_with_default(
      config.min,
      default_min,
      default_max,
      default_min,
    ),
    orientation: config.orientation,
    step: helpers.clamp_with_default(
      config.step,
      default_min,
      default_max,
      default_step,
    ),
    value: helpers.clamp_with_default(
      config.value,
      default_min,
      default_max,
      default_value,
    ),
    wrap_detents: config.wrap_detents,
  )
}

/// new creates a new split panel.
///
pub fn new() -> SplitPanel {
  from_config(default_config())
}

// -- SETTERS ---

/// detents sets the detents of the split panel.
///
pub fn detents(sp: SplitPanel, detents: List(Int)) -> SplitPanel {
  SplitPanel(..sp, detents: detents)
}

/// label sets the label of the split panel.
///
pub fn label(sp: SplitPanel, label: String) -> SplitPanel {
  SplitPanel(..sp, label: label)
}

/// max sets the max value of the split panel.
///
pub fn max(sp: SplitPanel, max: Int) -> SplitPanel {
  SplitPanel(
    ..sp,
    max: helpers.clamp_with_default(max, default_min, default_max, default_max),
  )
}

/// min sets the min value of the split panel.
///
pub fn min(sp: SplitPanel, min: Int) -> SplitPanel {
  SplitPanel(
    ..sp,
    min: helpers.clamp_with_default(min, default_min, default_max, default_min),
  )
}

/// orientation sets the orientation of the split panel.
///
pub fn orientation(sp: SplitPanel, orientation: Orientation) -> SplitPanel {
  SplitPanel(..sp, orientation: orientation)
}

/// step sets the step of the split panel.
///
pub fn step(sp: SplitPanel, step: Int) -> SplitPanel {
  SplitPanel(
    ..sp,
    step: helpers.clamp_with_default(
      step,
      default_min,
      default_max,
      default_step,
    ),
  )
}

/// value sets the value of the split panel.
///
pub fn value(sp: SplitPanel, value: Int) -> SplitPanel {
  SplitPanel(
    ..sp,
    value: helpers.clamp_with_default(
      value,
      default_min,
      default_max,
      default_value,
    ),
  )
}

/// wrap_detents sets whether the detents should wrap around.
///
pub fn wrap_detents(sp: SplitPanel, wrap_detents: Bool) -> SplitPanel {
  SplitPanel(..sp, wrap_detents: wrap_detents)
}

// --- RENDERING ---

/// render renders the split panel.
///
pub fn render(
  sp: SplitPanel,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let detents =
    list.reduce(list.map(sp.detents, int.to_string), fn(acc, x) {
      acc <> " " <> x
    })
    |> result.unwrap("")
  element.element(
    "m3e-split-panel",
    list.flatten([
      [
        helpers.attribute_with_default("detents", detents, ""),
        helpers.attribute_with_default("label", sp.label, default_label),
        helpers.attribute_with_default(
          "max",
          int.to_string(sp.max),
          int.to_string(default_max),
        ),
        helpers.attribute_with_default(
          "min",
          int.to_string(sp.min),
          int.to_string(default_min),
        ),
        helpers.attribute_with_default(
          "orientation",
          orientation_to_string(sp.orientation),
          orientation_to_string(default_orientation),
        ),
        helpers.attribute_with_default(
          "step",
          int.to_string(sp.step),
          int.to_string(default_step),
        ),
        helpers.attribute_with_default(
          "value",
          int.to_string(sp.value),
          int.to_string(default_value),
        ),
        helpers.boolean_attribute("wrap-detents", sp.wrap_detents),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config renders the split panel with a custom configuration.
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
    Start -> attribute.name("start")
    End -> attribute.name("end")
  }
}

// --- PRIVATE HELPER FUNCTIONS ---

fn orientation_to_string(orientation: Orientation) -> String {
  case orientation {
    Auto -> "auto"
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
}

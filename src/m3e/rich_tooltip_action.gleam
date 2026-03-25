//// rich_tooltip_action provides Lustre support for the M3E Rich Tooltip Action component
//// https://matraic.github.io/m3e/#/components/tooltip.html

//  * @attr disable-restore-focus - Whether to focus should not be restored to the trigger when activated.

import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// RichTooltip is an element, nested within a clickable element, used to dismiss a parenting rich tooltip
///
/// ## Fields:
/// - disable_restore_focus: Whether to focus should not be restored to the trigger when activated
///
pub opaque type RichTooltip {
  RichTooltip(disable_restore_focus: Bool)
}

// --- Configuration ---

/// Config is the configuration of a RichTooltip
///
pub type Config {
  Config(disable_restore_focus: Bool)
}

/// default_config creates a Config with default values
///
pub fn default_config() -> Config {
  Config(disable_restore_focus: False)
}

// --- Constructors ---

/// from_config creates a RichTooltip from a Config
///
pub fn from_config(config: Config) -> RichTooltip {
  RichTooltip(disable_restore_focus: config.disable_restore_focus)
}

/// new creates a RichTooltip with default values
/// 
pub fn new() -> RichTooltip {
  RichTooltip(disable_restore_focus: False)
}

// --- Setters ---

/// disable_restore_focus sets the `disable_restore_focus` field
///
pub fn disable_restore_focus(
  _: RichTooltip,
  disable_restore_focus: Bool,
) -> RichTooltip {
  RichTooltip(disable_restore_focus: disable_restore_focus)
}

// --- Rendering ---

/// render creates a Lustre Element from a RichTooltip
///
pub fn render(
  r: RichTooltip,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-rich-tooltip",
    list.append(
      [
        boolean_attribute("disable-restore-focus", r.disable_restore_focus),
      ],
      attributes,
    )
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}
// --- PRIVATE INTERNAL HELPERS --- 

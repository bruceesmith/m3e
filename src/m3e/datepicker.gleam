//// datepicker provides Lustre support for the [M3E Datepicker component](https://matraic.github.io/m3e/#/components/datepicker.html)

import gleam/list
import m3e/calendar.{type Calendar}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers

// --- Types ---

/// Datepicker provides a date‑selection experience consistent with Material 3 guidance for layout, motion, and accessibility
///
/// ## Fields:
/// - variant: The appearance variant of the picker.
/// - clearable: Whether the user can clear the selected date and close the picker.
/// - calendar: The calendar of the date picker.
/// - clear_label: The label given to the button used clear the selected date and close the picker.
/// - confirm_label: The label given to the button used apply the selected date and close the picker.
/// - dismiss_label: The label given to the button used discard the selected date and close the picker.
/// - label: The label given to the the picker.
///
pub opaque type Datepicker {
  Datepicker(
    variant: Variant,
    clearable: Bool,
    calendar: Calendar,
    clear_label: String,
    confirm_label: String,
    dismiss_label: String,
    label: String,
  )
}

pub const default_clear_label = "Clear"

pub const default_confirm_label = "OK"

pub const default_dismiss_label = "Cancel"

pub const default_label = "Select date"

/// The appearance variant of the picker.
pub type Variant {
  Auto
  Docked
  Modal
}

// --- CONFIGURATION ---

/// Configuration for the datepicker.
///
pub type Config {
  Config(
    variant: Variant,
    clearable: Bool,
    calendar: Calendar,
    clear_label: String,
    confirm_label: String,
    dismiss_label: String,
    label: String,
  )
}

/// default_config returns the default configuration for the datepicker.
///
pub fn default_config() -> Config {
  Config(
    variant: Auto,
    clearable: False,
    calendar: calendar.new(),
    clear_label: default_clear_label,
    confirm_label: default_confirm_label,
    dismiss_label: default_dismiss_label,
    label: default_label,
  )
}

// --- CONSTRUCTORS ---

/// from_config returns a new datepicker with the given configuration.
///
pub fn from_config(config: Config) -> Datepicker {
  Datepicker(
    variant: config.variant,
    clearable: config.clearable,
    calendar: config.calendar,
    clear_label: config.clear_label,
    confirm_label: config.confirm_label,
    dismiss_label: config.dismiss_label,
    label: config.label,
  )
}

/// new returns a new datepicker with the given configuration.
///
pub fn new() -> Datepicker {
  from_config(default_config())
}

// --- SETTERS ---

/// variant sets the `variant` field
///
pub fn variant(c: Datepicker, variant: Variant) -> Datepicker {
  Datepicker(..c, variant: variant)
}

/// clearable sets the `clearable` field
///
pub fn clearable(c: Datepicker, clearable: Bool) -> Datepicker {
  Datepicker(..c, clearable: clearable)
}

/// clear_label sets the `clear_label` field
///
pub fn clear_label(c: Datepicker, clear_label: String) -> Datepicker {
  Datepicker(..c, clear_label: clear_label)
}

/// confirm_label sets the `confirm_label` field
///
pub fn confirm_label(c: Datepicker, confirm_label: String) -> Datepicker {
  Datepicker(..c, confirm_label: confirm_label)
}

/// dismiss_label sets the `dismiss_label` field
///
pub fn dismiss_label(c: Datepicker, dismiss_label: String) -> Datepicker {
  Datepicker(..c, dismiss_label: dismiss_label)
}

/// label sets the `label` field
///
pub fn label(c: Datepicker, label: String) -> Datepicker {
  Datepicker(..c, label: label)
}

/// calendar sets the `calendar` field
///
pub fn calendar(c: Datepicker, calendar: Calendar) -> Datepicker {
  Datepicker(..c, calendar: calendar)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Calendar
///
pub fn render(c: Datepicker, attributes: List(Attribute(msg))) -> Element(msg) {
  element.element(
    "m3e-datepicker",
    list.flatten([
      [
        attribute.attribute("variant", variant_to_string(c.variant)),
        helpers.boolean_attribute("clearable", c.clearable),
        helpers.attribute_with_default(
          "clear-label",
          c.clear_label,
          default_clear_label,
        ),
        helpers.attribute_with_default(
          "confirm-label",
          c.confirm_label,
          default_confirm_label,
        ),
        helpers.attribute_with_default(
          "dismiss-label",
          c.dismiss_label,
          default_dismiss_label,
        ),
        helpers.attribute_with_default("label", c.label, default_label),
      ],
      calendar.attributes(c.calendar),
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    [],
  )
}

/// render_config creates a Lustre Element(msg) from a Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  render(from_config(c), attributes)
}

// --- PRIVATE HELPER FUNCTIONS ---

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Auto -> "auto"
    Docked -> "docked"
    Modal -> "modal"
  }
}

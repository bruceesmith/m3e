//// bottom_sheet_trigger provides Lustre support for the [M3E Bottom Sheet Trigger component](https://matraic.github.io/m3e/#/components/bottom-sheet.html)

import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}

import lustre/attribute
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}

// --- Types ---

/// BottomSheetTrigger is an element, nested within a clickable element, used to trigger a bottom sheet
/// 
/// ## Fields:
/// - detent: The zero‑based index of the detent the sheet should open to.
/// - for: the ID of the associated BottomSheet.
/// - label: the label of the trigger
/// - role: Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership
pub opaque type BottomSheetTrigger {
  BottomSheetTrigger(
    detent: Option(Int),
    for: String,
    label: String,
    role: TriggerRole,
  )
}

/// TriggerRole specifies if a trigger is primary or secondary for accessibility
pub type TriggerRole {
  Primary
  Secondary
}

pub const default_trigger_role: TriggerRole = Primary

// --- CONFIGURATION ---

/// Config holds the configuration for a BottomSheetTrigger
/// 
pub type Config {
  Config(detent: Option(Int), for: String, label: String, role: TriggerRole)
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(detent: None, for: "", label: "", role: default_trigger_role)
}

// --- CONSTRUCTORS ---

/// new creates a new BottomSheetTrigger with default values
///
pub fn new() -> BottomSheetTrigger {
  from_config(default_config())
}

/// from_config creates a BottomSheetTrigger from a Config record
/// 
pub fn from_config(c: Config) -> BottomSheetTrigger {
  BottomSheetTrigger(detent: c.detent, for: c.for, label: c.label, role: c.role)
}

// --- SETTERS ---

/// detent sets the detent field of a BottomSheetTrigger
/// 
pub fn detent(b: BottomSheetTrigger, detent: Option(Int)) -> BottomSheetTrigger {
  BottomSheetTrigger(..b, detent: detent)
}

/// for sets the for field of a BottomSheetTrigger
/// 
pub fn for(b: BottomSheetTrigger, for: String) -> BottomSheetTrigger {
  BottomSheetTrigger(..b, for: for)
}

/// label sets the label field of a BottomSheetTrigger
/// 
pub fn label(b: BottomSheetTrigger, label: String) -> BottomSheetTrigger {
  BottomSheetTrigger(..b, label: label)
}

/// role sets the role field of a BottomSheetTrigger
/// 
pub fn role(b: BottomSheetTrigger, role: TriggerRole) -> BottomSheetTrigger {
  BottomSheetTrigger(..b, role: role)
}

// --- RENDERING ---

/// render creates a Lustre Element from a BottomSheetTrigger
///
pub fn render(b: BottomSheetTrigger) -> Element(msg) {
  element.element(
    "m3e-bottom-sheet-trigger",
    [
      case b.detent {
        Some(d) -> attribute.attribute("detent", int.to_string(d))
        None -> attribute.none()
      },
      attribute.attribute("for", b.for),
      boolean_attribute("secondary", b.role == Secondary),
    ]
      |> list.filter(fn(a) { a != attribute.none() }),
    [element.text(b.label)],
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(config: Config) -> Element(msg) {
  render(from_config(config))
}
// --- PRIVATE INTERNAL HELPERS ---

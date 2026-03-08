//// bottom_sheet_trigger provides Lustre support for the [M3E Bottom Sheet Trigger component](https://matraic.github.io/m3e/#/components/bottom-sheet.html)

import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}

import lustre/attribute.{attribute, none}
import lustre/element.{type Element, element, text}

import m3e/helpers.{boolean_attribute}

/// BottomSheetTrigger is an element, nested within a clickable element, used to trigger a bottom sheet
/// 
/// ## Fields:
/// - detent: The zero‑based index of the detent the sheet should open to.
/// - for: the ID of the associated BottomSheet.
/// - label: the label of the trigger
/// - secondary: Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership
pub opaque type BottomSheetTrigger {
  BottomSheetTrigger(
    detent: Option(Int),
    for: String,
    label: String,
    secondary: Bool,
  )
}

/// new creates a new BottomSheetTrigger
///
pub fn new() -> BottomSheetTrigger {
  BottomSheetTrigger(detent: None, for: "", label: "", secondary: False)
}

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

/// secondary sets the secondary field of a BottomSheetTrigger
/// 
pub fn secondary(b: BottomSheetTrigger, secondary: Bool) -> BottomSheetTrigger {
  BottomSheetTrigger(..b, secondary: secondary)
}

/// render creates a Lustre Element from a BottomSheetTrigger
///
pub fn render(b: BottomSheetTrigger) -> Element(msg) {
  element(
    "m3e-bottom-sheet-trigger",
    [
      case b.detent {
        Some(d) -> attribute("detent", int.to_string(d))
        None -> none()
      },
      attribute("for", b.for),
      boolean_attribute("secondary", b.secondary),
    ]
      |> list.filter(fn(a) { a != none() }),
    [text(b.label)],
  )
}

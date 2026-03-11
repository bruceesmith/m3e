//// bottom_sheet provides Lustre support for the [M3E Bottom Sheet component](https://matraic.github.io/m3e/#/components/bottom-sheet.html)

import gleam/float
import gleam/int
import gleam/list.{filter, map}
import gleam/string.{join}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import m3e/helpers.{boolean_attribute}

// --- Types ---

/// BottomSheet is a sheet used to show secondary content anchored to the bottom of the screen
/// 
/// ## Fields:
/// - detent: The zero‑based index of the detent the sheet should open to.
/// - detents: Detents (discrete height states) the sheet can snap to.
/// - handle: Whether to display a drag handle and enable the top region of the sheet as a gesture surface for dragging between detents.
/// - handle_label: The accessible label given to the drag handle.
/// - hideable: Whether the bottom sheet can hide when its swiped down.
/// - hide_friction: The friction coefficient to hide the sheet, or set it to the next closest expanded detent.
/// - id: The identifier of the bottom sheet.
/// - modal: Whether the bottom sheet behaves as modal.
/// - open: Whether the bottom sheet is open
/// 
pub opaque type BottomSheet {
  BottomSheet(
    detent: Int,
    detents: List(Detent),
    handle: Bool,
    handle_label: String,
    hideable: Bool,
    hide_friction: Float,
    id: String,
    modal: Bool,
    open: Bool,
  )
}

pub const default_hide_friction: Float = 0.5

/// Detent define the vertical positions a bottom sheet can rest at. 
/// A sheet may have no detents, a single detent, or multiple detents. 
/// Detents control how the sheet resizes, how it responds to drag gestures, and how the handle button behaves
/// 
pub type Detent {
  Collapsed
  Fit
  Half
  Full
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Header
  // Renders the header of the sheet 
}

// --- CONSTRUCTORS ---

/// new creates a new BottomSheet
/// 
pub fn new() -> BottomSheet {
  BottomSheet(
    detent: 0,
    detents: [],
    handle: False,
    handle_label: "",
    hideable: False,
    hide_friction: default_hide_friction,
    id: "",
    modal: False,
    open: False,
  )
}

// --- SETTERS ---

/// detent sets the detent field of a BottomSheet
/// 
pub fn detent(b: BottomSheet, detent: Int) -> BottomSheet {
  BottomSheet(..b, detent: detent)
}

/// detents sets the detents field of a BottomSheet
/// 
pub fn detents(b: BottomSheet, detents: List(Detent)) -> BottomSheet {
  BottomSheet(..b, detents: detents)
}

/// handle sets the handle field of a BottomSheet
/// 
pub fn handle(b: BottomSheet, handle: Bool) -> BottomSheet {
  BottomSheet(..b, handle: handle)
}

/// handle_label sets the handle_label field of a BottomSheet
/// 
pub fn handle_label(b: BottomSheet, handle_label: String) -> BottomSheet {
  BottomSheet(..b, handle_label: handle_label)
}

/// hideable sets the hideable field of a BottomSheet
/// 
pub fn hideable(b: BottomSheet, hideable: Bool) -> BottomSheet {
  BottomSheet(..b, hideable: hideable)
}

/// hide_friction sets the hide_friction field of a BottomSheet
/// 
pub fn hide_friction(b: BottomSheet, hide_friction: Float) -> BottomSheet {
  BottomSheet(..b, hide_friction: hide_friction)
}

/// id sets the id field of a BottomSheet
/// 
pub fn id(b: BottomSheet, id: String) -> BottomSheet {
  BottomSheet(..b, id: id)
}

/// modal sets the modal field of a BottomSheet
/// 
pub fn modal(b: BottomSheet, modal: Bool) -> BottomSheet {
  BottomSheet(..b, modal: modal)
}

/// open sets the open field of a BottomSheet
/// 
pub fn open(b: BottomSheet, open: Bool) -> BottomSheet {
  BottomSheet(..b, open: open)
}

// --- RENDERING ---

/// render creates a Lustre Element from a BottomSheet
///
pub fn render(b: BottomSheet, children: List(Element(msg))) -> Element(msg) {
  element(
    "m3e-bottom-sheet",
    [
      attribute("detent", int.to_string(b.detent)),
      case b.detents {
        [] -> none()
        _ -> attribute("detents", join(map(b.detents, detent_to_string), " "))
      },
      boolean_attribute("handle", b.handle),
      attribute("handle-label", b.handle_label),
      boolean_attribute("hideable", b.hideable),
      attribute("hide-friction", float.to_string(b.hide_friction)),
      attribute("id", b.id),
      boolean_attribute("modal", b.modal),
      boolean_attribute("open", b.open),
    ]
      |> filter(fn(a) { a != none() }),
    children,
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Header -> attribute("slot", "header")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn detent_to_string(d: Detent) -> String {
  case d {
    Collapsed -> "collapsed"
    Fit -> "fit"
    Half -> "half"
    Full -> "full"
  }
}

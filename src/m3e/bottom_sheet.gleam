//// bottom_sheet provides Lustre support for the [M3E Bottom Sheet component](https://matraic.github.io/m3e/#/components/bottom-sheet.html)

import gleam/float
import gleam/int
import gleam/list
import gleam/string

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/helpers

// --- Types ---

/// BottomSheet is a sheet used to show secondary content anchored to the bottom of the screen
/// 
/// ## Fields:
/// - detent: The zero‑based index of the detent the sheet should open to.
/// - detents: Detents (discrete height states) the sheet can snap to.
/// - handle: Whether to display a drag handle and enable the top region of the sheet as a gesture surface for dragging between detents.
/// - handle_label: The accessible label given to the drag handle.
/// - hideable: Whether the bottom sheet can hide when it is swiped down.
/// - hide_friction: The friction coefficient to hide the sheet, or set it to the next closest expanded detent.
/// - id: The identifier of the bottom sheet.
/// - modal: Whether the bottom sheet behaves as modal.
/// - state: Whether the bottom sheet is open
/// 
pub opaque type BottomSheet {
  BottomSheet(
    detent: Int,
    detents: List(Detent),
    handle: Handle,
    handle_label: String,
    hideable: Hideable,
    hide_friction: Float,
    id: String,
    modal: Modal,
    state: State,
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

/// Handle determines if the drag handle is shown
/// 
pub type Handle {
  ShowHandle
  NoHandle
}

pub const default_handle: Handle = NoHandle

/// Hideable determines if the sheet can be hidden by swiping
/// 
pub type Hideable {
  Hideable
  NotHideable
}

pub const default_hideable: Hideable = NotHideable

/// Modal determines if the sheet is modal
/// 
pub type Modal {
  Modal
  Standard
}

pub const default_modal: Modal = Standard

/// State determines if the sheet is open or closed
/// 
pub type State {
  Open
  Closed
}

pub const default_state: State = Closed

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Header
  // Renders the header of the sheet 
}

// --- CONFIGURATION ---

/// Config allows for a declarative configuration of the BottomSheet
/// 
pub type Config {
  Config(
    detent: Int,
    detents: List(Detent),
    handle: Handle,
    handle_label: String,
    hideable: Hideable,
    hide_friction: Float,
    id: String,
    modal: Modal,
    state: State,
  )
}

/// default_config returns a default Config
/// 
pub fn default_config() -> Config {
  Config(
    detent: 0,
    detents: [],
    handle: default_handle,
    handle_label: "",
    hideable: default_hideable,
    hide_friction: default_hide_friction,
    id: "",
    modal: default_modal,
    state: default_state,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a BottomSheet from a Config
/// 
pub fn from_config(c: Config) -> BottomSheet {
  BottomSheet(
    detent: c.detent,
    detents: c.detents,
    handle: c.handle,
    handle_label: c.handle_label,
    hideable: c.hideable,
    hide_friction: c.hide_friction,
    id: c.id,
    modal: c.modal,
    state: c.state,
  )
}

/// new creates a new BottomSheet
/// 
pub fn new() -> BottomSheet {
  from_config(default_config())
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
pub fn handle(b: BottomSheet, handle: Handle) -> BottomSheet {
  BottomSheet(..b, handle: handle)
}

/// handle_label sets the handle_label field of a BottomSheet
/// 
pub fn handle_label(b: BottomSheet, handle_label: String) -> BottomSheet {
  BottomSheet(..b, handle_label: handle_label)
}

/// hideable sets the hideable field of a BottomSheet
/// 
pub fn hideable(b: BottomSheet, hideable: Hideable) -> BottomSheet {
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
pub fn modal(b: BottomSheet, modal: Modal) -> BottomSheet {
  BottomSheet(..b, modal: modal)
}

/// state sets the state field of a BottomSheet
/// 
pub fn state(b: BottomSheet, state: State) -> BottomSheet {
  BottomSheet(..b, state: state)
}

// --- RENDERING ---

/// render creates a Lustre Element from a BottomSheet
///
pub fn render(b: BottomSheet, children: List(Element(msg))) -> Element(msg) {
  element.element(
    "m3e-bottom-sheet",
    [
      attribute.attribute("detent", int.to_string(b.detent)),
      case b.detents {
        [] -> attribute.none()
        _ ->
          attribute.attribute("detents", string.join(list.map(b.detents, detent_to_string), " "))
      },
      helpers.boolean_attribute("handle", case b.handle {
        ShowHandle -> True
        NoHandle -> False
      }),
      attribute.attribute("handle-label", b.handle_label),
      helpers.boolean_attribute("hideable", case b.hideable {
        Hideable -> True
        NotHideable -> False
      }),
      attribute.attribute("hide-friction", float.to_string(b.hide_friction)),
      attribute.attribute("id", b.id),
      helpers.boolean_attribute("modal", case b.modal {
        Modal -> True
        Standard -> False
      }),
      helpers.boolean_attribute("open", case b.state {
        Open -> True
        Closed -> False
      }),
    ]
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Config
/// 
pub fn render_config(c: Config, children: List(Element(msg))) -> Element(msg) {
  render(from_config(c), children)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Header -> attribute.attribute("slot", "header")
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

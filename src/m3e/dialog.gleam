//// dialog provides Lustre support for the [M3E Dialog component](https://matraic.github.io/m3e/#/components/dialog.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element, none as element_none}
import lustre/element/html

import m3e/helpers.{boolean_attribute, option_attribute}
import m3e/icon

// --- Types ---

/// Dialog component
/// 
/// ## Fields:
/// - id: The unique identifier for the dialog
/// - alert: Whether the dialog is an alert
/// - close_label: The accessible label given to the button used to dismiss the dialog
/// - no_focus_trap: Whether to disable focus trapping, which keeps keyboard Tab navigation within the dialog
/// - disable_close: Whether users cannot click the backdrop or press ESC to dismiss the dialog
/// - dismissible: Whether a button is presented that can be used to close the dialog
/// - header: The headline of the dialog
/// - close_icon_name: The "close" icon of the dialog
/// - actions: The actions of the dialog
/// 
pub opaque type Dialog(msg) {
  Dialog(
    id: String,
    alert: Bool,
    close_label: Option(String),
    no_focus_trap: Bool,
    disable_close: Bool,
    dismissible: Bool,
    header: String,
    close_icon_name: Option(String),
    actions: List(Element(msg)),
  )
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Actions
  // Renders the actions of the dialog 
  CloseIcon
  // Renders the icon of the button used to close the dialog 
  Header
  // Renders the header of the dialog 
}

// --- CONSTRUCTORS ---

/// new creates a Dialog with default values
/// 
/// ## Parameters:
/// - id: The unique identifier for the dialog
/// - header: The headline of the dialog
///
pub fn new(id: String, header: String) -> Dialog(msg) {
  Dialog(id, False, None, False, False, False, header, None, [])
}

// --- SETTERS ---

/// actions sets the `actions` field
/// 
pub fn actions(d: Dialog(msg), actions: List(Element(msg))) -> Dialog(msg) {
  Dialog(..d, actions: actions)
}

/// alert sets the `alert` field
/// 
pub fn alert(d: Dialog(msg), alert: Bool) -> Dialog(msg) {
  Dialog(..d, alert: alert)
}

/// close_icon_name sets the `close_icon_name` field
/// 
pub fn close_icon_name(
  d: Dialog(msg),
  close_icon_name: Option(String),
) -> Dialog(msg) {
  Dialog(..d, close_icon_name: close_icon_name)
}

/// close_label sets the `close_label` field
/// 
pub fn close_label(d: Dialog(msg), close_label: Option(String)) -> Dialog(msg) {
  Dialog(..d, close_label: close_label)
}

/// disable_close sets the `disable_close` field
/// 
pub fn disable_close(d: Dialog(msg), disable_close: Bool) -> Dialog(msg) {
  Dialog(..d, disable_close: disable_close)
}

/// dismissible sets the `dismissible` field
/// 
pub fn dismissible(d: Dialog(msg), dismissible: Bool) -> Dialog(msg) {
  Dialog(..d, dismissible: dismissible)
}

/// header sets the `header` field
/// 
pub fn header(d: Dialog(msg), header: String) -> Dialog(msg) {
  Dialog(..d, header: header)
}

/// id sets the `id` field
/// 
pub fn id(d: Dialog(msg), id: String) -> Dialog(msg) {
  Dialog(..d, id: id)
}

/// no_focus_trap sets the `no_focus_trap` field
/// 
pub fn no_focus_trap(d: Dialog(msg), no_focus_trap: Bool) -> Dialog(msg) {
  Dialog(..d, no_focus_trap: no_focus_trap)
}

// --- RENDERING ---

/// render creates a Lustre Element from a Dialog
/// 
pub fn render(
  d: Dialog(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-dialog",
    [
      attribute.id(d.id),
      boolean_attribute("alert", d.alert),
      option_attribute(
        d.close_label,
        fn(_) { "close-label" },
        function.identity,
        None,
      ),
      boolean_attribute("no-focus-trap", d.no_focus_trap),
      boolean_attribute("disable-close", d.disable_close),
      boolean_attribute("dismissible", d.dismissible),
      ..attributes
    ]
      |> list.filter(fn(a) { a != none() }),
    [
      html.span([slot(Header)], [html.text(d.header)]),
      close_icon_elt(d.close_icon_name),
      actions_elt(d.actions),
      ..children
    ]
      |> list.filter(fn(a) { a != element_none() }),
  )
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Actions -> attribute("slot", "actions")
    CloseIcon -> attribute("slot", "close-icon")
    Header -> attribute("slot", "header")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn actions_elt(actions: List(Element(msg))) -> Element(msg) {
  case actions {
    [] -> element_none()
    items -> html.div([slot(Actions)], items)
  }
}

fn close_icon_elt(close_icon_name: Option(String)) -> Element(msg) {
  case close_icon_name {
    None -> element_none()
    Some(s) ->
      icon.new(s) |> icon.purpose(slot(CloseIcon)) |> icon.render([], [])
  }
}

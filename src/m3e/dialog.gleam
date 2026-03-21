//// dialog provides Lustre support for the [M3E Dialog component](https://matraic.github.io/m3e/#/components/dialog.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element, none as element_none}
import lustre/element/html

import m3e/helpers.{boolean_attribute, option_attribute}
import m3e/icon
import m3e/types.{type Dismissibility, Dismissible, default_dismissibility}

// --- Types ---

/// AlertStatus specifies if the dialog is an alert
/// 
pub type AlertStatus {
  Alert
  Standard
}

pub const default_alert_status: AlertStatus = Standard

/// CloseBehavior specifies if the dialog can be closed by clicking the backdrop or pressing ESC
/// 
pub type CloseBehavior {
  CloseDisabled
  CloseEnabled
}

pub const default_close_behavior: CloseBehavior = CloseEnabled

/// Dialog component
/// 
/// ## Fields:
/// - id: The unique identifier for the dialog
/// - alert: Whether the dialog is an alert
/// - close_label: The accessible label given to the button used to dismiss the dialog
/// - focus_trap: Whether to disable focus trapping, which keeps keyboard Tab navigation within the dialog
/// - close_behavior: Whether users cannot click the backdrop or press ESC to dismiss the dialog
/// - dismissibility: Whether a button is presented that can be used to close the dialog
/// - header: The headline of the dialog
/// - close_icon_name: The "close" icon of the dialog
/// - actions: The actions of the dialog
/// 
pub opaque type Dialog(msg) {
  Dialog(
    id: String,
    alert: AlertStatus,
    close_label: Option(String),
    focus_trap: FocusTrap,
    close_behavior: CloseBehavior,
    dismissibility: Dismissibility,
    header: String,
    close_icon_name: Option(String),
    actions: List(Element(msg)),
  )
}

/// FocusTrap specifies if focus trapping is enabled
/// 
pub type FocusTrap {
  TrapFocus
  NoFocusTrap
}

pub const default_focus_trap: FocusTrap = TrapFocus

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

// --- CONFIGURATION ---

/// Config holds the configuration for a Dialog
/// 
pub type Config(msg) {
  Config(
    id: String,
    alert: AlertStatus,
    close_label: Option(String),
    focus_trap: FocusTrap,
    close_behavior: CloseBehavior,
    dismissibility: Dismissibility,
    header: String,
    close_icon_name: Option(String),
    actions: List(Element(msg)),
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config(msg) {
  Config(
    id: "",
    alert: default_alert_status,
    close_label: None,
    focus_trap: default_focus_trap,
    close_behavior: default_close_behavior,
    dismissibility: default_dismissibility,
    header: "",
    close_icon_name: None,
    actions: [],
  )
}

// --- CONSTRUCTORS ---

/// new creates a Dialog with default values
/// 
/// ## Parameters:
/// - id: The unique identifier for the dialog
/// - header: The headline of the dialog
///
pub fn new(id: String, header: String) -> Dialog(msg) {
  from_config(Config(..default_config(), id: id, header: header))
}

/// from_config creates a Dialog from a Config record
/// 
pub fn from_config(c: Config(msg)) -> Dialog(msg) {
  Dialog(
    id: c.id,
    alert: c.alert,
    close_label: c.close_label,
    focus_trap: c.focus_trap,
    close_behavior: c.close_behavior,
    dismissibility: c.dismissibility,
    header: c.header,
    close_icon_name: c.close_icon_name,
    actions: c.actions,
  )
}

// --- SETTERS ---

/// actions sets the `actions` field
/// 
pub fn actions(d: Dialog(msg), actions: List(Element(msg))) -> Dialog(msg) {
  Dialog(..d, actions: actions)
}

/// alert sets the `alert` field
/// 
pub fn alert(d: Dialog(msg), alert: AlertStatus) -> Dialog(msg) {
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

/// close_behavior sets the `close_behavior` field
/// 
pub fn close_behavior(d: Dialog(msg), behavior: CloseBehavior) -> Dialog(msg) {
  Dialog(..d, close_behavior: behavior)
}

/// dismissibility sets the `dismissibility` field
/// 
pub fn dismissibility(
  d: Dialog(msg),
  dismissibility: Dismissibility,
) -> Dialog(msg) {
  Dialog(..d, dismissibility: dismissibility)
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

/// focus_trap sets the `focus_trap` field
/// 
pub fn focus_trap(d: Dialog(msg), trap: FocusTrap) -> Dialog(msg) {
  Dialog(..d, focus_trap: trap)
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
      boolean_attribute("alert", d.alert == Alert),
      option_attribute(
        d.close_label,
        fn(_) { "close-label" },
        function.identity,
        None,
      ),
      boolean_attribute("no-focus-trap", d.focus_trap == NoFocusTrap),
      boolean_attribute("disable-close", d.close_behavior == CloseDisabled),
      boolean_attribute("dismissible", d.dismissibility == Dismissible),
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

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
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

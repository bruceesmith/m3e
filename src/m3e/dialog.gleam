//// Dialog is a dialog that provides important prompts in a user flow.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr

// --- Types ---

/// Dialog is a View Model for this component
///
/// ## Fields:
///
/// - alert: Whether the dialog is an alert.
/// - close_label: The accessible label given to the button used to dismiss the dialog.
/// - disable_close: Whether users cannot click the backdrop or press ESC to dismiss the dialog.
/// - dismissible: Whether a button is presented that can be used to close the dialog.
/// - no_focus_trap: Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog.
/// - open: Whether the dialog is open.
///
pub opaque type Dialog {
  Dialog(
    alert: Alert,
    close_label: String,
    disable_close: DisableClose,
    dismissible: Dismissible,
    no_focus_trap: NoFocusTrap,
    open: String,
  )
}

/// Alert is whether the dialog is an alert.
///
pub type Alert {
  IsAlert
  IsNotAlert
}

/// DisableClose is whether users cannot click the backdrop or press ESC to dismiss the dialog.
///
pub type DisableClose {
  IsDisableClose
  IsNotDisableClose
}

/// Dismissible is whether a button is presented that can be used to close the dialog.
///
pub type Dismissible {
  IsDismissible
  IsNotDismissible
}

/// NoFocusTrap is whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog.
///
pub type NoFocusTrap {
  IsNoFocusTrap
  IsNotNoFocusTrap
}

// --- Defaults ---

pub const default_alert: Alert = IsNotAlert

pub const default_close_label: String = "Close"

pub const default_disable_close: DisableClose = IsNotDisableClose

pub const default_dismissible: Dismissible = IsNotDismissible

pub const default_no_focus_trap: NoFocusTrap = IsNotNoFocusTrap

pub const default_open: String = "false"

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Header
  // Renders the header of the dialog.
  Actions
  // Renders the actions of the dialog.
  CloseIcon
  // Renders the icon of the button used to close the dialog.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    alert: Alert,
    close_label: String,
    disable_close: DisableClose,
    dismissible: Dismissible,
    no_focus_trap: NoFocusTrap,
    open: String,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    alert: IsNotAlert,
    close_label: "Close",
    disable_close: IsNotDisableClose,
    dismissible: IsNotDismissible,
    no_focus_trap: IsNotNoFocusTrap,
    open: "false",
  )
}

// --- Constructors ---

/// from_config creates a new Dialog from the given configuration.
///
pub fn from_config(config: Config) -> Dialog {
  Dialog(
    alert: config.alert,
    close_label: config.close_label,
    disable_close: config.disable_close,
    dismissible: config.dismissible,
    no_focus_trap: config.no_focus_trap,
    open: config.open,
  )
}

/// new creates a new Dialog with the default configuration.
///
pub fn new() -> Dialog {
  from_config(default_config())
}

// --- Setters ---

/// alert sets the value of alert for this Dialog.
///
pub fn alert(record: Dialog, alert: Alert) -> Dialog {
  Dialog(..record, alert: alert)
}

/// close_label sets the value of close_label for this Dialog.
///
pub fn close_label(record: Dialog, close_label: String) -> Dialog {
  Dialog(..record, close_label: close_label)
}

/// disable_close sets the value of disable_close for this Dialog.
///
pub fn disable_close(record: Dialog, disable_close: DisableClose) -> Dialog {
  Dialog(..record, disable_close: disable_close)
}

/// dismissible sets the value of dismissible for this Dialog.
///
pub fn dismissible(record: Dialog, dismissible: Dismissible) -> Dialog {
  Dialog(..record, dismissible: dismissible)
}

/// no_focus_trap sets the value of no_focus_trap for this Dialog.
///
pub fn no_focus_trap(record: Dialog, no_focus_trap: NoFocusTrap) -> Dialog {
  Dialog(..record, no_focus_trap: no_focus_trap)
}

/// open sets the value of open for this Dialog.
///
pub fn open(record: Dialog, open: String) -> Dialog {
  Dialog(..record, open: open)
}

// --- Renderers ---

/// render creates a Lustre Element for a Dialog
///
pub fn render(
  model: Dialog,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-dialog",
    list.flatten([
      [
        attr.boolean("alert", model.alert == IsAlert),
        attr.with_default("close-label", model.close_label, default_close_label),
        attr.boolean("disable-close", model.disable_close == IsDisableClose),
        attr.boolean("dismissible", model.dismissible == IsDismissible),
        attr.boolean("no-focus-trap", model.no_focus_trap == IsNoFocusTrap),
        attr.with_default("open", model.open, default_open),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Dialog Config
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
    Header -> attribute.attribute("slot", "header")
    Actions -> attribute.attribute("slot", "actions")
    CloseIcon -> attribute.attribute("slot", "close-icon")
  }
}

//// dialog provides Lustre support for the [M3E Dialog component](https://matraic.github.io/m3e/#/components/dialog.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, id, none}
import lustre/element.{type Element}
import lustre/element/html

import m3e/helpers.{boolean_attribute, option_attribute, slot}

/// Dialog component
/// 
/// ## Fields:
/// - alert: Whether the dialog is an alert
/// - close_label: The accessible label given to the button used to dismiss the dialog
/// - no_focus_trap: Whether to disable focus trapping, which keeps keyboard Tab navigation within the dialog
/// - disable_close: Whether users cannot click the backdrop or press ESC to dismiss the dialog
/// - dismissible: Whether a button is presented that can be used to close the dialog
/// - headline: The headline of the dialog
/// - close_icon: The "close" icon of the dialog
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
    headline: String,
    close_icon: Option(Element(msg)),
    actions: List(Element(msg)),
  )
}

/// dialog creates a Dialog
pub fn dialog(
  id: String,
  alert: Bool,
  close_label: Option(String),
  no_focus_trap: Bool,
  disable_close: Bool,
  dismissible: Bool,
  header: String,
  close_icon: Option(Element(msg)),
  actions: List(Element(msg)),
) -> Dialog(msg) {
  Dialog(
    id,
    alert,
    close_label,
    no_focus_trap,
    disable_close,
    dismissible,
    header,
    close_icon,
    actions,
  )
}

/// basic creates a Dialog with default values
pub fn basic(id: String, header: String) -> Dialog(msg) {
  Dialog(id, False, None, False, False, False, header, None, [])
}

/// element creates a Lustre Element from a Dialog
pub fn element(
  d: Dialog(msg),
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-dialog",
    [
      id(d.id),
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
    list.flatten([
      [html.span([slot("header")], [html.text(d.headline)])],
      case d.close_icon {
        Some(i) -> [html.div([slot("close-icon")], [i])]
        None -> []
      },
      children,
      case d.actions {
        [] -> []
        items -> [html.div([slot("actions")], items)]
      },
    ]),
  )
}

/// alert sets the `alert` field
pub fn alert(d: Dialog(msg), alert: Bool) -> Dialog(msg) {
  Dialog(..d, alert: alert)
}

/// headline sets the `headline` field
pub fn headline(d: Dialog(msg), headline: String) -> Dialog(msg) {
  Dialog(..d, headline: headline)
}

/// icon sets the `icon` field
pub fn icon(d: Dialog(msg), close_icon: Option(Element(msg))) -> Dialog(msg) {
  Dialog(..d, close_icon: close_icon)
}

/// actions sets the `actions` field
pub fn actions(d: Dialog(msg), actions: List(Element(msg))) -> Dialog(msg) {
  Dialog(..d, actions: actions)
}

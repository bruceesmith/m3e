//// snackbar provides Lustre support for the [M3E Snackbar component](https://matraic.github.io/m3e/#/components/snackbar.html)

import gleam/option.{type Option, None, Some, unwrap}
import lustre/effect.{type Effect}

pub const default_action_label = ""

pub const default_close_label = "Close"

pub const default_duration = 3000

/// Options represents the SnackbarOptions JavaScript object
/// 
/// ## Fields:
/// - callback: the Msg that should be sent when the Action button is clicked
/// - close_label: The accessible label given to the button used to dismiss the snackbar
/// - duration: The length of time, in milliseconds, to wait before automatically dismissing the snackbar
/// 
type Options {
  FullOptions(close_label: String, duration: Int, callback: fn() -> Nil)
  ShortOptions(close_label: String, duration: Int)
}

/// Snackbar provides Lustre support for the [M3E Snackbar component](https://matraic.github.io/m3e/#/components/snackbar.html)
///
/// ## Fields:
/// - message: The text to display in the snackbar
/// - action_label: The label of the snackbar's action
/// - close_label: The accessible label given to the button used to dismiss the snackbar
/// - dismissible: Whether a button is presented that can be used to close the snackbar
/// - duration: The length of time, in milliseconds, to wait before automatically dismissing the snackbar
///
pub type Snackbar {
  Snackbar(
    message: String,
    action_label: Option(String),
    close_label: Option(String),
    dismissable: Bool,
    duration: Option(Int),
  )
}

/// new creates a new Snackbar
/// 
pub fn new(message: String) -> Snackbar {
  Snackbar(message, None, None, False, None)
}

/// message sets the message field
/// 
pub fn message(s: Snackbar, message: String) -> Snackbar {
  Snackbar(..s, message: message)
}

/// action_label sets the action_label field
/// 
pub fn action_label(s: Snackbar, action_label: Option(String)) -> Snackbar {
  Snackbar(..s, action_label: action_label)
}

/// close_label sets the close_label field
///  
pub fn close_label(s: Snackbar, close_label: Option(String)) -> Snackbar {
  Snackbar(..s, close_label: close_label)
}

/// dismissable sets the dismissable field
/// 
pub fn dismissable(s: Snackbar, dismissable: Bool) -> Snackbar {
  Snackbar(..s, dismissable: dismissable)
}

/// duration sets the duration field
/// 
pub fn duration(s: Snackbar, duration: Option(Int)) -> Snackbar {
  Snackbar(..s, duration: duration)
}

/// SnackbarAction describes the intent to open a snackbar with specific parameters.
/// This allows the logic to be pure and easily testable.
pub type SnackbarAction(msg) {
  Open(
    message: String,
    action_label: String,
    dismissable: Bool,
    close_label: String,
    duration: Int,
    callback: Option(msg),
  )
}

/// open displays a Snackbar. Unlike render() functions in other M3E components,
/// which are called from an application's view() function, the Snackbar's open()
/// is called from an application's update() function.
/// 
/// ## Parameters:
/// - s: a Snackbar
/// - callback: the Msg that should be sent when the Action button is clicked
/// 
pub fn open(s: Snackbar, callback: Option(msg)) -> Effect(msg) {
  s
  |> to_action(callback)
  |> to_effect
}

/// to_action describes a Snackbar. It is a pure function that returns a 
/// SnackbarAction description.
/// 
/// ## Parameters:
/// - s: a Snackbar
/// - callback: the Msg that should be sent when the Action button is clicked
/// 
pub fn to_action(s: Snackbar, callback: Option(msg)) -> SnackbarAction(msg) {
  let action_label = unwrap(s.action_label, default_action_label)
  let close_label = unwrap(s.close_label, default_close_label)
  let duration = unwrap(s.duration, default_duration)

  Open(
    message: s.message,
    action_label: action_label,
    dismissable: s.dismissable,
    close_label: close_label,
    duration: duration,
    callback: callback,
  )
}

/// to_effect converts a SnackbarAction description into a Lustre Effect.
/// 
pub fn to_effect(action: SnackbarAction(msg)) -> Effect(msg) {
  case action {
    Open(message, action_label, dismissable, close_label, duration, callback) ->
      effect.from(fn(dispatch) {
        open_snackbar(message, action_label, dismissable, case callback {
          Some(cb) -> FullOptions(close_label, duration, fn() { dispatch(cb) })
          None -> ShortOptions(close_label, duration)
        })
      })
  }
}

/// Interfaces to the JavaScript M3eSnackbar.open() function. 
///
@external(javascript, "./app.ffi.mjs", "open_snackbar")
fn open_snackbar(_: String, _: String, _: Bool, _: Options) -> Nil {
  Nil
}

import gleam/option.{type Option, None, Some}

import lustre/effect.{type Effect}

import m3e/snackbar

/// Options represents the SnackbarOptions JavaScript object
///
/// ## Fields:
/// - callback: the Msg that should be sent when the Action button is clicked
/// - close_label: The accessible label given to the button used to dismiss the snackbar
/// - duration: The length of time, in milliseconds, to wait before automatically dismissing the snackbar
///
type Options {
  FullOptions(close_label: String, duration: Float, callback: fn() -> Nil)
  ShortOptions(close_label: String, duration: Float)
}

/// SnackbarAction describes the intent to open a snackbar with specific parameters.
/// This allows the logic to be pure and easily testable.
///
/// This type is public to allow testing
///
pub type SnackbarAction(msg) {
  Open(
    message: String,
    action: String,
    dismissable: snackbar.Dismissible,
    close_label: String,
    duration: Float,
    callback: Option(msg),
  )
}

// open displays a Snackbar. Unlike render() functions in regular M3E components,
// which are called from an application's view() function, the Snackbar's open()
// is called from an application's update() function.
//
// ## Parameters:
// - s: a Snackbar
// - message: the message the Snackbar should display
// - callback: the Msg that should be sent when the Action button is clicked
//
pub fn open(
  config: snackbar.Config,
  message: String,
  callback: Option(msg),
) -> Effect(msg) {
  config
  |> to_action(message, callback)
  |> to_effect
}

/// to_action describes a Snackbar. It is a pure function that returns a
/// SnackbarAction description.
///
/// ## Parameters:
/// - s: a Snackbar
/// - callback: the Msg that should be sent when the Action button is clicked
///
/// This function is public to allow testing
///
@internal
pub fn to_action(
  config: snackbar.Config,
  message: String,
  callback: Option(msg),
) -> SnackbarAction(msg) {
  Open(
    message: message,
    action: config.action,
    dismissable: config.dismissible,
    close_label: config.close_label,
    duration: config.duration,
    callback: callback,
  )
}

/// to_effect converts a SnackbarAction description into a Lustre Effect.
///
fn to_effect(action: SnackbarAction(msg)) -> Effect(msg) {
  case action {
    Open(message, action, dismissable, close_label, duration, callback) ->
      effect.from(fn(dispatch) {
        open_snackbar(
          message,
          action,
          dismissable == snackbar.IsDismissible,
          case callback {
            Some(cb) ->
              FullOptions(close_label, duration, fn() { dispatch(cb) })
            None -> ShortOptions(close_label, duration)
          },
        )
      })
  }
}

// // --- PRIVATE INTERNAL HELPERS ---

/// Interfaces to the JavaScript M3eSnackbar.open() function.
///
@external(javascript, "./snackbar.ffi.mjs", "open_snackbar")
fn open_snackbar(_: String, _: String, _: Bool, _: Options) -> Nil {
  Nil
}

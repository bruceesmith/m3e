//// snackbar provides Lustre support for the [M3E Snackbar component](https://matraic.github.io/m3e/#/components/snackbar.html)

import gleam/option.{type Option, None, Some}
import lustre/effect.{type Effect}

import m3e/config.{type Dismissibility, Dismissible}

pub const default_action_label = ""

pub const default_close_label = "Close"

pub const default_duration = 3000

// --- Types ---

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

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  CloseIcon
  // Renders the icon of the button used to close the snackbar 
}

/// Snackbar presents short updates about application processes at the bottom of the screen
///
/// ## Fields:
/// - message: The text to display in the snackbar
/// - action_label: The label of the snackbar's action
/// - close_label: The accessible label given to the button used to dismiss the snackbar
/// - dismissibility: Whether a button is presented that can be used to close the snackbar
/// - duration: The length of time, in milliseconds, to wait before automatically dismissing the snackbar
///
pub type Snackbar {
  Snackbar(
    message: String,
    action_label: Option(String),
    close_label: Option(String),
    dismissibility: Dismissibility,
    duration: Option(Int),
  )
}

/// SnackbarAction describes the intent to open a snackbar with specific parameters.
/// This allows the logic to be pure and easily testable.
/// 
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

// --- CONFIGURATION ---

/// Config holds the configuration for a Snackbar
/// 
pub type Config {
  Config(
    message: String,
    action_label: Option(String),
    close_label: Option(String),
    dismissibility: Dismissibility,
    duration: Option(Int),
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config(message: String) -> Config {
  Config(
    message: message,
    action_label: None,
    close_label: None,
    dismissibility: config.default_dismissibility,
    duration: None,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new Snackbar
/// 
pub fn new(message: String) -> Snackbar {
  from_config(default_config(message))
}

/// from_config creates a Snackbar from a Config record
/// 
pub fn from_config(c: Config) -> Snackbar {
  Snackbar(
    message: c.message,
    action_label: c.action_label,
    close_label: c.close_label,
    dismissibility: c.dismissibility,
    duration: c.duration,
  )
}

// --- SETTERS ---

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

/// dismissible sets the dismissibility field
/// 
pub fn dismissible(s: Snackbar, d: Dismissibility) -> Snackbar {
  Snackbar(..s, dismissibility: d)
}

/// duration sets the duration field
/// 
pub fn duration(s: Snackbar, duration: Option(Int)) -> Snackbar {
  Snackbar(..s, duration: duration)
}

// --- RENDERING ---

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

/// open_config displays a Snackbar directly from a Config
/// 
pub fn open_config(config: Config, callback: Option(msg)) -> Effect(msg) {
  open(from_config(config), callback)
}

/// to_action describes a Snackbar. It is a pure function that returns a 
/// SnackbarAction description.
/// 
/// ## Parameters:
/// - s: a Snackbar
/// - callback: the Msg that should be sent when the Action button is clicked
/// 
@internal
pub fn to_action(s: Snackbar, callback: Option(msg)) -> SnackbarAction(msg) {
  let action_label = option.unwrap(s.action_label, default_action_label)
  let close_label = option.unwrap(s.close_label, default_close_label)
  let duration = option.unwrap(s.duration, default_duration)

  Open(
    message: s.message,
    action_label: action_label,
    dismissable: s.dismissibility == Dismissible,
    close_label: close_label,
    duration: duration,
    callback: callback,
  )
}

/// to_effect converts a SnackbarAction description into a Lustre Effect.
/// 
@internal
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

// --- PRIVATE INTERNAL HELPERS ---

/// Interfaces to the JavaScript M3eSnackbar.open() function. 
///
@external(javascript, "./app.ffi.mjs", "open_snackbar")
fn open_snackbar(_: String, _: String, _: Bool, _: Options) -> Nil {
  Nil
}

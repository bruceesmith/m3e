import gleam/io

// import gleam/option.{type Option}
//
// import lustre/effect.{type Effect}
// import m3e/snackbar
// open displays a Snackbar. Unlike render() functions in other M3E components,
// which are called from an application's view() function, the Snackbar's open()
// is called from an application's update() function.
//
// ## Parameters:
// - s: a Snackbar
// - callback: the Msg that should be sent when the Action button is clicked
//
// open_config displays a Snackbar directly from a Config
//
// to_action describes a Snackbar. It is a pure function that returns a
// SnackbarAction description.
//
// ## Parameters:
// - s: a Snackbar
// - callback: the Msg that should be sent when the Action button is clicked
//
// --- RENDERING ---

pub fn open() {
  io.println("open")
  //   s: snackbar.Snackbar,
  //   message: String,
  //   callback: Option(msg),
  // ) -> Effect(msg) {
  //   s
  //   |> to_action(message, callback)
  //   |> to_effect
}
// pub fn open_config(
//   config: snackbar.Config,
//   message: String,
//   callback: Option(msg),
// ) -> Effect(msg) {
//   open(snackbar.from_config(config), message, callback)
// }
// @internal
// pub fn to_action(
//   s: snackbar.Config,
//   message: String,
//   callback: Option(msg),
// ) -> snackbar.SnackbarAction(msg) {
//   let action = option.unwrap(s.action, default_action_label)
//   let close_label = option.unwrap(s.close_label, default_close_label)
//   let duration = option.unwrap(s.duration, default_duration)

//   Open(
//     message: s.message,
//     action: action,
//     dismissable: s.dismissible == Dismissible,
//     close_label: close_label,
//     duration: duration,
//     callback: callback,
//   )
// }

// /// to_effect converts a SnackbarAction description into a Lustre Effect.
// ///
// @internal
// pub fn to_effect(action: SnackbarAction(msg)) -> Effect(msg) {
//   case action {
//     Open(message, action, dismissable, close_label, duration, callback) ->
//       effect.from(fn(dispatch) {
//         open_snackbar(message, action, dismissable, case callback {
//           Some(cb) -> FullOptions(close_label, duration, fn() { dispatch(cb) })
//           None -> ShortOptions(close_label, duration)
//         })
//       })
//   }
// }

// // --- PRIVATE INTERNAL HELPERS ---

// /// Interfaces to the JavaScript M3eSnackbar.open() function.
// ///
// @external(javascript, "./app.ffi.mjs", "open_snackbar")
// fn open_snackbar(_: String, _: String, _: Bool, _: Options) -> Nil {
//   Nil
// }

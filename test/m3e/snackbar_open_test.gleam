import gleam/list
import gleam/option.{None, Some}
import gleeunit/should

import m3e/snackbar
import m3e/snackbar_open

type Msg {
  CallMe
}

pub fn snackbar_open_to_action_test() {
  let cases = [
    #(
      snackbar.Config(
        action: "Action",
        close_label: "Close",
        dismissible: snackbar.IsDismissible,
        duration: 5000.0,
      ),
      "Hello",
      Some(CallMe),
      snackbar_open.Open(
        message: "Hello",
        action: "Action",
        dismissable: snackbar.IsDismissible,
        close_label: "Close",
        duration: 5000.0,
        callback: Some(CallMe),
      ),
    ),
    #(
      snackbar.default_config(),
      "Hello",
      None,
      snackbar_open.Open(
        message: "Hello",
        action: snackbar.default_action,
        dismissable: snackbar.default_dismissible,
        close_label: snackbar.default_close_label,
        duration: snackbar.default_duration,
        callback: None,
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, message, callback, expected) = c

    snackbar_open.to_action(config, message, callback)
    |> should.equal(expected)
  })
}

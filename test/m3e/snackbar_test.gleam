import gleam/option.{None, Some}
import gleeunit/should

import m3e/config.{Dismissible, NotDismissible}
import m3e/snackbar

pub fn snackbar_new_test() {
  let s = snackbar.new("Hello")
  let action = snackbar.to_action(s, None)

  action.message |> should.equal("Hello")
  action.action |> should.equal(snackbar.default_action_label)
  action.close_label |> should.equal(snackbar.default_close_label)
  action.dismissable |> should.equal(False)
  action.duration |> should.equal(snackbar.default_duration)
}

pub fn snackbar_setters_test() {
  snackbar.new("Original")
  |> snackbar.message("New")
  |> snackbar.action(Some("Action"))
  |> snackbar.close_label(Some("Close"))
  |> snackbar.dismissible(Dismissible)
  |> snackbar.duration(Some(5000))
  |> snackbar.to_action(None)
  |> should.equal(snackbar.Open(
    message: "New",
    action: "Action",
    dismissable: True,
    close_label: "Close",
    duration: 5000,
    callback: None,
  ))
}

pub fn snackbar_to_action_pure_test() {
  let s =
    snackbar.new("Hello")
    |> snackbar.action(Some("Action"))
    |> snackbar.close_label(Some("Close"))
    |> snackbar.dismissible(Dismissible)
    |> snackbar.duration(Some(5000))

  // to_action() is pure and can be tested with should.equal
  snackbar.to_action(s, Some("msg"))
  |> should.equal(snackbar.Open(
    message: "Hello",
    action: "Action",
    dismissable: True,
    close_label: "Close",
    duration: 5000,
    callback: Some("msg"),
  ))
}

pub fn snackbar_to_action_defaults_test() {
  let s = snackbar.new("Message")

  snackbar.to_action(s, None)
  |> should.equal(snackbar.Open(
    message: "Message",
    action: snackbar.default_action_label,
    dismissable: False,
    close_label: snackbar.default_close_label,
    duration: snackbar.default_duration,
    callback: None,
  ))
}

pub fn snackbar_open_test() {
  let s = snackbar.new("Hello")

  // open() combines to_action and to_effect, returns an Effect
  let _ = snackbar.open(s, None)
}

pub fn snackbar_to_effect_test() {
  let s = snackbar.new("Hello")
  let action = snackbar.to_action(s, None)

  // to_effect() is side-effecting but we check it doesn't crash
  let _ = snackbar.to_effect(action)
}

pub fn config_test() {
  snackbar.default_config("Hello")
  |> should.equal(snackbar.Config(
    message: "Hello",
    action: None,
    close_label: None,
    dismissible: NotDismissible,
    duration: None,
  ))
}

pub fn from_config_test() {
  snackbar.default_config("Hello")
  |> snackbar.from_config
  |> should.equal(snackbar.new("Hello"))
}

pub fn open_config_test() {
  let _ = snackbar.open_config(snackbar.default_config("Hello"), None)
}

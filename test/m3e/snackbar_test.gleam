import gleam/option.{None, Some}
import gleeunit/should
import m3e/snackbar

pub fn snackbar_new_test() {
  let s = snackbar.new("Hello")
  s.message |> should.equal("Hello")
  s.action_label |> should.equal(None)
  s.close_label |> should.equal(None)
  s.dismissable |> should.equal(False)
  s.duration |> should.equal(None)
}

pub fn snackbar_setters_test() {
  snackbar.new("Original")
  |> snackbar.message("New")
  |> snackbar.action_label(Some("Action"))
  |> snackbar.close_label(Some("Close"))
  |> snackbar.dismissable(True)
  |> snackbar.duration(Some(5000))
  |> should.equal(
    snackbar.Snackbar(
      message: "New",
      action_label: Some("Action"),
      close_label: Some("Close"),
      dismissable: True,
      duration: Some(5000),
    ),
  )
}

pub fn snackbar_render_test() {
  let s =
    snackbar.new("Hello")
    |> snackbar.action_label(Some("Action"))
    |> snackbar.close_label(Some("Close"))
    |> snackbar.dismissable(True)
    |> snackbar.duration(Some(5000))

  // render returns an Effect, which is opaque, so we just call it to ensure no crash
  let _ = snackbar.render(s, Some("msg"))
  let _ = snackbar.render(s, None)
}

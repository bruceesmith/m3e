//// Snackbar unit tests
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/snackbar.{Config}

pub fn snackbar_default_config_test() {
  let cases = [
    Config(
      action: "",
      close_label: "Close",
      dismissible: snackbar.IsNotDismissible,
      duration: 3000.0,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    snackbar.default_config()
    |> should.equal(expected)
  })
}

pub fn snackbar_from_config_test() {
  let cases = [
    #(
      snackbar.Config(
        action: "test",
        close_label: "test",
        dismissible: snackbar.IsDismissible,
        duration: 42.0,
      ),
      snackbar.new()
        |> snackbar.action("test")
        |> snackbar.close_label("test")
        |> snackbar.dismissible(snackbar.IsDismissible)
        |> snackbar.duration(42.0),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    snackbar.from_config(config)
    |> should.equal(expected)
  })
}

pub fn snackbar_new_test() {
  let cases = [
    snackbar.from_config(snackbar.Config(
      action: "",
      close_label: "Close",
      dismissible: snackbar.IsNotDismissible,
      duration: 3000.0,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    snackbar.new()
    |> should.equal(expected)
  })
}

pub fn snackbar_action_test() {
  let mod = snackbar.new()
  let cases = [
    #(
      "test",
      snackbar.from_config(
        snackbar.Config(..snackbar.default_config(), action: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    snackbar.action(mod, field)
    |> should.equal(expected)
  })
}

pub fn snackbar_close_label_test() {
  let mod = snackbar.new()
  let cases = [
    #(
      "test",
      snackbar.from_config(
        snackbar.Config(..snackbar.default_config(), close_label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    snackbar.close_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn snackbar_dismissible_test() {
  let mod = snackbar.new()
  let cases = [
    #(
      snackbar.IsDismissible,
      snackbar.from_config(
        snackbar.Config(
          ..snackbar.default_config(),
          dismissible: snackbar.IsDismissible,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    snackbar.dismissible(mod, field)
    |> should.equal(expected)
  })
}

pub fn snackbar_duration_test() {
  let mod = snackbar.new()
  let cases = [
    #(
      42.0,
      snackbar.from_config(
        snackbar.Config(..snackbar.default_config(), duration: 42.0),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    snackbar.duration(mod, field)
    |> should.equal(expected)
  })
}

pub fn snackbar_render_test() {
  let mod = snackbar.new()

  let mod_action = snackbar.new() |> snackbar.action("test")
  let mod_close_label = snackbar.new() |> snackbar.close_label("test")
  let mod_dismissible =
    snackbar.new() |> snackbar.dismissible(snackbar.IsDismissible)
  let mod_duration = snackbar.new() |> snackbar.duration(42.0)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-snackbar", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-snackbar", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-snackbar", [], [html.br([])]),
    ),

    // Happy path with a action attribute
    #(
      #(mod_action, [], []),
      element.element(
        "m3e-snackbar",
        [attribute.attribute("action", "test")],
        [],
      ),
    ),
    // Happy path with a close_label attribute
    #(
      #(mod_close_label, [], []),
      element.element(
        "m3e-snackbar",
        [attribute.attribute("close-label", "test")],
        [],
      ),
    ),
    // Happy path with a dismissible attribute
    #(
      #(mod_dismissible, [], []),
      element.element(
        "m3e-snackbar",
        [attribute.attribute("dismissible", "")],
        [],
      ),
    ),
    // Happy path with a duration attribute
    #(
      #(mod_duration, [], []),
      element.element(
        "m3e-snackbar",
        [attribute.attribute("duration", "42.0")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    snackbar.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn snackbar_slot_test() {
  let cases = [
    #(snackbar.CloseIcon, attribute.attribute("slot", "close-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    snackbar.slot(s)
    |> should.equal(expected)
  })
}

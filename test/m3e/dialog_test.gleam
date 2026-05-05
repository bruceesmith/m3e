//// Dialog unit tests
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
import m3e/dialog.{Config}

pub fn dialog_default_config_test() {
  let cases = [
    Config(
      alert: dialog.IsNotAlert,
      close_label: "Close",
      disable_close: dialog.IsNotDisableClose,
      dismissible: dialog.IsNotDismissible,
      no_focus_trap: dialog.IsNotNoFocusTrap,
      open: "false",
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    dialog.default_config()
    |> should.equal(expected)
  })
}

pub fn dialog_from_config_test() {
  let cases = [
    #(
      dialog.Config(
        alert: dialog.IsAlert,
        close_label: "test",
        disable_close: dialog.IsDisableClose,
        dismissible: dialog.IsDismissible,
        no_focus_trap: dialog.IsNoFocusTrap,
        open: "test",
      ),
      dialog.new()
        |> dialog.alert(dialog.IsAlert)
        |> dialog.close_label("test")
        |> dialog.disable_close(dialog.IsDisableClose)
        |> dialog.dismissible(dialog.IsDismissible)
        |> dialog.no_focus_trap(dialog.IsNoFocusTrap)
        |> dialog.open("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    dialog.from_config(config)
    |> should.equal(expected)
  })
}

pub fn dialog_new_test() {
  let cases = [
    dialog.from_config(dialog.Config(
      alert: dialog.IsNotAlert,
      close_label: "Close",
      disable_close: dialog.IsNotDisableClose,
      dismissible: dialog.IsNotDismissible,
      no_focus_trap: dialog.IsNotNoFocusTrap,
      open: "false",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    dialog.new()
    |> should.equal(expected)
  })
}

pub fn dialog_alert_test() {
  let mod = dialog.new()
  let cases = [
    #(
      dialog.IsAlert,
      dialog.from_config(
        dialog.Config(..dialog.default_config(), alert: dialog.IsAlert),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    dialog.alert(mod, field)
    |> should.equal(expected)
  })
}

pub fn dialog_close_label_test() {
  let mod = dialog.new()
  let cases = [
    #(
      "test",
      dialog.from_config(
        dialog.Config(..dialog.default_config(), close_label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    dialog.close_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn dialog_disable_close_test() {
  let mod = dialog.new()
  let cases = [
    #(
      dialog.IsDisableClose,
      dialog.from_config(
        dialog.Config(
          ..dialog.default_config(),
          disable_close: dialog.IsDisableClose,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    dialog.disable_close(mod, field)
    |> should.equal(expected)
  })
}

pub fn dialog_dismissible_test() {
  let mod = dialog.new()
  let cases = [
    #(
      dialog.IsDismissible,
      dialog.from_config(
        dialog.Config(
          ..dialog.default_config(),
          dismissible: dialog.IsDismissible,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    dialog.dismissible(mod, field)
    |> should.equal(expected)
  })
}

pub fn dialog_no_focus_trap_test() {
  let mod = dialog.new()
  let cases = [
    #(
      dialog.IsNoFocusTrap,
      dialog.from_config(
        dialog.Config(
          ..dialog.default_config(),
          no_focus_trap: dialog.IsNoFocusTrap,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    dialog.no_focus_trap(mod, field)
    |> should.equal(expected)
  })
}

pub fn dialog_open_test() {
  let mod = dialog.new()
  let cases = [
    #(
      "test",
      dialog.from_config(dialog.Config(..dialog.default_config(), open: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    dialog.open(mod, field)
    |> should.equal(expected)
  })
}

pub fn dialog_render_test() {
  let mod = dialog.new()

  let mod_alert = dialog.new() |> dialog.alert(dialog.IsAlert)
  let mod_close_label = dialog.new() |> dialog.close_label("test")
  let mod_disable_close =
    dialog.new() |> dialog.disable_close(dialog.IsDisableClose)
  let mod_dismissible = dialog.new() |> dialog.dismissible(dialog.IsDismissible)
  let mod_no_focus_trap =
    dialog.new() |> dialog.no_focus_trap(dialog.IsNoFocusTrap)
  let mod_open = dialog.new() |> dialog.open("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-dialog", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-dialog", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-dialog", [], [html.br([])]),
    ),

    // Happy path with a alert attribute
    #(
      #(mod_alert, [], []),
      element.element("m3e-dialog", [attribute.attribute("alert", "")], []),
    ),
    // Happy path with a close_label attribute
    #(
      #(mod_close_label, [], []),
      element.element(
        "m3e-dialog",
        [attribute.attribute("close-label", "test")],
        [],
      ),
    ),
    // Happy path with a disable_close attribute
    #(
      #(mod_disable_close, [], []),
      element.element(
        "m3e-dialog",
        [attribute.attribute("disable-close", "")],
        [],
      ),
    ),
    // Happy path with a dismissible attribute
    #(
      #(mod_dismissible, [], []),
      element.element(
        "m3e-dialog",
        [attribute.attribute("dismissible", "")],
        [],
      ),
    ),
    // Happy path with a no_focus_trap attribute
    #(
      #(mod_no_focus_trap, [], []),
      element.element(
        "m3e-dialog",
        [attribute.attribute("no-focus-trap", "")],
        [],
      ),
    ),
    // Happy path with a open attribute
    #(
      #(mod_open, [], []),
      element.element("m3e-dialog", [attribute.attribute("open", "test")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    dialog.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn dialog_slot_test() {
  let cases = [
    #(dialog.Header, attribute.attribute("slot", "header")),
    #(dialog.Actions, attribute.attribute("slot", "actions")),
    #(dialog.CloseIcon, attribute.attribute("slot", "close-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    dialog.slot(s)
    |> should.equal(expected)
  })
}

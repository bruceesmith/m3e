//// ButtonSegment unit tests
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
import m3e/button_segment.{Config}

pub fn button_segment_default_config_test() {
  let cases = [
    Config(
      checked: button_segment.IsNotChecked,
      disabled: button_segment.IsNotDisabled,
      value: "on",
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    button_segment.default_config()
    |> should.equal(expected)
  })
}

pub fn button_segment_from_config_test() {
  let cases = [
    #(
      button_segment.Config(
        checked: button_segment.IsChecked,
        disabled: button_segment.IsDisabled,
        value: "test",
      ),
      button_segment.new()
        |> button_segment.checked(button_segment.IsChecked)
        |> button_segment.disabled(button_segment.IsDisabled)
        |> button_segment.value("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    button_segment.from_config(config)
    |> should.equal(expected)
  })
}

pub fn button_segment_new_test() {
  let cases = [
    button_segment.from_config(button_segment.Config(
      checked: button_segment.IsNotChecked,
      disabled: button_segment.IsNotDisabled,
      value: "on",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    button_segment.new()
    |> should.equal(expected)
  })
}

pub fn button_segment_checked_test() {
  let mod = button_segment.new()
  let cases = [
    #(
      button_segment.IsChecked,
      button_segment.from_config(
        button_segment.Config(
          ..button_segment.default_config(),
          checked: button_segment.IsChecked,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button_segment.checked(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_segment_disabled_test() {
  let mod = button_segment.new()
  let cases = [
    #(
      button_segment.IsDisabled,
      button_segment.from_config(
        button_segment.Config(
          ..button_segment.default_config(),
          disabled: button_segment.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button_segment.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_segment_value_test() {
  let mod = button_segment.new()
  let cases = [
    #(
      "test",
      button_segment.from_config(
        button_segment.Config(..button_segment.default_config(), value: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button_segment.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_segment_render_test() {
  let mod = button_segment.new()

  let mod_checked =
    button_segment.new() |> button_segment.checked(button_segment.IsChecked)
  let mod_disabled =
    button_segment.new() |> button_segment.disabled(button_segment.IsDisabled)
  let mod_value = button_segment.new() |> button_segment.value("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-button-segment", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-button-segment", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-button-segment", [], [html.br([])]),
    ),

    // Happy path with a checked attribute
    #(
      #(mod_checked, [], []),
      element.element(
        "m3e-button-segment",
        [attribute.attribute("checked", "")],
        [],
      ),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-button-segment",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element(
        "m3e-button-segment",
        [attribute.attribute("value", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    button_segment.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn button_segment_slot_test() {
  let cases = [
    #(button_segment.Icon, attribute.attribute("slot", "icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    button_segment.slot(s)
    |> should.equal(expected)
  })
}

//// Radio unit tests
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
import m3e/radio.{Config}

pub fn radio_default_config_test() {
  let cases = [
    Config(
      checked: radio.IsNotChecked,
      disabled: radio.IsNotDisabled,
      name: "",
      required: "",
      value: "on",
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    radio.default_config()
    |> should.equal(expected)
  })
}

pub fn radio_from_config_test() {
  let cases = [
    #(
      radio.Config(
        checked: radio.IsChecked,
        disabled: radio.IsDisabled,
        name: "test",
        required: "test",
        value: "test",
      ),
      radio.new()
        |> radio.checked(radio.IsChecked)
        |> radio.disabled(radio.IsDisabled)
        |> radio.name("test")
        |> radio.required("test")
        |> radio.value("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    radio.from_config(config)
    |> should.equal(expected)
  })
}

pub fn radio_new_test() {
  let cases = [
    radio.from_config(radio.Config(
      checked: radio.IsNotChecked,
      disabled: radio.IsNotDisabled,
      name: "",
      required: "",
      value: "on",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    radio.new()
    |> should.equal(expected)
  })
}

pub fn radio_checked_test() {
  let mod = radio.new()
  let cases = [
    #(
      radio.IsChecked,
      radio.from_config(
        radio.Config(..radio.default_config(), checked: radio.IsChecked),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    radio.checked(mod, field)
    |> should.equal(expected)
  })
}

pub fn radio_disabled_test() {
  let mod = radio.new()
  let cases = [
    #(
      radio.IsDisabled,
      radio.from_config(
        radio.Config(..radio.default_config(), disabled: radio.IsDisabled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    radio.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn radio_name_test() {
  let mod = radio.new()
  let cases = [
    #(
      "test",
      radio.from_config(radio.Config(..radio.default_config(), name: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    radio.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn radio_required_test() {
  let mod = radio.new()
  let cases = [
    #(
      "test",
      radio.from_config(
        radio.Config(..radio.default_config(), required: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    radio.required(mod, field)
    |> should.equal(expected)
  })
}

pub fn radio_value_test() {
  let mod = radio.new()
  let cases = [
    #(
      "test",
      radio.from_config(radio.Config(..radio.default_config(), value: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    radio.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn radio_render_test() {
  let mod = radio.new()

  let mod_checked = radio.new() |> radio.checked(radio.IsChecked)
  let mod_disabled = radio.new() |> radio.disabled(radio.IsDisabled)
  let mod_name = radio.new() |> radio.name("test")
  let mod_required = radio.new() |> radio.required("test")
  let mod_value = radio.new() |> radio.value("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-radio", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-radio", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-radio", [], [html.br([])]),
    ),

    // Happy path with a checked attribute
    #(
      #(mod_checked, [], []),
      element.element("m3e-radio", [attribute.attribute("checked", "")], []),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-radio", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element("m3e-radio", [attribute.attribute("name", "test")], []),
    ),
    // Happy path with a required attribute
    #(
      #(mod_required, [], []),
      element.element(
        "m3e-radio",
        [attribute.attribute("required", "test")],
        [],
      ),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element("m3e-radio", [attribute.attribute("value", "test")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    radio.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

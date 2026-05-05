//// InputChipSet unit tests
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
import m3e/input_chip_set.{Config}

pub fn input_chip_set_default_config_test() {
  let cases = [
    Config(
      disabled: input_chip_set.IsNotDisabled,
      name: "",
      required: input_chip_set.IsNotRequired,
      vertical: input_chip_set.IsNotVertical,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    input_chip_set.default_config()
    |> should.equal(expected)
  })
}

pub fn input_chip_set_from_config_test() {
  let cases = [
    #(
      input_chip_set.Config(
        disabled: input_chip_set.IsDisabled,
        name: "test",
        required: input_chip_set.IsRequired,
        vertical: input_chip_set.IsVertical,
      ),
      input_chip_set.new()
        |> input_chip_set.disabled(input_chip_set.IsDisabled)
        |> input_chip_set.name("test")
        |> input_chip_set.required(input_chip_set.IsRequired)
        |> input_chip_set.vertical(input_chip_set.IsVertical),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    input_chip_set.from_config(config)
    |> should.equal(expected)
  })
}

pub fn input_chip_set_new_test() {
  let cases = [
    input_chip_set.from_config(input_chip_set.Config(
      disabled: input_chip_set.IsNotDisabled,
      name: "",
      required: input_chip_set.IsNotRequired,
      vertical: input_chip_set.IsNotVertical,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    input_chip_set.new()
    |> should.equal(expected)
  })
}

pub fn input_chip_set_disabled_test() {
  let mod = input_chip_set.new()
  let cases = [
    #(
      input_chip_set.IsDisabled,
      input_chip_set.from_config(
        input_chip_set.Config(
          ..input_chip_set.default_config(),
          disabled: input_chip_set.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip_set.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_set_name_test() {
  let mod = input_chip_set.new()
  let cases = [
    #(
      "test",
      input_chip_set.from_config(
        input_chip_set.Config(..input_chip_set.default_config(), name: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip_set.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_set_required_test() {
  let mod = input_chip_set.new()
  let cases = [
    #(
      input_chip_set.IsRequired,
      input_chip_set.from_config(
        input_chip_set.Config(
          ..input_chip_set.default_config(),
          required: input_chip_set.IsRequired,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip_set.required(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_set_vertical_test() {
  let mod = input_chip_set.new()
  let cases = [
    #(
      input_chip_set.IsVertical,
      input_chip_set.from_config(
        input_chip_set.Config(
          ..input_chip_set.default_config(),
          vertical: input_chip_set.IsVertical,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip_set.vertical(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_set_render_test() {
  let mod = input_chip_set.new()

  let mod_disabled =
    input_chip_set.new() |> input_chip_set.disabled(input_chip_set.IsDisabled)
  let mod_name = input_chip_set.new() |> input_chip_set.name("test")
  let mod_required =
    input_chip_set.new() |> input_chip_set.required(input_chip_set.IsRequired)
  let mod_vertical =
    input_chip_set.new() |> input_chip_set.vertical(input_chip_set.IsVertical)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-input-chip-set", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-input-chip-set", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-input-chip-set", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-input-chip-set",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element(
        "m3e-input-chip-set",
        [attribute.attribute("name", "test")],
        [],
      ),
    ),
    // Happy path with a required attribute
    #(
      #(mod_required, [], []),
      element.element(
        "m3e-input-chip-set",
        [attribute.attribute("required", "")],
        [],
      ),
    ),
    // Happy path with a vertical attribute
    #(
      #(mod_vertical, [], []),
      element.element(
        "m3e-input-chip-set",
        [attribute.attribute("vertical", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    input_chip_set.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn input_chip_set_slot_test() {
  let cases = [
    #(input_chip_set.Input, attribute.attribute("slot", "input")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    input_chip_set.slot(s)
    |> should.equal(expected)
  })
}

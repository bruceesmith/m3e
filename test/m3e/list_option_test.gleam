//// ListOption unit tests
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
import m3e/list_option.{Config}

pub fn list_option_default_config_test() {
  let cases = [
    Config(
      disabled: list_option.IsNotDisabled,
      selected: list_option.IsNotSelected,
      value: "",
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    list_option.default_config()
    |> should.equal(expected)
  })
}

pub fn list_option_from_config_test() {
  let cases = [
    #(
      list_option.Config(
        disabled: list_option.IsDisabled,
        selected: list_option.IsSelected,
        value: "test",
      ),
      list_option.new()
        |> list_option.disabled(list_option.IsDisabled)
        |> list_option.selected(list_option.IsSelected)
        |> list_option.value("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    list_option.from_config(config)
    |> should.equal(expected)
  })
}

pub fn list_option_new_test() {
  let cases = [
    list_option.from_config(list_option.Config(
      disabled: list_option.IsNotDisabled,
      selected: list_option.IsNotSelected,
      value: "",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    list_option.new()
    |> should.equal(expected)
  })
}

pub fn list_option_disabled_test() {
  let mod = list_option.new()
  let cases = [
    #(
      list_option.IsDisabled,
      list_option.from_config(
        list_option.Config(
          ..list_option.default_config(),
          disabled: list_option.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    list_option.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn list_option_selected_test() {
  let mod = list_option.new()
  let cases = [
    #(
      list_option.IsSelected,
      list_option.from_config(
        list_option.Config(
          ..list_option.default_config(),
          selected: list_option.IsSelected,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    list_option.selected(mod, field)
    |> should.equal(expected)
  })
}

pub fn list_option_value_test() {
  let mod = list_option.new()
  let cases = [
    #(
      "test",
      list_option.from_config(
        list_option.Config(..list_option.default_config(), value: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    list_option.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn list_option_render_test() {
  let mod = list_option.new()

  let mod_disabled =
    list_option.new() |> list_option.disabled(list_option.IsDisabled)
  let mod_selected =
    list_option.new() |> list_option.selected(list_option.IsSelected)
  let mod_value = list_option.new() |> list_option.value("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-list-option", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-list-option", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-list-option", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-list-option",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a selected attribute
    #(
      #(mod_selected, [], []),
      element.element(
        "m3e-list-option",
        [attribute.attribute("selected", "")],
        [],
      ),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element(
        "m3e-list-option",
        [attribute.attribute("value", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    list_option.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn list_option_slot_test() {
  let cases = [
    #(list_option.Leading, attribute.attribute("slot", "leading")),
    #(list_option.Overline, attribute.attribute("slot", "overline")),
    #(
      list_option.SupportingText,
      attribute.attribute("slot", "supporting-text"),
    ),
    #(list_option.Trailing, attribute.attribute("slot", "trailing")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    list_option.slot(s)
    |> should.equal(expected)
  })
}

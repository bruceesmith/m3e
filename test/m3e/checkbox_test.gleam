//// Checkbox unit tests
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
import m3e/checkbox.{Config}

pub fn checkbox_default_config_test() {
  let cases = [
    Config(
      checked: checkbox.IsNotChecked,
      disabled: checkbox.IsNotDisabled,
      indeterminate: checkbox.IsNotIndeterminate,
      name: "",
      required: checkbox.IsNotRequired,
      value: "on",
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    checkbox.default_config()
    |> should.equal(expected)
  })
}

pub fn checkbox_from_config_test() {
  let cases = [
    #(
      checkbox.Config(
        checked: checkbox.IsChecked,
        disabled: checkbox.IsDisabled,
        indeterminate: checkbox.IsIndeterminate,
        name: "test",
        required: checkbox.IsRequired,
        value: "test",
      ),
      checkbox.new()
        |> checkbox.checked(checkbox.IsChecked)
        |> checkbox.disabled(checkbox.IsDisabled)
        |> checkbox.indeterminate(checkbox.IsIndeterminate)
        |> checkbox.name("test")
        |> checkbox.required(checkbox.IsRequired)
        |> checkbox.value("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    checkbox.from_config(config)
    |> should.equal(expected)
  })
}

pub fn checkbox_new_test() {
  let cases = [
    checkbox.from_config(checkbox.Config(
      checked: checkbox.IsNotChecked,
      disabled: checkbox.IsNotDisabled,
      indeterminate: checkbox.IsNotIndeterminate,
      name: "",
      required: checkbox.IsNotRequired,
      value: "on",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    checkbox.new()
    |> should.equal(expected)
  })
}

pub fn checkbox_checked_test() {
  let mod = checkbox.new()
  let cases = [
    #(
      checkbox.IsChecked,
      checkbox.from_config(
        checkbox.Config(
          ..checkbox.default_config(),
          checked: checkbox.IsChecked,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    checkbox.checked(mod, field)
    |> should.equal(expected)
  })
}

pub fn checkbox_disabled_test() {
  let mod = checkbox.new()
  let cases = [
    #(
      checkbox.IsDisabled,
      checkbox.from_config(
        checkbox.Config(
          ..checkbox.default_config(),
          disabled: checkbox.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    checkbox.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn checkbox_indeterminate_test() {
  let mod = checkbox.new()
  let cases = [
    #(
      checkbox.IsIndeterminate,
      checkbox.from_config(
        checkbox.Config(
          ..checkbox.default_config(),
          indeterminate: checkbox.IsIndeterminate,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    checkbox.indeterminate(mod, field)
    |> should.equal(expected)
  })
}

pub fn checkbox_name_test() {
  let mod = checkbox.new()
  let cases = [
    #(
      "test",
      checkbox.from_config(
        checkbox.Config(..checkbox.default_config(), name: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    checkbox.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn checkbox_required_test() {
  let mod = checkbox.new()
  let cases = [
    #(
      checkbox.IsRequired,
      checkbox.from_config(
        checkbox.Config(
          ..checkbox.default_config(),
          required: checkbox.IsRequired,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    checkbox.required(mod, field)
    |> should.equal(expected)
  })
}

pub fn checkbox_value_test() {
  let mod = checkbox.new()
  let cases = [
    #(
      "test",
      checkbox.from_config(
        checkbox.Config(..checkbox.default_config(), value: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    checkbox.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn checkbox_render_test() {
  let mod = checkbox.new()

  let mod_checked = checkbox.new() |> checkbox.checked(checkbox.IsChecked)
  let mod_disabled = checkbox.new() |> checkbox.disabled(checkbox.IsDisabled)
  let mod_indeterminate =
    checkbox.new() |> checkbox.indeterminate(checkbox.IsIndeterminate)
  let mod_name = checkbox.new() |> checkbox.name("test")
  let mod_required = checkbox.new() |> checkbox.required(checkbox.IsRequired)
  let mod_value = checkbox.new() |> checkbox.value("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-checkbox", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-checkbox", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-checkbox", [], [html.br([])]),
    ),

    // Happy path with a checked attribute
    #(
      #(mod_checked, [], []),
      element.element("m3e-checkbox", [attribute.attribute("checked", "")], []),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-checkbox", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a indeterminate attribute
    #(
      #(mod_indeterminate, [], []),
      element.element(
        "m3e-checkbox",
        [attribute.attribute("indeterminate", "")],
        [],
      ),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element("m3e-checkbox", [attribute.attribute("name", "test")], []),
    ),
    // Happy path with a required attribute
    #(
      #(mod_required, [], []),
      element.element("m3e-checkbox", [attribute.attribute("required", "")], []),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element(
        "m3e-checkbox",
        [attribute.attribute("value", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    checkbox.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

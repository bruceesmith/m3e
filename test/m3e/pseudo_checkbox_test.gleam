//// PseudoCheckbox unit tests
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
import m3e/pseudo_checkbox.{Config}

pub fn pseudo_checkbox_default_config_test() {
  let cases = [
    Config(
      checked: pseudo_checkbox.IsNotChecked,
      disabled: pseudo_checkbox.IsNotDisabled,
      indeterminate: pseudo_checkbox.IsNotIndeterminate,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    pseudo_checkbox.default_config()
    |> should.equal(expected)
  })
}

pub fn pseudo_checkbox_from_config_test() {
  let cases = [
    #(
      pseudo_checkbox.Config(
        checked: pseudo_checkbox.IsChecked,
        disabled: pseudo_checkbox.IsDisabled,
        indeterminate: pseudo_checkbox.IsIndeterminate,
      ),
      pseudo_checkbox.new()
        |> pseudo_checkbox.checked(pseudo_checkbox.IsChecked)
        |> pseudo_checkbox.disabled(pseudo_checkbox.IsDisabled)
        |> pseudo_checkbox.indeterminate(pseudo_checkbox.IsIndeterminate),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    pseudo_checkbox.from_config(config)
    |> should.equal(expected)
  })
}

pub fn pseudo_checkbox_new_test() {
  let cases = [
    pseudo_checkbox.from_config(pseudo_checkbox.Config(
      checked: pseudo_checkbox.IsNotChecked,
      disabled: pseudo_checkbox.IsNotDisabled,
      indeterminate: pseudo_checkbox.IsNotIndeterminate,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    pseudo_checkbox.new()
    |> should.equal(expected)
  })
}

pub fn pseudo_checkbox_checked_test() {
  let mod = pseudo_checkbox.new()
  let cases = [
    #(
      pseudo_checkbox.IsChecked,
      pseudo_checkbox.from_config(
        pseudo_checkbox.Config(
          ..pseudo_checkbox.default_config(),
          checked: pseudo_checkbox.IsChecked,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    pseudo_checkbox.checked(mod, field)
    |> should.equal(expected)
  })
}

pub fn pseudo_checkbox_disabled_test() {
  let mod = pseudo_checkbox.new()
  let cases = [
    #(
      pseudo_checkbox.IsDisabled,
      pseudo_checkbox.from_config(
        pseudo_checkbox.Config(
          ..pseudo_checkbox.default_config(),
          disabled: pseudo_checkbox.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    pseudo_checkbox.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn pseudo_checkbox_indeterminate_test() {
  let mod = pseudo_checkbox.new()
  let cases = [
    #(
      pseudo_checkbox.IsIndeterminate,
      pseudo_checkbox.from_config(
        pseudo_checkbox.Config(
          ..pseudo_checkbox.default_config(),
          indeterminate: pseudo_checkbox.IsIndeterminate,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    pseudo_checkbox.indeterminate(mod, field)
    |> should.equal(expected)
  })
}

pub fn pseudo_checkbox_render_test() {
  let mod = pseudo_checkbox.new()

  let mod_checked =
    pseudo_checkbox.new() |> pseudo_checkbox.checked(pseudo_checkbox.IsChecked)
  let mod_disabled =
    pseudo_checkbox.new()
    |> pseudo_checkbox.disabled(pseudo_checkbox.IsDisabled)
  let mod_indeterminate =
    pseudo_checkbox.new()
    |> pseudo_checkbox.indeterminate(pseudo_checkbox.IsIndeterminate)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-pseudo-checkbox", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-pseudo-checkbox", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-pseudo-checkbox", [], [html.br([])]),
    ),

    // Happy path with a checked attribute
    #(
      #(mod_checked, [], []),
      element.element(
        "m3e-pseudo-checkbox",
        [attribute.attribute("checked", "")],
        [],
      ),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-pseudo-checkbox",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a indeterminate attribute
    #(
      #(mod_indeterminate, [], []),
      element.element(
        "m3e-pseudo-checkbox",
        [attribute.attribute("indeterminate", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    pseudo_checkbox.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

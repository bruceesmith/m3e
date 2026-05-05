//// PseudoRadio unit tests
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
import m3e/pseudo_radio.{Config}

pub fn pseudo_radio_default_config_test() {
  let cases = [
    Config(
      checked: pseudo_radio.IsNotChecked,
      disabled: pseudo_radio.IsNotDisabled,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    pseudo_radio.default_config()
    |> should.equal(expected)
  })
}

pub fn pseudo_radio_from_config_test() {
  let cases = [
    #(
      pseudo_radio.Config(
        checked: pseudo_radio.IsChecked,
        disabled: pseudo_radio.IsDisabled,
      ),
      pseudo_radio.new()
        |> pseudo_radio.checked(pseudo_radio.IsChecked)
        |> pseudo_radio.disabled(pseudo_radio.IsDisabled),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    pseudo_radio.from_config(config)
    |> should.equal(expected)
  })
}

pub fn pseudo_radio_new_test() {
  let cases = [
    pseudo_radio.from_config(pseudo_radio.Config(
      checked: pseudo_radio.IsNotChecked,
      disabled: pseudo_radio.IsNotDisabled,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    pseudo_radio.new()
    |> should.equal(expected)
  })
}

pub fn pseudo_radio_checked_test() {
  let mod = pseudo_radio.new()
  let cases = [
    #(
      pseudo_radio.IsChecked,
      pseudo_radio.from_config(
        pseudo_radio.Config(
          ..pseudo_radio.default_config(),
          checked: pseudo_radio.IsChecked,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    pseudo_radio.checked(mod, field)
    |> should.equal(expected)
  })
}

pub fn pseudo_radio_disabled_test() {
  let mod = pseudo_radio.new()
  let cases = [
    #(
      pseudo_radio.IsDisabled,
      pseudo_radio.from_config(
        pseudo_radio.Config(
          ..pseudo_radio.default_config(),
          disabled: pseudo_radio.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    pseudo_radio.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn pseudo_radio_render_test() {
  let mod = pseudo_radio.new()

  let mod_checked =
    pseudo_radio.new() |> pseudo_radio.checked(pseudo_radio.IsChecked)
  let mod_disabled =
    pseudo_radio.new() |> pseudo_radio.disabled(pseudo_radio.IsDisabled)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-pseudo-radio", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-pseudo-radio", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-pseudo-radio", [], [html.br([])]),
    ),

    // Happy path with a checked attribute
    #(
      #(mod_checked, [], []),
      element.element(
        "m3e-pseudo-radio",
        [attribute.attribute("checked", "")],
        [],
      ),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-pseudo-radio",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    pseudo_radio.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

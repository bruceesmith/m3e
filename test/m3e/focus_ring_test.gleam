//// FocusRing unit tests
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/focus_ring.{Config}

pub fn focus_ring_default_config_test() {
  let cases = [
    Config(
      disabled: focus_ring.IsNotDisabled,
      inward: focus_ring.IsNotInward,
      for: None,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    focus_ring.default_config()
    |> should.equal(expected)
  })
}

pub fn focus_ring_from_config_test() {
  let cases = [
    #(
      focus_ring.Config(
        disabled: focus_ring.IsDisabled,
        inward: focus_ring.IsInward,
        for: Some("test"),
      ),
      focus_ring.new()
        |> focus_ring.disabled(focus_ring.IsDisabled)
        |> focus_ring.inward(focus_ring.IsInward)
        |> focus_ring.for(Some("test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    focus_ring.from_config(config)
    |> should.equal(expected)
  })
}

pub fn focus_ring_new_test() {
  let cases = [
    focus_ring.from_config(focus_ring.Config(
      disabled: focus_ring.IsNotDisabled,
      inward: focus_ring.IsNotInward,
      for: None,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    focus_ring.new()
    |> should.equal(expected)
  })
}

pub fn focus_ring_disabled_test() {
  let mod = focus_ring.new()
  let cases = [
    #(
      focus_ring.IsDisabled,
      focus_ring.from_config(
        focus_ring.Config(
          ..focus_ring.default_config(),
          disabled: focus_ring.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    focus_ring.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn focus_ring_inward_test() {
  let mod = focus_ring.new()
  let cases = [
    #(
      focus_ring.IsInward,
      focus_ring.from_config(
        focus_ring.Config(
          ..focus_ring.default_config(),
          inward: focus_ring.IsInward,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    focus_ring.inward(mod, field)
    |> should.equal(expected)
  })
}

pub fn focus_ring_for_test() {
  let mod = focus_ring.new()
  let cases = [
    #(
      Some("test"),
      focus_ring.from_config(
        focus_ring.Config(..focus_ring.default_config(), for: Some("test")),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    focus_ring.for(mod, field)
    |> should.equal(expected)
  })
}

pub fn focus_ring_render_test() {
  let mod = focus_ring.new()

  let mod_disabled =
    focus_ring.new() |> focus_ring.disabled(focus_ring.IsDisabled)
  let mod_inward = focus_ring.new() |> focus_ring.inward(focus_ring.IsInward)
  let mod_for = focus_ring.new() |> focus_ring.for(Some("test"))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-focus-ring", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-focus-ring", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-focus-ring", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-focus-ring",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a inward attribute
    #(
      #(mod_inward, [], []),
      element.element("m3e-focus-ring", [attribute.attribute("inward", "")], []),
    ),
    // Happy path with a for attribute
    #(
      #(mod_for, [], []),
      element.element(
        "m3e-focus-ring",
        [attribute.attribute("for", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    focus_ring.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

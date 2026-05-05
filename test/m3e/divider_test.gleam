//// Divider unit tests
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
import m3e/divider.{Config}

pub fn divider_default_config_test() {
  let cases = [
    Config(
      inset: divider.IsNotInset,
      inset_start: divider.IsNotInsetStart,
      inset_end: divider.IsNotInsetEnd,
      vertical: divider.IsNotVertical,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    divider.default_config()
    |> should.equal(expected)
  })
}

pub fn divider_from_config_test() {
  let cases = [
    #(
      divider.Config(
        inset: divider.IsInset,
        inset_start: divider.IsInsetStart,
        inset_end: divider.IsInsetEnd,
        vertical: divider.IsVertical,
      ),
      divider.new()
        |> divider.inset(divider.IsInset)
        |> divider.inset_start(divider.IsInsetStart)
        |> divider.inset_end(divider.IsInsetEnd)
        |> divider.vertical(divider.IsVertical),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    divider.from_config(config)
    |> should.equal(expected)
  })
}

pub fn divider_new_test() {
  let cases = [
    divider.from_config(divider.Config(
      inset: divider.IsNotInset,
      inset_start: divider.IsNotInsetStart,
      inset_end: divider.IsNotInsetEnd,
      vertical: divider.IsNotVertical,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    divider.new()
    |> should.equal(expected)
  })
}

pub fn divider_inset_test() {
  let mod = divider.new()
  let cases = [
    #(
      divider.IsInset,
      divider.from_config(
        divider.Config(..divider.default_config(), inset: divider.IsInset),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    divider.inset(mod, field)
    |> should.equal(expected)
  })
}

pub fn divider_inset_start_test() {
  let mod = divider.new()
  let cases = [
    #(
      divider.IsInsetStart,
      divider.from_config(
        divider.Config(
          ..divider.default_config(),
          inset_start: divider.IsInsetStart,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    divider.inset_start(mod, field)
    |> should.equal(expected)
  })
}

pub fn divider_inset_end_test() {
  let mod = divider.new()
  let cases = [
    #(
      divider.IsInsetEnd,
      divider.from_config(
        divider.Config(
          ..divider.default_config(),
          inset_end: divider.IsInsetEnd,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    divider.inset_end(mod, field)
    |> should.equal(expected)
  })
}

pub fn divider_vertical_test() {
  let mod = divider.new()
  let cases = [
    #(
      divider.IsVertical,
      divider.from_config(
        divider.Config(..divider.default_config(), vertical: divider.IsVertical),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    divider.vertical(mod, field)
    |> should.equal(expected)
  })
}

pub fn divider_render_test() {
  let mod = divider.new()

  let mod_inset = divider.new() |> divider.inset(divider.IsInset)
  let mod_inset_start =
    divider.new() |> divider.inset_start(divider.IsInsetStart)
  let mod_inset_end = divider.new() |> divider.inset_end(divider.IsInsetEnd)
  let mod_vertical = divider.new() |> divider.vertical(divider.IsVertical)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-divider", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-divider", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-divider", [], [html.br([])]),
    ),

    // Happy path with a inset attribute
    #(
      #(mod_inset, [], []),
      element.element("m3e-divider", [attribute.attribute("inset", "")], []),
    ),
    // Happy path with a inset_start attribute
    #(
      #(mod_inset_start, [], []),
      element.element(
        "m3e-divider",
        [attribute.attribute("inset-start", "")],
        [],
      ),
    ),
    // Happy path with a inset_end attribute
    #(
      #(mod_inset_end, [], []),
      element.element("m3e-divider", [attribute.attribute("inset-end", "")], []),
    ),
    // Happy path with a vertical attribute
    #(
      #(mod_vertical, [], []),
      element.element("m3e-divider", [attribute.attribute("vertical", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    divider.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

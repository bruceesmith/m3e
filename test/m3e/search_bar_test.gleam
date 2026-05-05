//// SearchBar unit tests
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
import m3e/search_bar.{Config}

pub fn search_bar_default_config_test() {
  let cases = [
    Config(clearable: search_bar.IsNotClearable, clear_label: "Clear"),
  ]

  list.each(cases, fn(c) {
    let expected = c

    search_bar.default_config()
    |> should.equal(expected)
  })
}

pub fn search_bar_from_config_test() {
  let cases = [
    #(
      search_bar.Config(clearable: search_bar.IsClearable, clear_label: "test"),
      search_bar.new()
        |> search_bar.clearable(search_bar.IsClearable)
        |> search_bar.clear_label("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    search_bar.from_config(config)
    |> should.equal(expected)
  })
}

pub fn search_bar_new_test() {
  let cases = [
    search_bar.from_config(search_bar.Config(
      clearable: search_bar.IsNotClearable,
      clear_label: "Clear",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    search_bar.new()
    |> should.equal(expected)
  })
}

pub fn search_bar_clearable_test() {
  let mod = search_bar.new()
  let cases = [
    #(
      search_bar.IsClearable,
      search_bar.from_config(
        search_bar.Config(
          ..search_bar.default_config(),
          clearable: search_bar.IsClearable,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    search_bar.clearable(mod, field)
    |> should.equal(expected)
  })
}

pub fn search_bar_clear_label_test() {
  let mod = search_bar.new()
  let cases = [
    #(
      "test",
      search_bar.from_config(
        search_bar.Config(..search_bar.default_config(), clear_label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    search_bar.clear_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn search_bar_render_test() {
  let mod = search_bar.new()

  let mod_clearable =
    search_bar.new() |> search_bar.clearable(search_bar.IsClearable)
  let mod_clear_label = search_bar.new() |> search_bar.clear_label("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-search-bar", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-search-bar", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-search-bar", [], [html.br([])]),
    ),

    // Happy path with a clearable attribute
    #(
      #(mod_clearable, [], []),
      element.element(
        "m3e-search-bar",
        [attribute.attribute("clearable", "")],
        [],
      ),
    ),
    // Happy path with a clear_label attribute
    #(
      #(mod_clear_label, [], []),
      element.element(
        "m3e-search-bar",
        [attribute.attribute("clear-label", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    search_bar.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn search_bar_slot_test() {
  let cases = [
    #(search_bar.Leading, attribute.attribute("slot", "leading")),
    #(search_bar.Input, attribute.attribute("slot", "input")),
    #(search_bar.Trailing, attribute.attribute("slot", "trailing")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    search_bar.slot(s)
    |> should.equal(expected)
  })
}

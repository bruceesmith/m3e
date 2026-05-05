//// TocItem unit tests
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
import m3e/toc_item.{Config}

pub fn toc_item_default_config_test() {
  let cases = [
    Config(disabled: toc_item.IsNotDisabled, selected: toc_item.IsNotSelected),
  ]

  list.each(cases, fn(c) {
    let expected = c

    toc_item.default_config()
    |> should.equal(expected)
  })
}

pub fn toc_item_from_config_test() {
  let cases = [
    #(
      toc_item.Config(
        disabled: toc_item.IsDisabled,
        selected: toc_item.IsSelected,
      ),
      toc_item.new()
        |> toc_item.disabled(toc_item.IsDisabled)
        |> toc_item.selected(toc_item.IsSelected),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    toc_item.from_config(config)
    |> should.equal(expected)
  })
}

pub fn toc_item_new_test() {
  let cases = [
    toc_item.from_config(toc_item.Config(
      disabled: toc_item.IsNotDisabled,
      selected: toc_item.IsNotSelected,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    toc_item.new()
    |> should.equal(expected)
  })
}

pub fn toc_item_disabled_test() {
  let mod = toc_item.new()
  let cases = [
    #(
      toc_item.IsDisabled,
      toc_item.from_config(
        toc_item.Config(
          ..toc_item.default_config(),
          disabled: toc_item.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    toc_item.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn toc_item_selected_test() {
  let mod = toc_item.new()
  let cases = [
    #(
      toc_item.IsSelected,
      toc_item.from_config(
        toc_item.Config(
          ..toc_item.default_config(),
          selected: toc_item.IsSelected,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    toc_item.selected(mod, field)
    |> should.equal(expected)
  })
}

pub fn toc_item_render_test() {
  let mod = toc_item.new()

  let mod_disabled = toc_item.new() |> toc_item.disabled(toc_item.IsDisabled)
  let mod_selected = toc_item.new() |> toc_item.selected(toc_item.IsSelected)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-toc-item", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-toc-item", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-toc-item", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-toc-item", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a selected attribute
    #(
      #(mod_selected, [], []),
      element.element("m3e-toc-item", [attribute.attribute("selected", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    toc_item.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

//// ScrollContainer unit tests
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
import m3e/scroll_container.{Config}
import m3e/scroll_dividers

pub fn scroll_container_default_config_test() {
  let cases = [
    Config(
      dividers: scroll_dividers.AboveBelow,
      thin: scroll_container.IsNotThin,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    scroll_container.default_config()
    |> should.equal(expected)
  })
}

pub fn scroll_container_from_config_test() {
  let cases = [
    #(
      scroll_container.Config(
        dividers: scroll_dividers.Above,
        thin: scroll_container.IsThin,
      ),
      scroll_container.new()
        |> scroll_container.dividers(scroll_dividers.Above)
        |> scroll_container.thin(scroll_container.IsThin),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    scroll_container.from_config(config)
    |> should.equal(expected)
  })
}

pub fn scroll_container_new_test() {
  let cases = [
    scroll_container.from_config(scroll_container.Config(
      dividers: scroll_dividers.AboveBelow,
      thin: scroll_container.IsNotThin,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    scroll_container.new()
    |> should.equal(expected)
  })
}

pub fn scroll_container_dividers_test() {
  let mod = scroll_container.new()
  let cases = [
    #(
      scroll_dividers.Above,
      scroll_container.from_config(
        scroll_container.Config(
          ..scroll_container.default_config(),
          dividers: scroll_dividers.Above,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    scroll_container.dividers(mod, field)
    |> should.equal(expected)
  })
}

pub fn scroll_container_thin_test() {
  let mod = scroll_container.new()
  let cases = [
    #(
      scroll_container.IsThin,
      scroll_container.from_config(
        scroll_container.Config(
          ..scroll_container.default_config(),
          thin: scroll_container.IsThin,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    scroll_container.thin(mod, field)
    |> should.equal(expected)
  })
}

pub fn scroll_container_render_test() {
  let mod = scroll_container.new()

  let mod_dividers =
    scroll_container.new() |> scroll_container.dividers(scroll_dividers.Above)
  let mod_thin =
    scroll_container.new() |> scroll_container.thin(scroll_container.IsThin)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-scroll-container", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-scroll-container", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-scroll-container", [], [html.br([])]),
    ),

    // Happy path with a dividers attribute
    #(
      #(mod_dividers, [], []),
      element.element(
        "m3e-scroll-container",
        [
          attribute.attribute(
            "dividers",
            scroll_dividers.to_string(scroll_dividers.Above),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a thin attribute
    #(
      #(mod_thin, [], []),
      element.element(
        "m3e-scroll-container",
        [attribute.attribute("thin", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    scroll_container.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

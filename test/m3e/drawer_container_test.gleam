//// DrawerContainer unit tests
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
import m3e/drawer_container.{Config}
import m3e/drawer_mode

pub fn drawer_container_default_config_test() {
  let cases = [
    Config(
      end: drawer_container.IsNotEnd,
      end_mode: drawer_mode.Side,
      end_divider: drawer_container.IsNotEndDivider,
      start: drawer_container.IsNotStart,
      start_mode: drawer_mode.Side,
      start_divider: drawer_container.IsNotStartDivider,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    drawer_container.default_config()
    |> should.equal(expected)
  })
}

pub fn drawer_container_from_config_test() {
  let cases = [
    #(
      drawer_container.Config(
        end: drawer_container.IsEnd,
        end_mode: drawer_mode.Over,
        end_divider: drawer_container.IsEndDivider,
        start: drawer_container.IsStart,
        start_mode: drawer_mode.Over,
        start_divider: drawer_container.IsStartDivider,
      ),
      drawer_container.new()
        |> drawer_container.end(drawer_container.IsEnd)
        |> drawer_container.end_mode(drawer_mode.Over)
        |> drawer_container.end_divider(drawer_container.IsEndDivider)
        |> drawer_container.start(drawer_container.IsStart)
        |> drawer_container.start_mode(drawer_mode.Over)
        |> drawer_container.start_divider(drawer_container.IsStartDivider),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    drawer_container.from_config(config)
    |> should.equal(expected)
  })
}

pub fn drawer_container_new_test() {
  let cases = [
    drawer_container.from_config(drawer_container.Config(
      end: drawer_container.IsNotEnd,
      end_mode: drawer_mode.Side,
      end_divider: drawer_container.IsNotEndDivider,
      start: drawer_container.IsNotStart,
      start_mode: drawer_mode.Side,
      start_divider: drawer_container.IsNotStartDivider,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    drawer_container.new()
    |> should.equal(expected)
  })
}

pub fn drawer_container_end_test() {
  let mod = drawer_container.new()
  let cases = [
    #(
      drawer_container.IsEnd,
      drawer_container.from_config(
        drawer_container.Config(
          ..drawer_container.default_config(),
          end: drawer_container.IsEnd,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    drawer_container.end(mod, field)
    |> should.equal(expected)
  })
}

pub fn drawer_container_end_mode_test() {
  let mod = drawer_container.new()
  let cases = [
    #(
      drawer_mode.Over,
      drawer_container.from_config(
        drawer_container.Config(
          ..drawer_container.default_config(),
          end_mode: drawer_mode.Over,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    drawer_container.end_mode(mod, field)
    |> should.equal(expected)
  })
}

pub fn drawer_container_end_divider_test() {
  let mod = drawer_container.new()
  let cases = [
    #(
      drawer_container.IsEndDivider,
      drawer_container.from_config(
        drawer_container.Config(
          ..drawer_container.default_config(),
          end_divider: drawer_container.IsEndDivider,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    drawer_container.end_divider(mod, field)
    |> should.equal(expected)
  })
}

pub fn drawer_container_start_test() {
  let mod = drawer_container.new()
  let cases = [
    #(
      drawer_container.IsStart,
      drawer_container.from_config(
        drawer_container.Config(
          ..drawer_container.default_config(),
          start: drawer_container.IsStart,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    drawer_container.start(mod, field)
    |> should.equal(expected)
  })
}

pub fn drawer_container_start_mode_test() {
  let mod = drawer_container.new()
  let cases = [
    #(
      drawer_mode.Over,
      drawer_container.from_config(
        drawer_container.Config(
          ..drawer_container.default_config(),
          start_mode: drawer_mode.Over,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    drawer_container.start_mode(mod, field)
    |> should.equal(expected)
  })
}

pub fn drawer_container_start_divider_test() {
  let mod = drawer_container.new()
  let cases = [
    #(
      drawer_container.IsStartDivider,
      drawer_container.from_config(
        drawer_container.Config(
          ..drawer_container.default_config(),
          start_divider: drawer_container.IsStartDivider,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    drawer_container.start_divider(mod, field)
    |> should.equal(expected)
  })
}

pub fn drawer_container_render_test() {
  let mod = drawer_container.new()

  let mod_end =
    drawer_container.new() |> drawer_container.end(drawer_container.IsEnd)
  let mod_end_mode =
    drawer_container.new() |> drawer_container.end_mode(drawer_mode.Over)
  let mod_end_divider =
    drawer_container.new()
    |> drawer_container.end_divider(drawer_container.IsEndDivider)
  let mod_start =
    drawer_container.new() |> drawer_container.start(drawer_container.IsStart)
  let mod_start_mode =
    drawer_container.new() |> drawer_container.start_mode(drawer_mode.Over)
  let mod_start_divider =
    drawer_container.new()
    |> drawer_container.start_divider(drawer_container.IsStartDivider)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-drawer-container", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-drawer-container", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-drawer-container", [], [html.br([])]),
    ),

    // Happy path with a end attribute
    #(
      #(mod_end, [], []),
      element.element(
        "m3e-drawer-container",
        [attribute.attribute("end", "")],
        [],
      ),
    ),
    // Happy path with a end_mode attribute
    #(
      #(mod_end_mode, [], []),
      element.element(
        "m3e-drawer-container",
        [
          attribute.attribute(
            "end-mode",
            drawer_mode.to_string(drawer_mode.Over),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a end_divider attribute
    #(
      #(mod_end_divider, [], []),
      element.element(
        "m3e-drawer-container",
        [attribute.attribute("end-divider", "")],
        [],
      ),
    ),
    // Happy path with a start attribute
    #(
      #(mod_start, [], []),
      element.element(
        "m3e-drawer-container",
        [attribute.attribute("start", "")],
        [],
      ),
    ),
    // Happy path with a start_mode attribute
    #(
      #(mod_start_mode, [], []),
      element.element(
        "m3e-drawer-container",
        [
          attribute.attribute(
            "start-mode",
            drawer_mode.to_string(drawer_mode.Over),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a start_divider attribute
    #(
      #(mod_start_divider, [], []),
      element.element(
        "m3e-drawer-container",
        [attribute.attribute("start-divider", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    drawer_container.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn drawer_container_slot_test() {
  let cases = [
    #(drawer_container.Start, attribute.attribute("slot", "start")),
    #(drawer_container.End, attribute.attribute("slot", "end")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    drawer_container.slot(s)
    |> should.equal(expected)
  })
}

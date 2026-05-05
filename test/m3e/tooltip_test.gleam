//// Tooltip unit tests
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
import m3e/tooltip.{Config}
import m3e/tooltip_position
import m3e/tooltip_touch_gestures

pub fn tooltip_default_config_test() {
  let cases = [
    Config(
      disabled: tooltip.IsNotDisabled,
      for: None,
      hide_delay: 200.0,
      position: tooltip_position.Below,
      show_delay: 0.0,
      touch_gestures: tooltip_touch_gestures.Auto,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    tooltip.default_config()
    |> should.equal(expected)
  })
}

pub fn tooltip_from_config_test() {
  let cases = [
    #(
      tooltip.Config(
        disabled: tooltip.IsDisabled,
        for: Some("test"),
        hide_delay: 42.0,
        position: tooltip_position.Above,
        show_delay: 42.0,
        touch_gestures: tooltip_touch_gestures.On,
      ),
      tooltip.new()
        |> tooltip.disabled(tooltip.IsDisabled)
        |> tooltip.for(Some("test"))
        |> tooltip.hide_delay(42.0)
        |> tooltip.position(tooltip_position.Above)
        |> tooltip.show_delay(42.0)
        |> tooltip.touch_gestures(tooltip_touch_gestures.On),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    tooltip.from_config(config)
    |> should.equal(expected)
  })
}

pub fn tooltip_new_test() {
  let cases = [
    tooltip.from_config(tooltip.Config(
      disabled: tooltip.IsNotDisabled,
      for: None,
      hide_delay: 200.0,
      position: tooltip_position.Below,
      show_delay: 0.0,
      touch_gestures: tooltip_touch_gestures.Auto,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    tooltip.new()
    |> should.equal(expected)
  })
}

pub fn tooltip_disabled_test() {
  let mod = tooltip.new()
  let cases = [
    #(
      tooltip.IsDisabled,
      tooltip.from_config(
        tooltip.Config(..tooltip.default_config(), disabled: tooltip.IsDisabled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tooltip.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn tooltip_for_test() {
  let mod = tooltip.new()
  let cases = [
    #(
      Some("test"),
      tooltip.from_config(
        tooltip.Config(..tooltip.default_config(), for: Some("test")),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tooltip.for(mod, field)
    |> should.equal(expected)
  })
}

pub fn tooltip_hide_delay_test() {
  let mod = tooltip.new()
  let cases = [
    #(
      42.0,
      tooltip.from_config(
        tooltip.Config(..tooltip.default_config(), hide_delay: 42.0),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tooltip.hide_delay(mod, field)
    |> should.equal(expected)
  })
}

pub fn tooltip_position_test() {
  let mod = tooltip.new()
  let cases = [
    #(
      tooltip_position.Above,
      tooltip.from_config(
        tooltip.Config(
          ..tooltip.default_config(),
          position: tooltip_position.Above,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tooltip.position(mod, field)
    |> should.equal(expected)
  })
}

pub fn tooltip_show_delay_test() {
  let mod = tooltip.new()
  let cases = [
    #(
      42.0,
      tooltip.from_config(
        tooltip.Config(..tooltip.default_config(), show_delay: 42.0),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tooltip.show_delay(mod, field)
    |> should.equal(expected)
  })
}

pub fn tooltip_touch_gestures_test() {
  let mod = tooltip.new()
  let cases = [
    #(
      tooltip_touch_gestures.On,
      tooltip.from_config(
        tooltip.Config(
          ..tooltip.default_config(),
          touch_gestures: tooltip_touch_gestures.On,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tooltip.touch_gestures(mod, field)
    |> should.equal(expected)
  })
}

pub fn tooltip_render_test() {
  let mod = tooltip.new()

  let mod_disabled = tooltip.new() |> tooltip.disabled(tooltip.IsDisabled)
  let mod_for = tooltip.new() |> tooltip.for(Some("test"))
  let mod_hide_delay = tooltip.new() |> tooltip.hide_delay(42.0)
  let mod_position = tooltip.new() |> tooltip.position(tooltip_position.Above)
  let mod_show_delay = tooltip.new() |> tooltip.show_delay(42.0)
  let mod_touch_gestures =
    tooltip.new() |> tooltip.touch_gestures(tooltip_touch_gestures.On)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-tooltip", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-tooltip", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-tooltip", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-tooltip", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a for attribute
    #(
      #(mod_for, [], []),
      element.element("m3e-tooltip", [attribute.attribute("for", "test")], []),
    ),
    // Happy path with a hide_delay attribute
    #(
      #(mod_hide_delay, [], []),
      element.element(
        "m3e-tooltip",
        [attribute.attribute("hide-delay", "42.0")],
        [],
      ),
    ),
    // Happy path with a position attribute
    #(
      #(mod_position, [], []),
      element.element(
        "m3e-tooltip",
        [
          attribute.attribute(
            "position",
            tooltip_position.to_string(tooltip_position.Above),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a show_delay attribute
    #(
      #(mod_show_delay, [], []),
      element.element(
        "m3e-tooltip",
        [attribute.attribute("show-delay", "42.0")],
        [],
      ),
    ),
    // Happy path with a touch_gestures attribute
    #(
      #(mod_touch_gestures, [], []),
      element.element(
        "m3e-tooltip",
        [
          attribute.attribute(
            "touch-gestures",
            tooltip_touch_gestures.to_string(tooltip_touch_gestures.On),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    tooltip.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

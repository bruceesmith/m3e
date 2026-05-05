//// ExpansionHeader unit tests
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
import m3e/expansion_header.{Config}
import m3e/expansion_toggle_direction
import m3e/expansion_toggle_position

pub fn expansion_header_default_config_test() {
  let cases = [
    Config(
      hide_toggle: expansion_header.IsNotHideToggle,
      toggle_direction: expansion_toggle_direction.Vertical,
      toggle_position: expansion_toggle_position.After,
      disabled: expansion_header.IsNotDisabled,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    expansion_header.default_config()
    |> should.equal(expected)
  })
}

pub fn expansion_header_from_config_test() {
  let cases = [
    #(
      expansion_header.Config(
        hide_toggle: expansion_header.IsHideToggle,
        toggle_direction: expansion_toggle_direction.Horizontal,
        toggle_position: expansion_toggle_position.Before,
        disabled: expansion_header.IsDisabled,
      ),
      expansion_header.new()
        |> expansion_header.hide_toggle(expansion_header.IsHideToggle)
        |> expansion_header.toggle_direction(
          expansion_toggle_direction.Horizontal,
        )
        |> expansion_header.toggle_position(expansion_toggle_position.Before)
        |> expansion_header.disabled(expansion_header.IsDisabled),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    expansion_header.from_config(config)
    |> should.equal(expected)
  })
}

pub fn expansion_header_new_test() {
  let cases = [
    expansion_header.from_config(expansion_header.Config(
      hide_toggle: expansion_header.IsNotHideToggle,
      toggle_direction: expansion_toggle_direction.Vertical,
      toggle_position: expansion_toggle_position.After,
      disabled: expansion_header.IsNotDisabled,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    expansion_header.new()
    |> should.equal(expected)
  })
}

pub fn expansion_header_hide_toggle_test() {
  let mod = expansion_header.new()
  let cases = [
    #(
      expansion_header.IsHideToggle,
      expansion_header.from_config(
        expansion_header.Config(
          ..expansion_header.default_config(),
          hide_toggle: expansion_header.IsHideToggle,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expansion_header.hide_toggle(mod, field)
    |> should.equal(expected)
  })
}

pub fn expansion_header_toggle_direction_test() {
  let mod = expansion_header.new()
  let cases = [
    #(
      expansion_toggle_direction.Horizontal,
      expansion_header.from_config(
        expansion_header.Config(
          ..expansion_header.default_config(),
          toggle_direction: expansion_toggle_direction.Horizontal,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expansion_header.toggle_direction(mod, field)
    |> should.equal(expected)
  })
}

pub fn expansion_header_toggle_position_test() {
  let mod = expansion_header.new()
  let cases = [
    #(
      expansion_toggle_position.Before,
      expansion_header.from_config(
        expansion_header.Config(
          ..expansion_header.default_config(),
          toggle_position: expansion_toggle_position.Before,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expansion_header.toggle_position(mod, field)
    |> should.equal(expected)
  })
}

pub fn expansion_header_disabled_test() {
  let mod = expansion_header.new()
  let cases = [
    #(
      expansion_header.IsDisabled,
      expansion_header.from_config(
        expansion_header.Config(
          ..expansion_header.default_config(),
          disabled: expansion_header.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expansion_header.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn expansion_header_render_test() {
  let mod = expansion_header.new()

  let mod_hide_toggle =
    expansion_header.new()
    |> expansion_header.hide_toggle(expansion_header.IsHideToggle)
  let mod_toggle_direction =
    expansion_header.new()
    |> expansion_header.toggle_direction(expansion_toggle_direction.Horizontal)
  let mod_toggle_position =
    expansion_header.new()
    |> expansion_header.toggle_position(expansion_toggle_position.Before)
  let mod_disabled =
    expansion_header.new()
    |> expansion_header.disabled(expansion_header.IsDisabled)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-expansion-header", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-expansion-header", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-expansion-header", [], [html.br([])]),
    ),

    // Happy path with a hide_toggle attribute
    #(
      #(mod_hide_toggle, [], []),
      element.element(
        "m3e-expansion-header",
        [attribute.attribute("hide-toggle", "")],
        [],
      ),
    ),
    // Happy path with a toggle_direction attribute
    #(
      #(mod_toggle_direction, [], []),
      element.element(
        "m3e-expansion-header",
        [
          attribute.attribute(
            "toggle-direction",
            expansion_toggle_direction.to_string(
              expansion_toggle_direction.Horizontal,
            ),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a toggle_position attribute
    #(
      #(mod_toggle_position, [], []),
      element.element(
        "m3e-expansion-header",
        [
          attribute.attribute(
            "toggle-position",
            expansion_toggle_position.to_string(
              expansion_toggle_position.Before,
            ),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-expansion-header",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    expansion_header.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn expansion_header_slot_test() {
  let cases = [
    #(expansion_header.ToggleIcon, attribute.attribute("slot", "toggle-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    expansion_header.slot(s)
    |> should.equal(expected)
  })
}

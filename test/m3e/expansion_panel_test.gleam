//// ExpansionPanel unit tests
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
import m3e/expansion_panel.{Config}
import m3e/expansion_toggle_direction
import m3e/expansion_toggle_position

pub fn expansion_panel_default_config_test() {
  let cases = [
    Config(
      disabled: expansion_panel.IsNotDisabled,
      hide_toggle: expansion_panel.IsNotHideToggle,
      open: expansion_panel.IsNotOpen,
      toggle_direction: expansion_toggle_direction.Vertical,
      toggle_position: expansion_toggle_position.After,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    expansion_panel.default_config()
    |> should.equal(expected)
  })
}

pub fn expansion_panel_from_config_test() {
  let cases = [
    #(
      expansion_panel.Config(
        disabled: expansion_panel.IsDisabled,
        hide_toggle: expansion_panel.IsHideToggle,
        open: expansion_panel.IsOpen,
        toggle_direction: expansion_toggle_direction.Horizontal,
        toggle_position: expansion_toggle_position.Before,
      ),
      expansion_panel.new()
        |> expansion_panel.disabled(expansion_panel.IsDisabled)
        |> expansion_panel.hide_toggle(expansion_panel.IsHideToggle)
        |> expansion_panel.open(expansion_panel.IsOpen)
        |> expansion_panel.toggle_direction(
          expansion_toggle_direction.Horizontal,
        )
        |> expansion_panel.toggle_position(expansion_toggle_position.Before),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    expansion_panel.from_config(config)
    |> should.equal(expected)
  })
}

pub fn expansion_panel_new_test() {
  let cases = [
    expansion_panel.from_config(expansion_panel.Config(
      disabled: expansion_panel.IsNotDisabled,
      hide_toggle: expansion_panel.IsNotHideToggle,
      open: expansion_panel.IsNotOpen,
      toggle_direction: expansion_toggle_direction.Vertical,
      toggle_position: expansion_toggle_position.After,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    expansion_panel.new()
    |> should.equal(expected)
  })
}

pub fn expansion_panel_disabled_test() {
  let mod = expansion_panel.new()
  let cases = [
    #(
      expansion_panel.IsDisabled,
      expansion_panel.from_config(
        expansion_panel.Config(
          ..expansion_panel.default_config(),
          disabled: expansion_panel.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expansion_panel.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn expansion_panel_hide_toggle_test() {
  let mod = expansion_panel.new()
  let cases = [
    #(
      expansion_panel.IsHideToggle,
      expansion_panel.from_config(
        expansion_panel.Config(
          ..expansion_panel.default_config(),
          hide_toggle: expansion_panel.IsHideToggle,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expansion_panel.hide_toggle(mod, field)
    |> should.equal(expected)
  })
}

pub fn expansion_panel_open_test() {
  let mod = expansion_panel.new()
  let cases = [
    #(
      expansion_panel.IsOpen,
      expansion_panel.from_config(
        expansion_panel.Config(
          ..expansion_panel.default_config(),
          open: expansion_panel.IsOpen,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expansion_panel.open(mod, field)
    |> should.equal(expected)
  })
}

pub fn expansion_panel_toggle_direction_test() {
  let mod = expansion_panel.new()
  let cases = [
    #(
      expansion_toggle_direction.Horizontal,
      expansion_panel.from_config(
        expansion_panel.Config(
          ..expansion_panel.default_config(),
          toggle_direction: expansion_toggle_direction.Horizontal,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expansion_panel.toggle_direction(mod, field)
    |> should.equal(expected)
  })
}

pub fn expansion_panel_toggle_position_test() {
  let mod = expansion_panel.new()
  let cases = [
    #(
      expansion_toggle_position.Before,
      expansion_panel.from_config(
        expansion_panel.Config(
          ..expansion_panel.default_config(),
          toggle_position: expansion_toggle_position.Before,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expansion_panel.toggle_position(mod, field)
    |> should.equal(expected)
  })
}

pub fn expansion_panel_render_test() {
  let mod = expansion_panel.new()

  let mod_disabled =
    expansion_panel.new()
    |> expansion_panel.disabled(expansion_panel.IsDisabled)
  let mod_hide_toggle =
    expansion_panel.new()
    |> expansion_panel.hide_toggle(expansion_panel.IsHideToggle)
  let mod_open =
    expansion_panel.new() |> expansion_panel.open(expansion_panel.IsOpen)
  let mod_toggle_direction =
    expansion_panel.new()
    |> expansion_panel.toggle_direction(expansion_toggle_direction.Horizontal)
  let mod_toggle_position =
    expansion_panel.new()
    |> expansion_panel.toggle_position(expansion_toggle_position.Before)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-expansion-panel", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-expansion-panel", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-expansion-panel", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-expansion-panel",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a hide_toggle attribute
    #(
      #(mod_hide_toggle, [], []),
      element.element(
        "m3e-expansion-panel",
        [attribute.attribute("hide-toggle", "")],
        [],
      ),
    ),
    // Happy path with a open attribute
    #(
      #(mod_open, [], []),
      element.element(
        "m3e-expansion-panel",
        [attribute.attribute("open", "")],
        [],
      ),
    ),
    // Happy path with a toggle_direction attribute
    #(
      #(mod_toggle_direction, [], []),
      element.element(
        "m3e-expansion-panel",
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
        "m3e-expansion-panel",
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
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    expansion_panel.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn expansion_panel_slot_test() {
  let cases = [
    #(expansion_panel.Actions, attribute.attribute("slot", "actions")),
    #(expansion_panel.Header, attribute.attribute("slot", "header")),
    #(expansion_panel.ToggleIcon, attribute.attribute("slot", "toggle-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    expansion_panel.slot(s)
    |> should.equal(expected)
  })
}

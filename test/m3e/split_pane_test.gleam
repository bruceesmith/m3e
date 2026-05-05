//// SplitPane unit tests
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
import m3e/split_pane.{Config}
import m3e/split_pane_orientation

pub fn split_pane_default_config_test() {
  let cases = [
    Config(
      detents: [],
      label: "Resize panes",
      max: 100.0,
      min: 0.0,
      orientation: split_pane_orientation.Horizontal,
      overshoot_limit: 4.0,
      step: 1.0,
      value: 50.0,
      wrap_detents: split_pane.IsNotWrapDetents,
      value_formatter: "",
      name: "",
      disabled: split_pane.IsNotDisabled,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    split_pane.default_config()
    |> should.equal(expected)
  })
}

pub fn split_pane_from_config_test() {
  let cases = [
    #(
      split_pane.Config(
        detents: ["test1", "test2"],
        label: "test",
        max: 42.0,
        min: 42.0,
        orientation: split_pane_orientation.Vertical,
        overshoot_limit: 42.0,
        step: 42.0,
        value: 42.0,
        wrap_detents: split_pane.IsWrapDetents,
        value_formatter: "test",
        name: "test",
        disabled: split_pane.IsDisabled,
      ),
      split_pane.new()
        |> split_pane.detents(["test1", "test2"])
        |> split_pane.label("test")
        |> split_pane.max(42.0)
        |> split_pane.min(42.0)
        |> split_pane.orientation(split_pane_orientation.Vertical)
        |> split_pane.overshoot_limit(42.0)
        |> split_pane.step(42.0)
        |> split_pane.value(42.0)
        |> split_pane.wrap_detents(split_pane.IsWrapDetents)
        |> split_pane.value_formatter("test")
        |> split_pane.name("test")
        |> split_pane.disabled(split_pane.IsDisabled),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    split_pane.from_config(config)
    |> should.equal(expected)
  })
}

pub fn split_pane_new_test() {
  let cases = [
    split_pane.from_config(split_pane.Config(
      detents: [],
      label: "Resize panes",
      max: 100.0,
      min: 0.0,
      orientation: split_pane_orientation.Horizontal,
      overshoot_limit: 4.0,
      step: 1.0,
      value: 50.0,
      wrap_detents: split_pane.IsNotWrapDetents,
      value_formatter: "",
      name: "",
      disabled: split_pane.IsNotDisabled,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    split_pane.new()
    |> should.equal(expected)
  })
}

pub fn split_pane_detents_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      ["test1", "test2"],
      split_pane.from_config(
        split_pane.Config(..split_pane.default_config(), detents: [
          "test1",
          "test2",
        ]),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.detents(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_label_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      "test",
      split_pane.from_config(
        split_pane.Config(..split_pane.default_config(), label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.label(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_max_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      42.0,
      split_pane.from_config(
        split_pane.Config(..split_pane.default_config(), max: 42.0),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.max(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_min_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      42.0,
      split_pane.from_config(
        split_pane.Config(..split_pane.default_config(), min: 42.0),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.min(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_orientation_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      split_pane_orientation.Vertical,
      split_pane.from_config(
        split_pane.Config(
          ..split_pane.default_config(),
          orientation: split_pane_orientation.Vertical,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.orientation(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_overshoot_limit_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      42.0,
      split_pane.from_config(
        split_pane.Config(..split_pane.default_config(), overshoot_limit: 42.0),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.overshoot_limit(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_step_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      42.0,
      split_pane.from_config(
        split_pane.Config(..split_pane.default_config(), step: 42.0),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.step(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_value_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      42.0,
      split_pane.from_config(
        split_pane.Config(..split_pane.default_config(), value: 42.0),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_wrap_detents_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      split_pane.IsWrapDetents,
      split_pane.from_config(
        split_pane.Config(
          ..split_pane.default_config(),
          wrap_detents: split_pane.IsWrapDetents,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.wrap_detents(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_value_formatter_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      "test",
      split_pane.from_config(
        split_pane.Config(
          ..split_pane.default_config(),
          value_formatter: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.value_formatter(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_name_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      "test",
      split_pane.from_config(
        split_pane.Config(..split_pane.default_config(), name: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_disabled_test() {
  let mod = split_pane.new()
  let cases = [
    #(
      split_pane.IsDisabled,
      split_pane.from_config(
        split_pane.Config(
          ..split_pane.default_config(),
          disabled: split_pane.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_pane.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_pane_render_test() {
  let mod = split_pane.new()

  let mod_detents = split_pane.new() |> split_pane.detents(["test1", "test2"])
  let mod_label = split_pane.new() |> split_pane.label("test")
  let mod_max = split_pane.new() |> split_pane.max(42.0)
  let mod_min = split_pane.new() |> split_pane.min(42.0)
  let mod_orientation =
    split_pane.new() |> split_pane.orientation(split_pane_orientation.Vertical)
  let mod_overshoot_limit = split_pane.new() |> split_pane.overshoot_limit(42.0)
  let mod_step = split_pane.new() |> split_pane.step(42.0)
  let mod_value = split_pane.new() |> split_pane.value(42.0)
  let mod_wrap_detents =
    split_pane.new() |> split_pane.wrap_detents(split_pane.IsWrapDetents)
  let mod_value_formatter =
    split_pane.new() |> split_pane.value_formatter("test")
  let mod_name = split_pane.new() |> split_pane.name("test")
  let mod_disabled =
    split_pane.new() |> split_pane.disabled(split_pane.IsDisabled)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-split-pane", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-split-pane", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-split-pane", [], [html.br([])]),
    ),

    // Happy path with a detents attribute
    #(
      #(mod_detents, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("detents", "test1 test2")],
        [],
      ),
    ),
    // Happy path with a label attribute
    #(
      #(mod_label, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("label", "test")],
        [],
      ),
    ),
    // Happy path with a max attribute
    #(
      #(mod_max, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("max", "42.0")],
        [],
      ),
    ),
    // Happy path with a min attribute
    #(
      #(mod_min, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("min", "42.0")],
        [],
      ),
    ),
    // Happy path with a orientation attribute
    #(
      #(mod_orientation, [], []),
      element.element(
        "m3e-split-pane",
        [
          attribute.attribute(
            "orientation",
            split_pane_orientation.to_string(split_pane_orientation.Vertical),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a overshoot_limit attribute
    #(
      #(mod_overshoot_limit, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("overshoot-limit", "42.0")],
        [],
      ),
    ),
    // Happy path with a step attribute
    #(
      #(mod_step, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("step", "42.0")],
        [],
      ),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("value", "42.0")],
        [],
      ),
    ),
    // Happy path with a wrap_detents attribute
    #(
      #(mod_wrap_detents, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("wrap-detents", "")],
        [],
      ),
    ),
    // Happy path with a value_formatter attribute
    #(
      #(mod_value_formatter, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("value-formatter", "test")],
        [],
      ),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("name", "test")],
        [],
      ),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-split-pane",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    split_pane.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn split_pane_slot_test() {
  let cases = [
    #(split_pane.Start, attribute.attribute("slot", "start")),
    #(split_pane.End, attribute.attribute("slot", "end")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    split_pane.slot(s)
    |> should.equal(expected)
  })
}

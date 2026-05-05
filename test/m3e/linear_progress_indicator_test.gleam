//// LinearProgressIndicator unit tests
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
import m3e/linear_progress_indicator.{Config}
import m3e/linear_progress_mode
import m3e/progress_indicator_variant

pub fn linear_progress_indicator_default_config_test() {
  let cases = [
    Config(
      buffer_value: 0.0,
      max: 100.0,
      mode: linear_progress_mode.Determinate,
      value: 0.0,
      variant: progress_indicator_variant.Flat,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    linear_progress_indicator.default_config()
    |> should.equal(expected)
  })
}

pub fn linear_progress_indicator_from_config_test() {
  let cases = [
    #(
      linear_progress_indicator.Config(
        buffer_value: 42.0,
        max: 42.0,
        mode: linear_progress_mode.Indeterminate,
        value: 42.0,
        variant: progress_indicator_variant.Wavy,
      ),
      linear_progress_indicator.new()
        |> linear_progress_indicator.buffer_value(42.0)
        |> linear_progress_indicator.max(42.0)
        |> linear_progress_indicator.mode(linear_progress_mode.Indeterminate)
        |> linear_progress_indicator.value(42.0)
        |> linear_progress_indicator.variant(progress_indicator_variant.Wavy),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    linear_progress_indicator.from_config(config)
    |> should.equal(expected)
  })
}

pub fn linear_progress_indicator_new_test() {
  let cases = [
    linear_progress_indicator.from_config(linear_progress_indicator.Config(
      buffer_value: 0.0,
      max: 100.0,
      mode: linear_progress_mode.Determinate,
      value: 0.0,
      variant: progress_indicator_variant.Flat,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    linear_progress_indicator.new()
    |> should.equal(expected)
  })
}

pub fn linear_progress_indicator_buffer_value_test() {
  let mod = linear_progress_indicator.new()
  let cases = [
    #(
      42.0,
      linear_progress_indicator.from_config(
        linear_progress_indicator.Config(
          ..linear_progress_indicator.default_config(),
          buffer_value: 42.0,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    linear_progress_indicator.buffer_value(mod, field)
    |> should.equal(expected)
  })
}

pub fn linear_progress_indicator_max_test() {
  let mod = linear_progress_indicator.new()
  let cases = [
    #(
      42.0,
      linear_progress_indicator.from_config(
        linear_progress_indicator.Config(
          ..linear_progress_indicator.default_config(),
          max: 42.0,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    linear_progress_indicator.max(mod, field)
    |> should.equal(expected)
  })
}

pub fn linear_progress_indicator_mode_test() {
  let mod = linear_progress_indicator.new()
  let cases = [
    #(
      linear_progress_mode.Indeterminate,
      linear_progress_indicator.from_config(
        linear_progress_indicator.Config(
          ..linear_progress_indicator.default_config(),
          mode: linear_progress_mode.Indeterminate,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    linear_progress_indicator.mode(mod, field)
    |> should.equal(expected)
  })
}

pub fn linear_progress_indicator_value_test() {
  let mod = linear_progress_indicator.new()
  let cases = [
    #(
      42.0,
      linear_progress_indicator.from_config(
        linear_progress_indicator.Config(
          ..linear_progress_indicator.default_config(),
          value: 42.0,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    linear_progress_indicator.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn linear_progress_indicator_variant_test() {
  let mod = linear_progress_indicator.new()
  let cases = [
    #(
      progress_indicator_variant.Wavy,
      linear_progress_indicator.from_config(
        linear_progress_indicator.Config(
          ..linear_progress_indicator.default_config(),
          variant: progress_indicator_variant.Wavy,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    linear_progress_indicator.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn linear_progress_indicator_render_test() {
  let mod = linear_progress_indicator.new()

  let mod_buffer_value =
    linear_progress_indicator.new()
    |> linear_progress_indicator.buffer_value(42.0)
  let mod_max =
    linear_progress_indicator.new() |> linear_progress_indicator.max(42.0)
  let mod_mode =
    linear_progress_indicator.new()
    |> linear_progress_indicator.mode(linear_progress_mode.Indeterminate)
  let mod_value =
    linear_progress_indicator.new() |> linear_progress_indicator.value(42.0)
  let mod_variant =
    linear_progress_indicator.new()
    |> linear_progress_indicator.variant(progress_indicator_variant.Wavy)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-linear-progress-indicator", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-linear-progress-indicator", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-linear-progress-indicator", [], [html.br([])]),
    ),

    // Happy path with a buffer_value attribute
    #(
      #(mod_buffer_value, [], []),
      element.element(
        "m3e-linear-progress-indicator",
        [attribute.attribute("buffer-value", "42.0")],
        [],
      ),
    ),
    // Happy path with a max attribute
    #(
      #(mod_max, [], []),
      element.element(
        "m3e-linear-progress-indicator",
        [attribute.attribute("max", "42.0")],
        [],
      ),
    ),
    // Happy path with a mode attribute
    #(
      #(mod_mode, [], []),
      element.element(
        "m3e-linear-progress-indicator",
        [
          attribute.attribute(
            "mode",
            linear_progress_mode.to_string(linear_progress_mode.Indeterminate),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element(
        "m3e-linear-progress-indicator",
        [attribute.attribute("value", "42.0")],
        [],
      ),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-linear-progress-indicator",
        [
          attribute.attribute(
            "variant",
            progress_indicator_variant.to_string(
              progress_indicator_variant.Wavy,
            ),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    linear_progress_indicator.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

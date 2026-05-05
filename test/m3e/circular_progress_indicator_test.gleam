//// CircularProgressIndicator unit tests
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
import m3e/circular_progress_indicator.{Config}
import m3e/progress_indicator_variant

pub fn circular_progress_indicator_default_config_test() {
  let cases = [
    Config(
      indeterminate: circular_progress_indicator.IsNotIndeterminate,
      max: 100.0,
      value: 0.0,
      variant: progress_indicator_variant.Flat,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    circular_progress_indicator.default_config()
    |> should.equal(expected)
  })
}

pub fn circular_progress_indicator_from_config_test() {
  let cases = [
    #(
      circular_progress_indicator.Config(
        indeterminate: circular_progress_indicator.IsIndeterminate,
        max: 42.0,
        value: 42.0,
        variant: progress_indicator_variant.Wavy,
      ),
      circular_progress_indicator.new()
        |> circular_progress_indicator.indeterminate(
          circular_progress_indicator.IsIndeterminate,
        )
        |> circular_progress_indicator.max(42.0)
        |> circular_progress_indicator.value(42.0)
        |> circular_progress_indicator.variant(progress_indicator_variant.Wavy),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    circular_progress_indicator.from_config(config)
    |> should.equal(expected)
  })
}

pub fn circular_progress_indicator_new_test() {
  let cases = [
    circular_progress_indicator.from_config(circular_progress_indicator.Config(
      indeterminate: circular_progress_indicator.IsNotIndeterminate,
      max: 100.0,
      value: 0.0,
      variant: progress_indicator_variant.Flat,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    circular_progress_indicator.new()
    |> should.equal(expected)
  })
}

pub fn circular_progress_indicator_indeterminate_test() {
  let mod = circular_progress_indicator.new()
  let cases = [
    #(
      circular_progress_indicator.IsIndeterminate,
      circular_progress_indicator.from_config(
        circular_progress_indicator.Config(
          ..circular_progress_indicator.default_config(),
          indeterminate: circular_progress_indicator.IsIndeterminate,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    circular_progress_indicator.indeterminate(mod, field)
    |> should.equal(expected)
  })
}

pub fn circular_progress_indicator_max_test() {
  let mod = circular_progress_indicator.new()
  let cases = [
    #(
      42.0,
      circular_progress_indicator.from_config(
        circular_progress_indicator.Config(
          ..circular_progress_indicator.default_config(),
          max: 42.0,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    circular_progress_indicator.max(mod, field)
    |> should.equal(expected)
  })
}

pub fn circular_progress_indicator_value_test() {
  let mod = circular_progress_indicator.new()
  let cases = [
    #(
      42.0,
      circular_progress_indicator.from_config(
        circular_progress_indicator.Config(
          ..circular_progress_indicator.default_config(),
          value: 42.0,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    circular_progress_indicator.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn circular_progress_indicator_variant_test() {
  let mod = circular_progress_indicator.new()
  let cases = [
    #(
      progress_indicator_variant.Wavy,
      circular_progress_indicator.from_config(
        circular_progress_indicator.Config(
          ..circular_progress_indicator.default_config(),
          variant: progress_indicator_variant.Wavy,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    circular_progress_indicator.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn circular_progress_indicator_render_test() {
  let mod = circular_progress_indicator.new()

  let mod_indeterminate =
    circular_progress_indicator.new()
    |> circular_progress_indicator.indeterminate(
      circular_progress_indicator.IsIndeterminate,
    )
  let mod_max =
    circular_progress_indicator.new() |> circular_progress_indicator.max(42.0)
  let mod_value =
    circular_progress_indicator.new() |> circular_progress_indicator.value(42.0)
  let mod_variant =
    circular_progress_indicator.new()
    |> circular_progress_indicator.variant(progress_indicator_variant.Wavy)

  let cases = [
    // Happy path with no attributes nor children
    #(
      #(mod, [], []),
      element.element("m3e-circular-progress-indicator", [], []),
    ),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element(
        "m3e-circular-progress-indicator",
        [attribute.id("id")],
        [],
      ),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-circular-progress-indicator", [], [html.br([])]),
    ),

    // Happy path with a indeterminate attribute
    #(
      #(mod_indeterminate, [], []),
      element.element(
        "m3e-circular-progress-indicator",
        [attribute.attribute("indeterminate", "")],
        [],
      ),
    ),
    // Happy path with a max attribute
    #(
      #(mod_max, [], []),
      element.element(
        "m3e-circular-progress-indicator",
        [attribute.attribute("max", "42.0")],
        [],
      ),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element(
        "m3e-circular-progress-indicator",
        [attribute.attribute("value", "42.0")],
        [],
      ),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-circular-progress-indicator",
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

    circular_progress_indicator.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

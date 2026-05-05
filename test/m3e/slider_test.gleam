//// Slider unit tests
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
import m3e/slider.{Config}
import m3e/slider_size

pub fn slider_default_config_test() {
  let cases = [
    Config(
      disabled: slider.IsNotDisabled,
      discrete: slider.IsNotDiscrete,
      labelled: slider.IsNotLabelled,
      max: 100.0,
      min: 0.0,
      step: 1.0,
      size: slider_size.ExtraSmall,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    slider.default_config()
    |> should.equal(expected)
  })
}

pub fn slider_from_config_test() {
  let cases = [
    #(
      slider.Config(
        disabled: slider.IsDisabled,
        discrete: slider.IsDiscrete,
        labelled: slider.IsLabelled,
        max: 42.0,
        min: 42.0,
        step: 42.0,
        size: slider_size.Small,
      ),
      slider.new()
        |> slider.disabled(slider.IsDisabled)
        |> slider.discrete(slider.IsDiscrete)
        |> slider.labelled(slider.IsLabelled)
        |> slider.max(42.0)
        |> slider.min(42.0)
        |> slider.step(42.0)
        |> slider.size(slider_size.Small),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    slider.from_config(config)
    |> should.equal(expected)
  })
}

pub fn slider_new_test() {
  let cases = [
    slider.from_config(slider.Config(
      disabled: slider.IsNotDisabled,
      discrete: slider.IsNotDiscrete,
      labelled: slider.IsNotLabelled,
      max: 100.0,
      min: 0.0,
      step: 1.0,
      size: slider_size.ExtraSmall,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    slider.new()
    |> should.equal(expected)
  })
}

pub fn slider_disabled_test() {
  let mod = slider.new()
  let cases = [
    #(
      slider.IsDisabled,
      slider.from_config(
        slider.Config(..slider.default_config(), disabled: slider.IsDisabled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_discrete_test() {
  let mod = slider.new()
  let cases = [
    #(
      slider.IsDiscrete,
      slider.from_config(
        slider.Config(..slider.default_config(), discrete: slider.IsDiscrete),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider.discrete(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_labelled_test() {
  let mod = slider.new()
  let cases = [
    #(
      slider.IsLabelled,
      slider.from_config(
        slider.Config(..slider.default_config(), labelled: slider.IsLabelled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider.labelled(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_max_test() {
  let mod = slider.new()
  let cases = [
    #(
      42.0,
      slider.from_config(slider.Config(..slider.default_config(), max: 42.0)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider.max(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_min_test() {
  let mod = slider.new()
  let cases = [
    #(
      42.0,
      slider.from_config(slider.Config(..slider.default_config(), min: 42.0)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider.min(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_step_test() {
  let mod = slider.new()
  let cases = [
    #(
      42.0,
      slider.from_config(slider.Config(..slider.default_config(), step: 42.0)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider.step(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_size_test() {
  let mod = slider.new()
  let cases = [
    #(
      slider_size.Small,
      slider.from_config(
        slider.Config(..slider.default_config(), size: slider_size.Small),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider.size(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_render_test() {
  let mod = slider.new()

  let mod_disabled = slider.new() |> slider.disabled(slider.IsDisabled)
  let mod_discrete = slider.new() |> slider.discrete(slider.IsDiscrete)
  let mod_labelled = slider.new() |> slider.labelled(slider.IsLabelled)
  let mod_max = slider.new() |> slider.max(42.0)
  let mod_min = slider.new() |> slider.min(42.0)
  let mod_step = slider.new() |> slider.step(42.0)
  let mod_size = slider.new() |> slider.size(slider_size.Small)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-slider", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-slider", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-slider", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-slider", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a discrete attribute
    #(
      #(mod_discrete, [], []),
      element.element("m3e-slider", [attribute.attribute("discrete", "")], []),
    ),
    // Happy path with a labelled attribute
    #(
      #(mod_labelled, [], []),
      element.element("m3e-slider", [attribute.attribute("labelled", "")], []),
    ),
    // Happy path with a max attribute
    #(
      #(mod_max, [], []),
      element.element("m3e-slider", [attribute.attribute("max", "42.0")], []),
    ),
    // Happy path with a min attribute
    #(
      #(mod_min, [], []),
      element.element("m3e-slider", [attribute.attribute("min", "42.0")], []),
    ),
    // Happy path with a step attribute
    #(
      #(mod_step, [], []),
      element.element("m3e-slider", [attribute.attribute("step", "42.0")], []),
    ),
    // Happy path with a size attribute
    #(
      #(mod_size, [], []),
      element.element(
        "m3e-slider",
        [attribute.attribute("size", slider_size.to_string(slider_size.Small))],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    slider.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

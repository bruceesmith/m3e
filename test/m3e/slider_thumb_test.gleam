//// SliderThumb unit tests
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
import m3e/slider_thumb.{Config}

pub fn slider_thumb_default_config_test() {
  let cases = [
    Config(disabled: slider_thumb.IsNotDisabled, name: "", value: None),
  ]

  list.each(cases, fn(c) {
    let expected = c

    slider_thumb.default_config()
    |> should.equal(expected)
  })
}

pub fn slider_thumb_from_config_test() {
  let cases = [
    #(
      slider_thumb.Config(
        disabled: slider_thumb.IsDisabled,
        name: "test",
        value: Some(42.0),
      ),
      slider_thumb.new()
        |> slider_thumb.disabled(slider_thumb.IsDisabled)
        |> slider_thumb.name("test")
        |> slider_thumb.value(Some(42.0)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    slider_thumb.from_config(config)
    |> should.equal(expected)
  })
}

pub fn slider_thumb_new_test() {
  let cases = [
    slider_thumb.from_config(slider_thumb.Config(
      disabled: slider_thumb.IsNotDisabled,
      name: "",
      value: None,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    slider_thumb.new()
    |> should.equal(expected)
  })
}

pub fn slider_thumb_disabled_test() {
  let mod = slider_thumb.new()
  let cases = [
    #(
      slider_thumb.IsDisabled,
      slider_thumb.from_config(
        slider_thumb.Config(
          ..slider_thumb.default_config(),
          disabled: slider_thumb.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider_thumb.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_thumb_name_test() {
  let mod = slider_thumb.new()
  let cases = [
    #(
      "test",
      slider_thumb.from_config(
        slider_thumb.Config(..slider_thumb.default_config(), name: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider_thumb.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_thumb_value_test() {
  let mod = slider_thumb.new()
  let cases = [
    #(
      Some(42.0),
      slider_thumb.from_config(
        slider_thumb.Config(..slider_thumb.default_config(), value: Some(42.0)),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    slider_thumb.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn slider_thumb_render_test() {
  let mod = slider_thumb.new()

  let mod_disabled =
    slider_thumb.new() |> slider_thumb.disabled(slider_thumb.IsDisabled)
  let mod_name = slider_thumb.new() |> slider_thumb.name("test")
  let mod_value = slider_thumb.new() |> slider_thumb.value(Some(42.0))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-slider-thumb", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-slider-thumb", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-slider-thumb", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-slider-thumb",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element(
        "m3e-slider-thumb",
        [attribute.attribute("name", "test")],
        [],
      ),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element(
        "m3e-slider-thumb",
        [attribute.attribute("value", "42.0")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    slider_thumb.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

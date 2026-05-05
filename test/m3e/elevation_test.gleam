//// Elevation unit tests
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
import m3e/elevation.{Config}
import m3e/elevation_level

pub fn elevation_default_config_test() {
  let cases = [
    Config(disabled: elevation.IsNotDisabled, for: None, level: None),
  ]

  list.each(cases, fn(c) {
    let expected = c

    elevation.default_config()
    |> should.equal(expected)
  })
}

pub fn elevation_from_config_test() {
  let cases = [
    #(
      elevation.Config(
        disabled: elevation.IsDisabled,
        for: Some("test"),
        level: Some(elevation_level.Zero),
      ),
      elevation.new()
        |> elevation.disabled(elevation.IsDisabled)
        |> elevation.for(Some("test"))
        |> elevation.level(Some(elevation_level.Zero)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    elevation.from_config(config)
    |> should.equal(expected)
  })
}

pub fn elevation_new_test() {
  let cases = [
    elevation.from_config(elevation.Config(
      disabled: elevation.IsNotDisabled,
      for: None,
      level: None,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    elevation.new()
    |> should.equal(expected)
  })
}

pub fn elevation_disabled_test() {
  let mod = elevation.new()
  let cases = [
    #(
      elevation.IsDisabled,
      elevation.from_config(
        elevation.Config(
          ..elevation.default_config(),
          disabled: elevation.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    elevation.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn elevation_for_test() {
  let mod = elevation.new()
  let cases = [
    #(
      Some("test"),
      elevation.from_config(
        elevation.Config(..elevation.default_config(), for: Some("test")),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    elevation.for(mod, field)
    |> should.equal(expected)
  })
}

pub fn elevation_level_test() {
  let mod = elevation.new()
  let cases = [
    #(
      Some(elevation_level.Zero),
      elevation.from_config(
        elevation.Config(
          ..elevation.default_config(),
          level: Some(elevation_level.Zero),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    elevation.level(mod, field)
    |> should.equal(expected)
  })
}

pub fn elevation_render_test() {
  let mod = elevation.new()

  let mod_disabled = elevation.new() |> elevation.disabled(elevation.IsDisabled)
  let mod_for = elevation.new() |> elevation.for(Some("test"))
  let mod_level = elevation.new() |> elevation.level(Some(elevation_level.Zero))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-elevation", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-elevation", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-elevation", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-elevation",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a for attribute
    #(
      #(mod_for, [], []),
      element.element("m3e-elevation", [attribute.attribute("for", "test")], []),
    ),
    // Happy path with a level attribute
    #(
      #(mod_level, [], []),
      element.element(
        "m3e-elevation",
        [
          attribute.attribute(
            "level",
            elevation_level.to_string(elevation_level.Zero),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    elevation.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

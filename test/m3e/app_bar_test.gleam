//// AppBar unit tests
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
import m3e/app_bar.{Config}
import m3e/app_bar_size

pub fn app_bar_default_config_test() {
  let cases = [
    Config(centered: app_bar.IsNotCentered, for: None, size: app_bar_size.Small),
  ]

  list.each(cases, fn(c) {
    let expected = c

    app_bar.default_config()
    |> should.equal(expected)
  })
}

pub fn app_bar_from_config_test() {
  let cases = [
    #(
      app_bar.Config(
        centered: app_bar.IsCentered,
        for: Some("test"),
        size: app_bar_size.Medium,
      ),
      app_bar.new()
        |> app_bar.centered(app_bar.IsCentered)
        |> app_bar.for(Some("test"))
        |> app_bar.size(app_bar_size.Medium),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    app_bar.from_config(config)
    |> should.equal(expected)
  })
}

pub fn app_bar_new_test() {
  let cases = [
    app_bar.from_config(app_bar.Config(
      centered: app_bar.IsNotCentered,
      for: None,
      size: app_bar_size.Small,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    app_bar.new()
    |> should.equal(expected)
  })
}

pub fn app_bar_centered_test() {
  let mod = app_bar.new()
  let cases = [
    #(
      app_bar.IsCentered,
      app_bar.from_config(
        app_bar.Config(..app_bar.default_config(), centered: app_bar.IsCentered),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    app_bar.centered(mod, field)
    |> should.equal(expected)
  })
}

pub fn app_bar_for_test() {
  let mod = app_bar.new()
  let cases = [
    #(
      Some("test"),
      app_bar.from_config(
        app_bar.Config(..app_bar.default_config(), for: Some("test")),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    app_bar.for(mod, field)
    |> should.equal(expected)
  })
}

pub fn app_bar_size_test() {
  let mod = app_bar.new()
  let cases = [
    #(
      app_bar_size.Medium,
      app_bar.from_config(
        app_bar.Config(..app_bar.default_config(), size: app_bar_size.Medium),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    app_bar.size(mod, field)
    |> should.equal(expected)
  })
}

pub fn app_bar_render_test() {
  let mod = app_bar.new()

  let mod_centered = app_bar.new() |> app_bar.centered(app_bar.IsCentered)
  let mod_for = app_bar.new() |> app_bar.for(Some("test"))
  let mod_size = app_bar.new() |> app_bar.size(app_bar_size.Medium)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-app-bar", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-app-bar", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-app-bar", [], [html.br([])]),
    ),

    // Happy path with a centered attribute
    #(
      #(mod_centered, [], []),
      element.element("m3e-app-bar", [attribute.attribute("centered", "")], []),
    ),
    // Happy path with a for attribute
    #(
      #(mod_for, [], []),
      element.element("m3e-app-bar", [attribute.attribute("for", "test")], []),
    ),
    // Happy path with a size attribute
    #(
      #(mod_size, [], []),
      element.element(
        "m3e-app-bar",
        [
          attribute.attribute(
            "size",
            app_bar_size.to_string(app_bar_size.Medium),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    app_bar.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn app_bar_slot_test() {
  let cases = [
    #(app_bar.Leading, attribute.attribute("slot", "leading")),
    #(app_bar.Subtitle, attribute.attribute("slot", "subtitle")),
    #(app_bar.Title, attribute.attribute("slot", "title")),
    #(app_bar.Trailing, attribute.attribute("slot", "trailing")),
    #(app_bar.LeadingIcon, attribute.attribute("slot", "leading-icon")),
    #(app_bar.TrailingIcon, attribute.attribute("slot", "trailing-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    app_bar.slot(s)
    |> should.equal(expected)
  })
}

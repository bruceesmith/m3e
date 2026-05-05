//// ButtonGroup unit tests
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
import m3e/button_group.{Config}
import m3e/button_group_size
import m3e/button_group_variant

pub fn button_group_default_config_test() {
  let cases = [
    Config(
      multi: button_group.IsNotMulti,
      size: button_group_size.Small,
      variant: button_group_variant.Standard,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    button_group.default_config()
    |> should.equal(expected)
  })
}

pub fn button_group_from_config_test() {
  let cases = [
    #(
      button_group.Config(
        multi: button_group.IsMulti,
        size: button_group_size.ExtraSmall,
        variant: button_group_variant.Connected,
      ),
      button_group.new()
        |> button_group.multi(button_group.IsMulti)
        |> button_group.size(button_group_size.ExtraSmall)
        |> button_group.variant(button_group_variant.Connected),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    button_group.from_config(config)
    |> should.equal(expected)
  })
}

pub fn button_group_new_test() {
  let cases = [
    button_group.from_config(button_group.Config(
      multi: button_group.IsNotMulti,
      size: button_group_size.Small,
      variant: button_group_variant.Standard,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    button_group.new()
    |> should.equal(expected)
  })
}

pub fn button_group_multi_test() {
  let mod = button_group.new()
  let cases = [
    #(
      button_group.IsMulti,
      button_group.from_config(
        button_group.Config(
          ..button_group.default_config(),
          multi: button_group.IsMulti,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button_group.multi(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_group_size_test() {
  let mod = button_group.new()
  let cases = [
    #(
      button_group_size.ExtraSmall,
      button_group.from_config(
        button_group.Config(
          ..button_group.default_config(),
          size: button_group_size.ExtraSmall,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button_group.size(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_group_variant_test() {
  let mod = button_group.new()
  let cases = [
    #(
      button_group_variant.Connected,
      button_group.from_config(
        button_group.Config(
          ..button_group.default_config(),
          variant: button_group_variant.Connected,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button_group.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_group_render_test() {
  let mod = button_group.new()

  let mod_multi = button_group.new() |> button_group.multi(button_group.IsMulti)
  let mod_size =
    button_group.new() |> button_group.size(button_group_size.ExtraSmall)
  let mod_variant =
    button_group.new() |> button_group.variant(button_group_variant.Connected)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-button-group", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-button-group", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-button-group", [], [html.br([])]),
    ),

    // Happy path with a multi attribute
    #(
      #(mod_multi, [], []),
      element.element(
        "m3e-button-group",
        [attribute.attribute("multi", "")],
        [],
      ),
    ),
    // Happy path with a size attribute
    #(
      #(mod_size, [], []),
      element.element(
        "m3e-button-group",
        [
          attribute.attribute(
            "size",
            button_group_size.to_string(button_group_size.ExtraSmall),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-button-group",
        [
          attribute.attribute(
            "variant",
            button_group_variant.to_string(button_group_variant.Connected),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    button_group.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

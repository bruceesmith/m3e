//// SplitButton unit tests
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
import m3e/button_size
import m3e/split_button.{Config}
import m3e/split_button_variant

pub fn split_button_default_config_test() {
  let cases = [
    Config(variant: split_button_variant.Filled, size: button_size.Small),
  ]

  list.each(cases, fn(c) {
    let expected = c

    split_button.default_config()
    |> should.equal(expected)
  })
}

pub fn split_button_from_config_test() {
  let cases = [
    #(
      split_button.Config(
        variant: split_button_variant.Elevated,
        size: button_size.ExtraSmall,
      ),
      split_button.new()
        |> split_button.variant(split_button_variant.Elevated)
        |> split_button.size(button_size.ExtraSmall),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    split_button.from_config(config)
    |> should.equal(expected)
  })
}

pub fn split_button_new_test() {
  let cases = [
    split_button.from_config(split_button.Config(
      variant: split_button_variant.Filled,
      size: button_size.Small,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    split_button.new()
    |> should.equal(expected)
  })
}

pub fn split_button_variant_test() {
  let mod = split_button.new()
  let cases = [
    #(
      split_button_variant.Elevated,
      split_button.from_config(
        split_button.Config(
          ..split_button.default_config(),
          variant: split_button_variant.Elevated,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_button.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_button_size_test() {
  let mod = split_button.new()
  let cases = [
    #(
      button_size.ExtraSmall,
      split_button.from_config(
        split_button.Config(
          ..split_button.default_config(),
          size: button_size.ExtraSmall,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    split_button.size(mod, field)
    |> should.equal(expected)
  })
}

pub fn split_button_render_test() {
  let mod = split_button.new()

  let mod_variant =
    split_button.new() |> split_button.variant(split_button_variant.Elevated)
  let mod_size = split_button.new() |> split_button.size(button_size.ExtraSmall)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-split-button", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-split-button", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-split-button", [], [html.br([])]),
    ),

    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-split-button",
        [
          attribute.attribute(
            "variant",
            split_button_variant.to_string(split_button_variant.Elevated),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a size attribute
    #(
      #(mod_size, [], []),
      element.element(
        "m3e-split-button",
        [
          attribute.attribute(
            "size",
            button_size.to_string(button_size.ExtraSmall),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    split_button.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn split_button_slot_test() {
  let cases = [
    #(split_button.LeadingButton, attribute.attribute("slot", "leading-button")),
    #(
      split_button.TrailingButton,
      attribute.attribute("slot", "trailing-button"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    split_button.slot(s)
    |> should.equal(expected)
  })
}

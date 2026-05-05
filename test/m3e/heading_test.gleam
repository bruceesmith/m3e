//// Heading unit tests
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
import m3e/heading.{Config}
import m3e/heading_level
import m3e/heading_size
import m3e/heading_variant

pub fn heading_default_config_test() {
  let cases = [
    Config(
      emphasized: heading.IsNotEmphasized,
      level: None,
      size: heading_size.Medium,
      variant: heading_variant.Display,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    heading.default_config()
    |> should.equal(expected)
  })
}

pub fn heading_from_config_test() {
  let cases = [
    #(
      heading.Config(
        emphasized: heading.IsEmphasized,
        level: Some(heading_level.One),
        size: heading_size.Small,
        variant: heading_variant.Headline,
      ),
      heading.new()
        |> heading.emphasized(heading.IsEmphasized)
        |> heading.level(Some(heading_level.One))
        |> heading.size(heading_size.Small)
        |> heading.variant(heading_variant.Headline),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    heading.from_config(config)
    |> should.equal(expected)
  })
}

pub fn heading_new_test() {
  let cases = [
    heading.from_config(heading.Config(
      emphasized: heading.IsNotEmphasized,
      level: None,
      size: heading_size.Medium,
      variant: heading_variant.Display,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    heading.new()
    |> should.equal(expected)
  })
}

pub fn heading_emphasized_test() {
  let mod = heading.new()
  let cases = [
    #(
      heading.IsEmphasized,
      heading.from_config(
        heading.Config(
          ..heading.default_config(),
          emphasized: heading.IsEmphasized,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    heading.emphasized(mod, field)
    |> should.equal(expected)
  })
}

pub fn heading_level_test() {
  let mod = heading.new()
  let cases = [
    #(
      Some(heading_level.One),
      heading.from_config(
        heading.Config(
          ..heading.default_config(),
          level: Some(heading_level.One),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    heading.level(mod, field)
    |> should.equal(expected)
  })
}

pub fn heading_size_test() {
  let mod = heading.new()
  let cases = [
    #(
      heading_size.Small,
      heading.from_config(
        heading.Config(..heading.default_config(), size: heading_size.Small),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    heading.size(mod, field)
    |> should.equal(expected)
  })
}

pub fn heading_variant_test() {
  let mod = heading.new()
  let cases = [
    #(
      heading_variant.Headline,
      heading.from_config(
        heading.Config(
          ..heading.default_config(),
          variant: heading_variant.Headline,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    heading.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn heading_render_test() {
  let mod = heading.new()

  let mod_emphasized = heading.new() |> heading.emphasized(heading.IsEmphasized)
  let mod_level = heading.new() |> heading.level(Some(heading_level.One))
  let mod_size = heading.new() |> heading.size(heading_size.Small)
  let mod_variant = heading.new() |> heading.variant(heading_variant.Headline)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-heading", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-heading", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-heading", [], [html.br([])]),
    ),

    // Happy path with a emphasized attribute
    #(
      #(mod_emphasized, [], []),
      element.element(
        "m3e-heading",
        [attribute.attribute("emphasized", "")],
        [],
      ),
    ),
    // Happy path with a level attribute
    #(
      #(mod_level, [], []),
      element.element(
        "m3e-heading",
        [
          attribute.attribute(
            "level",
            heading_level.to_string(heading_level.One),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a size attribute
    #(
      #(mod_size, [], []),
      element.element(
        "m3e-heading",
        [
          attribute.attribute(
            "size",
            heading_size.to_string(heading_size.Small),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-heading",
        [
          attribute.attribute(
            "variant",
            heading_variant.to_string(heading_variant.Headline),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    heading.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

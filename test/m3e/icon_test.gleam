//// Icon unit tests
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
import m3e/icon.{Config}
import m3e/icon_grade
import m3e/icon_variant
import m3e/icon_weight

pub fn icon_default_config_test() {
  let cases = [
    Config(
      filled: icon.IsNotFilled,
      grade: icon_grade.Medium,
      optical_size: 24.0,
      name: "",
      variant: icon_variant.Outlined,
      weight: icon_weight.FourZeroZero,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    icon.default_config()
    |> should.equal(expected)
  })
}

pub fn icon_from_config_test() {
  let cases = [
    #(
      icon.Config(
        filled: icon.IsFilled,
        grade: icon_grade.Low,
        optical_size: 42.0,
        name: "test",
        variant: icon_variant.Rounded,
        weight: icon_weight.OneZeroZero,
      ),
      icon.new()
        |> icon.filled(icon.IsFilled)
        |> icon.grade(icon_grade.Low)
        |> icon.optical_size(42.0)
        |> icon.name("test")
        |> icon.variant(icon_variant.Rounded)
        |> icon.weight(icon_weight.OneZeroZero),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    icon.from_config(config)
    |> should.equal(expected)
  })
}

pub fn icon_new_test() {
  let cases = [
    icon.from_config(icon.Config(
      filled: icon.IsNotFilled,
      grade: icon_grade.Medium,
      optical_size: 24.0,
      name: "",
      variant: icon_variant.Outlined,
      weight: icon_weight.FourZeroZero,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    icon.new()
    |> should.equal(expected)
  })
}

pub fn icon_filled_test() {
  let mod = icon.new()
  let cases = [
    #(
      icon.IsFilled,
      icon.from_config(
        icon.Config(..icon.default_config(), filled: icon.IsFilled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    icon.filled(mod, field)
    |> should.equal(expected)
  })
}

pub fn icon_grade_test() {
  let mod = icon.new()
  let cases = [
    #(
      icon_grade.Low,
      icon.from_config(
        icon.Config(..icon.default_config(), grade: icon_grade.Low),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    icon.grade(mod, field)
    |> should.equal(expected)
  })
}

pub fn icon_optical_size_test() {
  let mod = icon.new()
  let cases = [
    #(
      42.0,
      icon.from_config(icon.Config(..icon.default_config(), optical_size: 42.0)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    icon.optical_size(mod, field)
    |> should.equal(expected)
  })
}

pub fn icon_name_test() {
  let mod = icon.new()
  let cases = [
    #(
      "test",
      icon.from_config(icon.Config(..icon.default_config(), name: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    icon.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn icon_variant_test() {
  let mod = icon.new()
  let cases = [
    #(
      icon_variant.Rounded,
      icon.from_config(
        icon.Config(..icon.default_config(), variant: icon_variant.Rounded),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    icon.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn icon_weight_test() {
  let mod = icon.new()
  let cases = [
    #(
      icon_weight.OneZeroZero,
      icon.from_config(
        icon.Config(..icon.default_config(), weight: icon_weight.OneZeroZero),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    icon.weight(mod, field)
    |> should.equal(expected)
  })
}

pub fn icon_render_test() {
  let mod = icon.new()

  let mod_filled = icon.new() |> icon.filled(icon.IsFilled)
  let mod_grade = icon.new() |> icon.grade(icon_grade.Low)
  let mod_optical_size = icon.new() |> icon.optical_size(42.0)
  let mod_name = icon.new() |> icon.name("test")
  let mod_variant = icon.new() |> icon.variant(icon_variant.Rounded)
  let mod_weight = icon.new() |> icon.weight(icon_weight.OneZeroZero)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-icon", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-icon", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(#(mod, [], [html.br([])]), element.element("m3e-icon", [], [html.br([])])),

    // Happy path with a filled attribute
    #(
      #(mod_filled, [], []),
      element.element("m3e-icon", [attribute.attribute("filled", "")], []),
    ),
    // Happy path with a grade attribute
    #(
      #(mod_grade, [], []),
      element.element(
        "m3e-icon",
        [attribute.attribute("grade", icon_grade.to_string(icon_grade.Low))],
        [],
      ),
    ),
    // Happy path with a optical_size attribute
    #(
      #(mod_optical_size, [], []),
      element.element(
        "m3e-icon",
        [attribute.attribute("optical-size", "42.0")],
        [],
      ),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element("m3e-icon", [attribute.attribute("name", "test")], []),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-icon",
        [
          attribute.attribute(
            "variant",
            icon_variant.to_string(icon_variant.Rounded),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a weight attribute
    #(
      #(mod_weight, [], []),
      element.element(
        "m3e-icon",
        [
          attribute.attribute(
            "weight",
            icon_weight.to_string(icon_weight.OneZeroZero),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    icon.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

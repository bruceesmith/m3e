//// Theme unit tests
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
import m3e/color_scheme
import m3e/contrast_level
import m3e/motion_scheme
import m3e/theme.{Config}

pub fn theme_default_config_test() {
  let cases = [
    Config(
      color: "#6750A4",
      contrast: contrast_level.Standard,
      density: 0.0,
      scheme: color_scheme.Auto,
      strong_focus: theme.IsNotStrongFocus,
      motion: motion_scheme.Standard,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    theme.default_config()
    |> should.equal(expected)
  })
}

pub fn theme_from_config_test() {
  let cases = [
    #(
      theme.Config(
        color: "test",
        contrast: contrast_level.High,
        density: 42.0,
        scheme: color_scheme.Light,
        strong_focus: theme.IsStrongFocus,
        motion: motion_scheme.Expressive,
      ),
      theme.new()
        |> theme.color("test")
        |> theme.contrast(contrast_level.High)
        |> theme.density(42.0)
        |> theme.scheme(color_scheme.Light)
        |> theme.strong_focus(theme.IsStrongFocus)
        |> theme.motion(motion_scheme.Expressive),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    theme.from_config(config)
    |> should.equal(expected)
  })
}

pub fn theme_new_test() {
  let cases = [
    theme.from_config(theme.Config(
      color: "#6750A4",
      contrast: contrast_level.Standard,
      density: 0.0,
      scheme: color_scheme.Auto,
      strong_focus: theme.IsNotStrongFocus,
      motion: motion_scheme.Standard,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    theme.new()
    |> should.equal(expected)
  })
}

pub fn theme_color_test() {
  let mod = theme.new()
  let cases = [
    #(
      "test",
      theme.from_config(theme.Config(..theme.default_config(), color: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    theme.color(mod, field)
    |> should.equal(expected)
  })
}

pub fn theme_contrast_test() {
  let mod = theme.new()
  let cases = [
    #(
      contrast_level.High,
      theme.from_config(
        theme.Config(..theme.default_config(), contrast: contrast_level.High),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    theme.contrast(mod, field)
    |> should.equal(expected)
  })
}

pub fn theme_density_test() {
  let mod = theme.new()
  let cases = [
    #(
      42.0,
      theme.from_config(theme.Config(..theme.default_config(), density: 42.0)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    theme.density(mod, field)
    |> should.equal(expected)
  })
}

pub fn theme_scheme_test() {
  let mod = theme.new()
  let cases = [
    #(
      color_scheme.Light,
      theme.from_config(
        theme.Config(..theme.default_config(), scheme: color_scheme.Light),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    theme.scheme(mod, field)
    |> should.equal(expected)
  })
}

pub fn theme_strong_focus_test() {
  let mod = theme.new()
  let cases = [
    #(
      theme.IsStrongFocus,
      theme.from_config(
        theme.Config(
          ..theme.default_config(),
          strong_focus: theme.IsStrongFocus,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    theme.strong_focus(mod, field)
    |> should.equal(expected)
  })
}

pub fn theme_motion_test() {
  let mod = theme.new()
  let cases = [
    #(
      motion_scheme.Expressive,
      theme.from_config(
        theme.Config(..theme.default_config(), motion: motion_scheme.Expressive),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    theme.motion(mod, field)
    |> should.equal(expected)
  })
}

pub fn theme_render_test() {
  let mod = theme.new()

  let mod_color = theme.new() |> theme.color("test")
  let mod_contrast = theme.new() |> theme.contrast(contrast_level.High)
  let mod_density = theme.new() |> theme.density(42.0)
  let mod_scheme = theme.new() |> theme.scheme(color_scheme.Light)
  let mod_strong_focus = theme.new() |> theme.strong_focus(theme.IsStrongFocus)
  let mod_motion = theme.new() |> theme.motion(motion_scheme.Expressive)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-theme", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-theme", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-theme", [], [html.br([])]),
    ),

    // Happy path with a color attribute
    #(
      #(mod_color, [], []),
      element.element("m3e-theme", [attribute.attribute("color", "test")], []),
    ),
    // Happy path with a contrast attribute
    #(
      #(mod_contrast, [], []),
      element.element(
        "m3e-theme",
        [
          attribute.attribute(
            "contrast",
            contrast_level.to_string(contrast_level.High),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a density attribute
    #(
      #(mod_density, [], []),
      element.element("m3e-theme", [attribute.attribute("density", "42.0")], []),
    ),
    // Happy path with a scheme attribute
    #(
      #(mod_scheme, [], []),
      element.element(
        "m3e-theme",
        [
          attribute.attribute(
            "scheme",
            color_scheme.to_string(color_scheme.Light),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a strong_focus attribute
    #(
      #(mod_strong_focus, [], []),
      element.element(
        "m3e-theme",
        [attribute.attribute("strong-focus", "")],
        [],
      ),
    ),
    // Happy path with a motion attribute
    #(
      #(mod_motion, [], []),
      element.element(
        "m3e-theme",
        [
          attribute.attribute(
            "motion",
            motion_scheme.to_string(motion_scheme.Expressive),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    theme.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

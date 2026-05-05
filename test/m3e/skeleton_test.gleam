//// Skeleton unit tests
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
import m3e/skeleton.{Config}
import m3e/skeleton_animation
import m3e/skeleton_shape

pub fn skeleton_default_config_test() {
  let cases = [
    Config(
      animation: skeleton_animation.Wave,
      shape: skeleton_shape.Auto,
      loaded: skeleton.IsNotLoaded,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    skeleton.default_config()
    |> should.equal(expected)
  })
}

pub fn skeleton_from_config_test() {
  let cases = [
    #(
      skeleton.Config(
        animation: skeleton_animation.Pulse,
        shape: skeleton_shape.Circular,
        loaded: skeleton.IsLoaded,
      ),
      skeleton.new()
        |> skeleton.animation(skeleton_animation.Pulse)
        |> skeleton.shape(skeleton_shape.Circular)
        |> skeleton.loaded(skeleton.IsLoaded),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    skeleton.from_config(config)
    |> should.equal(expected)
  })
}

pub fn skeleton_new_test() {
  let cases = [
    skeleton.from_config(skeleton.Config(
      animation: skeleton_animation.Wave,
      shape: skeleton_shape.Auto,
      loaded: skeleton.IsNotLoaded,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    skeleton.new()
    |> should.equal(expected)
  })
}

pub fn skeleton_animation_test() {
  let mod = skeleton.new()
  let cases = [
    #(
      skeleton_animation.Pulse,
      skeleton.from_config(
        skeleton.Config(
          ..skeleton.default_config(),
          animation: skeleton_animation.Pulse,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    skeleton.animation(mod, field)
    |> should.equal(expected)
  })
}

pub fn skeleton_shape_test() {
  let mod = skeleton.new()
  let cases = [
    #(
      skeleton_shape.Circular,
      skeleton.from_config(
        skeleton.Config(
          ..skeleton.default_config(),
          shape: skeleton_shape.Circular,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    skeleton.shape(mod, field)
    |> should.equal(expected)
  })
}

pub fn skeleton_loaded_test() {
  let mod = skeleton.new()
  let cases = [
    #(
      skeleton.IsLoaded,
      skeleton.from_config(
        skeleton.Config(..skeleton.default_config(), loaded: skeleton.IsLoaded),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    skeleton.loaded(mod, field)
    |> should.equal(expected)
  })
}

pub fn skeleton_render_test() {
  let mod = skeleton.new()

  let mod_animation =
    skeleton.new() |> skeleton.animation(skeleton_animation.Pulse)
  let mod_shape = skeleton.new() |> skeleton.shape(skeleton_shape.Circular)
  let mod_loaded = skeleton.new() |> skeleton.loaded(skeleton.IsLoaded)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-skeleton", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-skeleton", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-skeleton", [], [html.br([])]),
    ),

    // Happy path with a animation attribute
    #(
      #(mod_animation, [], []),
      element.element(
        "m3e-skeleton",
        [
          attribute.attribute(
            "animation",
            skeleton_animation.to_string(skeleton_animation.Pulse),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a shape attribute
    #(
      #(mod_shape, [], []),
      element.element(
        "m3e-skeleton",
        [
          attribute.attribute(
            "shape",
            skeleton_shape.to_string(skeleton_shape.Circular),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a loaded attribute
    #(
      #(mod_loaded, [], []),
      element.element("m3e-skeleton", [attribute.attribute("loaded", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    skeleton.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

//// Tree unit tests
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
import m3e/tree.{Config}

pub fn tree_default_config_test() {
  let cases = [
    Config(multi: tree.IsNotMulti, cascade: tree.IsNotCascade),
  ]

  list.each(cases, fn(c) {
    let expected = c

    tree.default_config()
    |> should.equal(expected)
  })
}

pub fn tree_from_config_test() {
  let cases = [
    #(
      tree.Config(multi: tree.IsMulti, cascade: tree.IsCascade),
      tree.new()
        |> tree.multi(tree.IsMulti)
        |> tree.cascade(tree.IsCascade),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    tree.from_config(config)
    |> should.equal(expected)
  })
}

pub fn tree_new_test() {
  let cases = [
    tree.from_config(tree.Config(
      multi: tree.IsNotMulti,
      cascade: tree.IsNotCascade,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    tree.new()
    |> should.equal(expected)
  })
}

pub fn tree_multi_test() {
  let mod = tree.new()
  let cases = [
    #(
      tree.IsMulti,
      tree.from_config(
        tree.Config(..tree.default_config(), multi: tree.IsMulti),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tree.multi(mod, field)
    |> should.equal(expected)
  })
}

pub fn tree_cascade_test() {
  let mod = tree.new()
  let cases = [
    #(
      tree.IsCascade,
      tree.from_config(
        tree.Config(..tree.default_config(), cascade: tree.IsCascade),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tree.cascade(mod, field)
    |> should.equal(expected)
  })
}

pub fn tree_render_test() {
  let mod = tree.new()

  let mod_multi = tree.new() |> tree.multi(tree.IsMulti)
  let mod_cascade = tree.new() |> tree.cascade(tree.IsCascade)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-tree", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-tree", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(#(mod, [], [html.br([])]), element.element("m3e-tree", [], [html.br([])])),

    // Happy path with a multi attribute
    #(
      #(mod_multi, [], []),
      element.element("m3e-tree", [attribute.attribute("multi", "")], []),
    ),
    // Happy path with a cascade attribute
    #(
      #(mod_cascade, [], []),
      element.element("m3e-tree", [attribute.attribute("cascade", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    tree.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

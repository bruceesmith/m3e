//// Breadcrumb unit tests
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
import m3e/breadcrumb

pub fn breadcrumb_render_test() {
  let mod = breadcrumb.new(breadcrumb.IsNotWrap)
  let mod_wrap = breadcrumb.new(breadcrumb.IsWrap)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-breadcrumb", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-breadcrumb", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-breadcrumb", [], [html.br([])]),
    ),

    // Happy path with a wrap attribute
    #(
      #(mod_wrap, [], []),
      element.element("m3e-breadcrumb", [attribute.attribute("wrap", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    breadcrumb.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn breadcrumb_slot_test() {
  let cases = [
    #(breadcrumb.Separator, attribute.attribute("slot", "separator")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    breadcrumb.slot(s)
    |> should.equal(expected)
  })
}

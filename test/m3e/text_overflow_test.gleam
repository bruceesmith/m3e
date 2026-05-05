//// TextOverflow unit tests
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
import m3e/text_overflow

pub fn text_overflow_render_test() {
  let mod = text_overflow.new()

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-text-overflow", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-text-overflow", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-text-overflow", [], [html.br([])]),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    text_overflow.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

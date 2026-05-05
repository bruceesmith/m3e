//// Collapsible unit tests
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
import m3e/collapsible

pub fn collapsible_render_test() {
  let mod = collapsible.new(collapsible.IsNotOpen)
  let mod_open = collapsible.new(collapsible.IsOpen)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-collapsible", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-collapsible", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-collapsible", [], [html.br([])]),
    ),

    // Happy path with a open attribute
    #(
      #(mod_open, [], []),
      element.element("m3e-collapsible", [attribute.attribute("open", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    collapsible.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

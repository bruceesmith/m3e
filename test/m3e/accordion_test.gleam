//// Accordion unit tests
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
import m3e/accordion

pub fn accordion_render_test() {
  let mod = accordion.new(accordion.IsNotMulti)
  let mod_multi = accordion.new(accordion.IsMulti)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-accordion", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-accordion", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-accordion", [], [html.br([])]),
    ),

    // Happy path with a multi attribute
    #(
      #(mod_multi, [], []),
      element.element("m3e-accordion", [attribute.attribute("multi", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    accordion.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

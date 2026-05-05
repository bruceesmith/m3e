//// Slide unit tests
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
import m3e/slide

pub fn slide_render_test() {
  let mod = slide.new(None)
  let mod_selected_index = slide.new(Some(42.0))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-slide", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-slide", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-slide", [], [html.br([])]),
    ),

    // Happy path with a selected_index attribute
    #(
      #(mod_selected_index, [], []),
      element.element(
        "m3e-slide",
        [attribute.attribute("selected-index", "42.0")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    slide.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

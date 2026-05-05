//// Shape unit tests
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
import m3e/shape
import m3e/shape_name

pub fn shape_render_test() {
  let mod = shape.new(None)
  let mod_name = shape.new(Some(shape_name.FourLeafClover))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-shape", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-shape", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-shape", [], [html.br([])]),
    ),

    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element(
        "m3e-shape",
        [
          attribute.attribute(
            "name",
            shape_name.to_string(shape_name.FourLeafClover),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    shape.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

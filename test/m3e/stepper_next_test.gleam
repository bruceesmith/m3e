//// StepperNext unit tests
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
import m3e/stepper_next

pub fn stepper_next_render_test() {
  let mod = stepper_next.new()

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-stepper-previous", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-stepper-previous", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-stepper-previous", [], [html.br([])]),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    stepper_next.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

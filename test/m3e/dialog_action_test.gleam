//// DialogAction unit tests
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
import m3e/dialog_action

pub fn dialog_action_render_test() {
  let mod = dialog_action.new("")
  let mod_return_value = dialog_action.new("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-dialog-action", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-dialog-action", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-dialog-action", [], [html.br([])]),
    ),

    // Happy path with a return_value attribute
    #(
      #(mod_return_value, [], []),
      element.element(
        "m3e-dialog-action",
        [attribute.attribute("return-value", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    dialog_action.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

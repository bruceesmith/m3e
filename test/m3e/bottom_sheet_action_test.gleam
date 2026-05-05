//// BottomSheetAction unit tests
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
import m3e/bottom_sheet_action

pub fn bottom_sheet_action_render_test() {
  let mod = bottom_sheet_action.new()

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-bottom-sheet-action", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-bottom-sheet-action", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-bottom-sheet-action", [], [html.br([])]),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    bottom_sheet_action.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

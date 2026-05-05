//// OptGroup unit tests
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
import m3e/opt_group

pub fn opt_group_render_test() {
  let mod = opt_group.new()

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-optgroup", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-optgroup", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-optgroup", [], [html.br([])]),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    opt_group.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn opt_group_slot_test() {
  let cases = [
    #(opt_group.Label, attribute.attribute("slot", "label")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    opt_group.slot(s)
    |> should.equal(expected)
  })
}

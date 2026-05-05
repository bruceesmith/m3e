//// ChipSet unit tests
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
import m3e/chip_set

pub fn chip_set_render_test() {
  let mod = chip_set.new(chip_set.IsNotVertical)
  let mod_vertical = chip_set.new(chip_set.IsVertical)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-chip-set", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-chip-set", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-chip-set", [], [html.br([])]),
    ),

    // Happy path with a vertical attribute
    #(
      #(mod_vertical, [], []),
      element.element("m3e-chip-set", [attribute.attribute("vertical", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    chip_set.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

//// ListItem unit tests
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
import m3e/list_item

pub fn list_item_render_test() {
  let mod = list_item.new()

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-list-item", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-list-item", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-list-item", [], [html.br([])]),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    list_item.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn list_item_slot_test() {
  let cases = [
    #(list_item.Leading, attribute.attribute("slot", "leading")),
    #(list_item.Overline, attribute.attribute("slot", "overline")),
    #(list_item.SupportingText, attribute.attribute("slot", "supporting-text")),
    #(list_item.Trailing, attribute.attribute("slot", "trailing")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    list_item.slot(s)
    |> should.equal(expected)
  })
}

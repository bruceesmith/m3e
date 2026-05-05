//// DialogTrigger unit tests
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
import m3e/dialog_trigger

pub fn dialog_trigger_render_test() {
  let mod = dialog_trigger.new(None)
  let mod_for = dialog_trigger.new(Some("test"))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-dialog-trigger", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-dialog-trigger", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-dialog-trigger", [], [html.br([])]),
    ),

    // Happy path with a for attribute
    #(
      #(mod_for, [], []),
      element.element(
        "m3e-dialog-trigger",
        [attribute.attribute("for", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    dialog_trigger.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

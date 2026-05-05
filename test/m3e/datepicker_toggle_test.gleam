//// DatepickerToggle unit tests
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
import m3e/datepicker_toggle

pub fn datepicker_toggle_render_test() {
  let mod = datepicker_toggle.new(None)
  let mod_for = datepicker_toggle.new(Some("test"))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-datepicker-toggle", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-datepicker-toggle", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-datepicker-toggle", [], [html.br([])]),
    ),

    // Happy path with a for attribute
    #(
      #(mod_for, [], []),
      element.element(
        "m3e-datepicker-toggle",
        [attribute.attribute("for", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    datepicker_toggle.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

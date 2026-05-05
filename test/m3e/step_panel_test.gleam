//// StepPanel unit tests
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
import m3e/step_panel

pub fn step_panel_render_test() {
  let mod = step_panel.new()

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-step-panel", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-step-panel", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-step-panel", [], [html.br([])]),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    step_panel.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn step_panel_slot_test() {
  let cases = [
    #(step_panel.Actions, attribute.attribute("slot", "actions-")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    step_panel.slot(s)
    |> should.equal(expected)
  })
}

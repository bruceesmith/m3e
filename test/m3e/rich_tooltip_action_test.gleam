//// RichTooltipAction unit tests
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
import m3e/rich_tooltip_action

pub fn rich_tooltip_action_render_test() {
  let mod =
    rich_tooltip_action.new(rich_tooltip_action.IsNotDisableRestoreFocus)
  let mod_disable_restore_focus =
    rich_tooltip_action.new(rich_tooltip_action.IsDisableRestoreFocus)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-rich-tooltip-action", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-rich-tooltip-action", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-rich-tooltip-action", [], [html.br([])]),
    ),

    // Happy path with a disable_restore_focus attribute
    #(
      #(mod_disable_restore_focus, [], []),
      element.element(
        "m3e-rich-tooltip-action",
        [attribute.attribute("disable-restore-focus", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    rich_tooltip_action.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

//// NavBar unit tests
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
import m3e/nav_bar
import m3e/nav_bar_mode

pub fn nav_bar_render_test() {
  let mod = nav_bar.new(nav_bar_mode.Compact)
  let mod_mode = nav_bar.new(nav_bar_mode.Expanded)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-nav-bar", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-nav-bar", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-nav-bar", [], [html.br([])]),
    ),

    // Happy path with a mode attribute
    #(
      #(mod_mode, [], []),
      element.element(
        "m3e-nav-bar",
        [
          attribute.attribute(
            "mode",
            nav_bar_mode.to_string(nav_bar_mode.Expanded),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    nav_bar.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

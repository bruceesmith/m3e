//// FabMenu unit tests
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
import m3e/fab_menu
import m3e/fab_menu_variant

pub fn fab_menu_render_test() {
  let mod = fab_menu.new(fab_menu_variant.Primary)
  let mod_variant = fab_menu.new(fab_menu_variant.Secondary)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-fab-menu", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-fab-menu", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-fab-menu", [], [html.br([])]),
    ),

    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-fab-menu",
        [
          attribute.attribute(
            "variant",
            fab_menu_variant.to_string(fab_menu_variant.Secondary),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    fab_menu.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

//// Mlist unit tests
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
import m3e/list_variant
import m3e/mlist

pub fn mlist_render_test() {
  let mod = mlist.new(list_variant.Standard)
  let mod_variant = mlist.new(list_variant.Segmented)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-list", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-list", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(#(mod, [], [html.br([])]), element.element("m3e-list", [], [html.br([])])),

    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-list",
        [
          attribute.attribute(
            "variant",
            list_variant.to_string(list_variant.Segmented),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    mlist.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

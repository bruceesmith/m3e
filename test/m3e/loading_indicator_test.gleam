//// LoadingIndicator unit tests
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
import m3e/loading_indicator
import m3e/loading_indicator_variant

pub fn loading_indicator_render_test() {
  let mod = loading_indicator.new(loading_indicator_variant.Uncontained)
  let mod_variant = loading_indicator.new(loading_indicator_variant.Contained)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-loading-indicator", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-loading-indicator", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-loading-indicator", [], [html.br([])]),
    ),

    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-loading-indicator",
        [
          attribute.attribute(
            "variant",
            loading_indicator_variant.to_string(
              loading_indicator_variant.Contained,
            ),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    loading_indicator.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

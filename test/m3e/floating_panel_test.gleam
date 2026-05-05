//// FloatingPanel unit tests
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
import m3e/floating_panel.{Config}
import m3e/floating_panel_scroll_strategy

pub fn floating_panel_default_config_test() {
  let cases = [
    Config(
      scroll_strategy: floating_panel_scroll_strategy.Hide,
      fit_anchor_width: floating_panel.IsNotFitAnchorWidth,
      anchor_offset: 0.0,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    floating_panel.default_config()
    |> should.equal(expected)
  })
}

pub fn floating_panel_from_config_test() {
  let cases = [
    #(
      floating_panel.Config(
        scroll_strategy: floating_panel_scroll_strategy.Reposition,
        fit_anchor_width: floating_panel.IsFitAnchorWidth,
        anchor_offset: 42.0,
      ),
      floating_panel.new()
        |> floating_panel.scroll_strategy(
          floating_panel_scroll_strategy.Reposition,
        )
        |> floating_panel.fit_anchor_width(floating_panel.IsFitAnchorWidth)
        |> floating_panel.anchor_offset(42.0),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    floating_panel.from_config(config)
    |> should.equal(expected)
  })
}

pub fn floating_panel_new_test() {
  let cases = [
    floating_panel.from_config(floating_panel.Config(
      scroll_strategy: floating_panel_scroll_strategy.Hide,
      fit_anchor_width: floating_panel.IsNotFitAnchorWidth,
      anchor_offset: 0.0,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    floating_panel.new()
    |> should.equal(expected)
  })
}

pub fn floating_panel_scroll_strategy_test() {
  let mod = floating_panel.new()
  let cases = [
    #(
      floating_panel_scroll_strategy.Reposition,
      floating_panel.from_config(
        floating_panel.Config(
          ..floating_panel.default_config(),
          scroll_strategy: floating_panel_scroll_strategy.Reposition,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    floating_panel.scroll_strategy(mod, field)
    |> should.equal(expected)
  })
}

pub fn floating_panel_fit_anchor_width_test() {
  let mod = floating_panel.new()
  let cases = [
    #(
      floating_panel.IsFitAnchorWidth,
      floating_panel.from_config(
        floating_panel.Config(
          ..floating_panel.default_config(),
          fit_anchor_width: floating_panel.IsFitAnchorWidth,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    floating_panel.fit_anchor_width(mod, field)
    |> should.equal(expected)
  })
}

pub fn floating_panel_anchor_offset_test() {
  let mod = floating_panel.new()
  let cases = [
    #(
      42.0,
      floating_panel.from_config(
        floating_panel.Config(
          ..floating_panel.default_config(),
          anchor_offset: 42.0,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    floating_panel.anchor_offset(mod, field)
    |> should.equal(expected)
  })
}

pub fn floating_panel_render_test() {
  let mod = floating_panel.new()

  let mod_scroll_strategy =
    floating_panel.new()
    |> floating_panel.scroll_strategy(floating_panel_scroll_strategy.Reposition)
  let mod_fit_anchor_width =
    floating_panel.new()
    |> floating_panel.fit_anchor_width(floating_panel.IsFitAnchorWidth)
  let mod_anchor_offset =
    floating_panel.new() |> floating_panel.anchor_offset(42.0)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-floating-panel", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-floating-panel", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-floating-panel", [], [html.br([])]),
    ),

    // Happy path with a scroll_strategy attribute
    #(
      #(mod_scroll_strategy, [], []),
      element.element(
        "m3e-floating-panel",
        [
          attribute.attribute(
            "scroll-strategy",
            floating_panel_scroll_strategy.to_string(
              floating_panel_scroll_strategy.Reposition,
            ),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a fit_anchor_width attribute
    #(
      #(mod_fit_anchor_width, [], []),
      element.element(
        "m3e-floating-panel",
        [attribute.attribute("fit-anchor-width", "")],
        [],
      ),
    ),
    // Happy path with a anchor_offset attribute
    #(
      #(mod_anchor_offset, [], []),
      element.element(
        "m3e-floating-panel",
        [attribute.attribute("anchor-offset", "42.0")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    floating_panel.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

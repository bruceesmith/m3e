//// Tabs unit tests
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
import m3e/tab_header_position
import m3e/tab_variant
import m3e/tabs.{Config}

pub fn tabs_default_config_test() {
  let cases = [
    Config(
      disable_pagination: tabs.IsNotDisablePagination,
      header_position: tab_header_position.Before,
      next_page_label: "Next page",
      previous_page_label: "Previous page",
      stretch: tabs.IsNotStretch,
      variant: tab_variant.Secondary,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    tabs.default_config()
    |> should.equal(expected)
  })
}

pub fn tabs_from_config_test() {
  let cases = [
    #(
      tabs.Config(
        disable_pagination: tabs.IsDisablePagination,
        header_position: tab_header_position.After,
        next_page_label: "test",
        previous_page_label: "test",
        stretch: tabs.IsStretch,
        variant: tab_variant.Primary,
      ),
      tabs.new()
        |> tabs.disable_pagination(tabs.IsDisablePagination)
        |> tabs.header_position(tab_header_position.After)
        |> tabs.next_page_label("test")
        |> tabs.previous_page_label("test")
        |> tabs.stretch(tabs.IsStretch)
        |> tabs.variant(tab_variant.Primary),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    tabs.from_config(config)
    |> should.equal(expected)
  })
}

pub fn tabs_new_test() {
  let cases = [
    tabs.from_config(tabs.Config(
      disable_pagination: tabs.IsNotDisablePagination,
      header_position: tab_header_position.Before,
      next_page_label: "Next page",
      previous_page_label: "Previous page",
      stretch: tabs.IsNotStretch,
      variant: tab_variant.Secondary,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    tabs.new()
    |> should.equal(expected)
  })
}

pub fn tabs_disable_pagination_test() {
  let mod = tabs.new()
  let cases = [
    #(
      tabs.IsDisablePagination,
      tabs.from_config(
        tabs.Config(
          ..tabs.default_config(),
          disable_pagination: tabs.IsDisablePagination,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tabs.disable_pagination(mod, field)
    |> should.equal(expected)
  })
}

pub fn tabs_header_position_test() {
  let mod = tabs.new()
  let cases = [
    #(
      tab_header_position.After,
      tabs.from_config(
        tabs.Config(
          ..tabs.default_config(),
          header_position: tab_header_position.After,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tabs.header_position(mod, field)
    |> should.equal(expected)
  })
}

pub fn tabs_next_page_label_test() {
  let mod = tabs.new()
  let cases = [
    #(
      "test",
      tabs.from_config(
        tabs.Config(..tabs.default_config(), next_page_label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tabs.next_page_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn tabs_previous_page_label_test() {
  let mod = tabs.new()
  let cases = [
    #(
      "test",
      tabs.from_config(
        tabs.Config(..tabs.default_config(), previous_page_label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tabs.previous_page_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn tabs_stretch_test() {
  let mod = tabs.new()
  let cases = [
    #(
      tabs.IsStretch,
      tabs.from_config(
        tabs.Config(..tabs.default_config(), stretch: tabs.IsStretch),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tabs.stretch(mod, field)
    |> should.equal(expected)
  })
}

pub fn tabs_variant_test() {
  let mod = tabs.new()
  let cases = [
    #(
      tab_variant.Primary,
      tabs.from_config(
        tabs.Config(..tabs.default_config(), variant: tab_variant.Primary),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tabs.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn tabs_render_test() {
  let mod = tabs.new()

  let mod_disable_pagination =
    tabs.new() |> tabs.disable_pagination(tabs.IsDisablePagination)
  let mod_header_position =
    tabs.new() |> tabs.header_position(tab_header_position.After)
  let mod_next_page_label = tabs.new() |> tabs.next_page_label("test")
  let mod_previous_page_label = tabs.new() |> tabs.previous_page_label("test")
  let mod_stretch = tabs.new() |> tabs.stretch(tabs.IsStretch)
  let mod_variant = tabs.new() |> tabs.variant(tab_variant.Primary)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-tabs", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-tabs", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(#(mod, [], [html.br([])]), element.element("m3e-tabs", [], [html.br([])])),

    // Happy path with a disable_pagination attribute
    #(
      #(mod_disable_pagination, [], []),
      element.element(
        "m3e-tabs",
        [attribute.attribute("disable-pagination", "")],
        [],
      ),
    ),
    // Happy path with a header_position attribute
    #(
      #(mod_header_position, [], []),
      element.element(
        "m3e-tabs",
        [
          attribute.attribute(
            "header-position",
            tab_header_position.to_string(tab_header_position.After),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a next_page_label attribute
    #(
      #(mod_next_page_label, [], []),
      element.element(
        "m3e-tabs",
        [attribute.attribute("next-page-label", "test")],
        [],
      ),
    ),
    // Happy path with a previous_page_label attribute
    #(
      #(mod_previous_page_label, [], []),
      element.element(
        "m3e-tabs",
        [attribute.attribute("previous-page-label", "test")],
        [],
      ),
    ),
    // Happy path with a stretch attribute
    #(
      #(mod_stretch, [], []),
      element.element("m3e-tabs", [attribute.attribute("stretch", "")], []),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-tabs",
        [
          attribute.attribute(
            "variant",
            tab_variant.to_string(tab_variant.Primary),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    tabs.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn tabs_slot_test() {
  let cases = [
    #(tabs.Panel, attribute.attribute("slot", "panel")),
    #(tabs.NextIcon, attribute.attribute("slot", "next-icon")),
    #(tabs.PrevIcon, attribute.attribute("slot", "prev-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    tabs.slot(s)
    |> should.equal(expected)
  })
}

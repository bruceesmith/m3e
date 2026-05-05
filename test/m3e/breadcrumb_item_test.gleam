//// BreadcrumbItem unit tests
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
import m3e/breadcrumb_item.{Config}
import m3e/breadcrumb_item_current
import m3e/link_target

pub fn breadcrumb_item_default_config_test() {
  let cases = [
    Config(
      item_label: "",
      disabled: breadcrumb_item.IsNotDisabled,
      current: None,
      href: "",
      target: None,
      download: None,
      rel: "",
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    breadcrumb_item.default_config()
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_from_config_test() {
  let cases = [
    #(
      breadcrumb_item.Config(
        item_label: "test",
        disabled: breadcrumb_item.IsDisabled,
        current: Some(breadcrumb_item_current.Page),
        href: "test",
        target: Some(link_target.Self),
        download: Some("test"),
        rel: "test",
      ),
      breadcrumb_item.new()
        |> breadcrumb_item.item_label("test")
        |> breadcrumb_item.disabled(breadcrumb_item.IsDisabled)
        |> breadcrumb_item.current(Some(breadcrumb_item_current.Page))
        |> breadcrumb_item.href("test")
        |> breadcrumb_item.target(Some(link_target.Self))
        |> breadcrumb_item.download(Some("test"))
        |> breadcrumb_item.rel("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    breadcrumb_item.from_config(config)
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_new_test() {
  let cases = [
    breadcrumb_item.from_config(breadcrumb_item.Config(
      item_label: "",
      disabled: breadcrumb_item.IsNotDisabled,
      current: None,
      href: "",
      target: None,
      download: None,
      rel: "",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    breadcrumb_item.new()
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_item_label_test() {
  let mod = breadcrumb_item.new()
  let cases = [
    #(
      "test",
      breadcrumb_item.from_config(
        breadcrumb_item.Config(
          ..breadcrumb_item.default_config(),
          item_label: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    breadcrumb_item.item_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_disabled_test() {
  let mod = breadcrumb_item.new()
  let cases = [
    #(
      breadcrumb_item.IsDisabled,
      breadcrumb_item.from_config(
        breadcrumb_item.Config(
          ..breadcrumb_item.default_config(),
          disabled: breadcrumb_item.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    breadcrumb_item.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_current_test() {
  let mod = breadcrumb_item.new()
  let cases = [
    #(
      Some(breadcrumb_item_current.Page),
      breadcrumb_item.from_config(
        breadcrumb_item.Config(
          ..breadcrumb_item.default_config(),
          current: Some(breadcrumb_item_current.Page),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    breadcrumb_item.current(mod, field)
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_href_test() {
  let mod = breadcrumb_item.new()
  let cases = [
    #(
      "test",
      breadcrumb_item.from_config(
        breadcrumb_item.Config(..breadcrumb_item.default_config(), href: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    breadcrumb_item.href(mod, field)
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_target_test() {
  let mod = breadcrumb_item.new()
  let cases = [
    #(
      Some(link_target.Self),
      breadcrumb_item.from_config(
        breadcrumb_item.Config(
          ..breadcrumb_item.default_config(),
          target: Some(link_target.Self),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    breadcrumb_item.target(mod, field)
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_download_test() {
  let mod = breadcrumb_item.new()
  let cases = [
    #(
      Some("test"),
      breadcrumb_item.from_config(
        breadcrumb_item.Config(
          ..breadcrumb_item.default_config(),
          download: Some("test"),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    breadcrumb_item.download(mod, field)
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_rel_test() {
  let mod = breadcrumb_item.new()
  let cases = [
    #(
      "test",
      breadcrumb_item.from_config(
        breadcrumb_item.Config(..breadcrumb_item.default_config(), rel: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    breadcrumb_item.rel(mod, field)
    |> should.equal(expected)
  })
}

pub fn breadcrumb_item_render_test() {
  let mod = breadcrumb_item.new()

  let mod_item_label =
    breadcrumb_item.new() |> breadcrumb_item.item_label("test")
  let mod_disabled =
    breadcrumb_item.new()
    |> breadcrumb_item.disabled(breadcrumb_item.IsDisabled)
  let mod_current =
    breadcrumb_item.new()
    |> breadcrumb_item.current(Some(breadcrumb_item_current.Page))
  let mod_href = breadcrumb_item.new() |> breadcrumb_item.href("test")
  let mod_target =
    breadcrumb_item.new() |> breadcrumb_item.target(Some(link_target.Self))
  let mod_download =
    breadcrumb_item.new() |> breadcrumb_item.download(Some("test"))
  let mod_rel = breadcrumb_item.new() |> breadcrumb_item.rel("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-breadcrumb-item", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-breadcrumb-item", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-breadcrumb-item", [], [html.br([])]),
    ),

    // Happy path with a item_label attribute
    #(
      #(mod_item_label, [], []),
      element.element(
        "m3e-breadcrumb-item",
        [attribute.attribute("item-label", "test")],
        [],
      ),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-breadcrumb-item",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a current attribute
    #(
      #(mod_current, [], []),
      element.element(
        "m3e-breadcrumb-item",
        [
          attribute.attribute(
            "current",
            breadcrumb_item_current.to_string(breadcrumb_item_current.Page),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a href attribute
    #(
      #(mod_href, [], []),
      element.element(
        "m3e-breadcrumb-item",
        [attribute.attribute("href", "test")],
        [],
      ),
    ),
    // Happy path with a target attribute
    #(
      #(mod_target, [], []),
      element.element(
        "m3e-breadcrumb-item",
        [attribute.attribute("target", link_target.to_string(link_target.Self))],
        [],
      ),
    ),
    // Happy path with a download attribute
    #(
      #(mod_download, [], []),
      element.element(
        "m3e-breadcrumb-item",
        [attribute.attribute("download", "test")],
        [],
      ),
    ),
    // Happy path with a rel attribute
    #(
      #(mod_rel, [], []),
      element.element(
        "m3e-breadcrumb-item",
        [attribute.attribute("rel", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    breadcrumb_item.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

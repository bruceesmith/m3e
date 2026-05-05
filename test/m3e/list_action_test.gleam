//// ListAction unit tests
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
import m3e/link_target
import m3e/list_action.{Config}

pub fn list_action_default_config_test() {
  let cases = [
    Config(
      disabled: list_action.IsNotDisabled,
      download: None,
      href: "",
      rel: "",
      target: None,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    list_action.default_config()
    |> should.equal(expected)
  })
}

pub fn list_action_from_config_test() {
  let cases = [
    #(
      list_action.Config(
        disabled: list_action.IsDisabled,
        download: Some("test"),
        href: "test",
        rel: "test",
        target: Some(link_target.Self),
      ),
      list_action.new()
        |> list_action.disabled(list_action.IsDisabled)
        |> list_action.download(Some("test"))
        |> list_action.href("test")
        |> list_action.rel("test")
        |> list_action.target(Some(link_target.Self)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    list_action.from_config(config)
    |> should.equal(expected)
  })
}

pub fn list_action_new_test() {
  let cases = [
    list_action.from_config(list_action.Config(
      disabled: list_action.IsNotDisabled,
      download: None,
      href: "",
      rel: "",
      target: None,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    list_action.new()
    |> should.equal(expected)
  })
}

pub fn list_action_disabled_test() {
  let mod = list_action.new()
  let cases = [
    #(
      list_action.IsDisabled,
      list_action.from_config(
        list_action.Config(
          ..list_action.default_config(),
          disabled: list_action.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    list_action.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn list_action_download_test() {
  let mod = list_action.new()
  let cases = [
    #(
      Some("test"),
      list_action.from_config(
        list_action.Config(
          ..list_action.default_config(),
          download: Some("test"),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    list_action.download(mod, field)
    |> should.equal(expected)
  })
}

pub fn list_action_href_test() {
  let mod = list_action.new()
  let cases = [
    #(
      "test",
      list_action.from_config(
        list_action.Config(..list_action.default_config(), href: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    list_action.href(mod, field)
    |> should.equal(expected)
  })
}

pub fn list_action_rel_test() {
  let mod = list_action.new()
  let cases = [
    #(
      "test",
      list_action.from_config(
        list_action.Config(..list_action.default_config(), rel: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    list_action.rel(mod, field)
    |> should.equal(expected)
  })
}

pub fn list_action_target_test() {
  let mod = list_action.new()
  let cases = [
    #(
      Some(link_target.Self),
      list_action.from_config(
        list_action.Config(
          ..list_action.default_config(),
          target: Some(link_target.Self),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    list_action.target(mod, field)
    |> should.equal(expected)
  })
}

pub fn list_action_render_test() {
  let mod = list_action.new()

  let mod_disabled =
    list_action.new() |> list_action.disabled(list_action.IsDisabled)
  let mod_download = list_action.new() |> list_action.download(Some("test"))
  let mod_href = list_action.new() |> list_action.href("test")
  let mod_rel = list_action.new() |> list_action.rel("test")
  let mod_target =
    list_action.new() |> list_action.target(Some(link_target.Self))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-list-action", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-list-action", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-list-action", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-list-action",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a download attribute
    #(
      #(mod_download, [], []),
      element.element(
        "m3e-list-action",
        [attribute.attribute("download", "test")],
        [],
      ),
    ),
    // Happy path with a href attribute
    #(
      #(mod_href, [], []),
      element.element(
        "m3e-list-action",
        [attribute.attribute("href", "test")],
        [],
      ),
    ),
    // Happy path with a rel attribute
    #(
      #(mod_rel, [], []),
      element.element(
        "m3e-list-action",
        [attribute.attribute("rel", "test")],
        [],
      ),
    ),
    // Happy path with a target attribute
    #(
      #(mod_target, [], []),
      element.element(
        "m3e-list-action",
        [attribute.attribute("target", link_target.to_string(link_target.Self))],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    list_action.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn list_action_slot_test() {
  let cases = [
    #(list_action.Leading, attribute.attribute("slot", "leading")),
    #(list_action.Overline, attribute.attribute("slot", "overline")),
    #(
      list_action.SupportingText,
      attribute.attribute("slot", "supporting-text"),
    ),
    #(list_action.Trailing, attribute.attribute("slot", "trailing")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    list_action.slot(s)
    |> should.equal(expected)
  })
}

//// MenuItem unit tests
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
import m3e/menu_item.{Config}

pub fn menu_item_default_config_test() {
  let cases = [
    Config(
      disabled: menu_item.IsNotDisabled,
      download: None,
      href: "",
      rel: "",
      target: None,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    menu_item.default_config()
    |> should.equal(expected)
  })
}

pub fn menu_item_from_config_test() {
  let cases = [
    #(
      menu_item.Config(
        disabled: menu_item.IsDisabled,
        download: Some("test"),
        href: "test",
        rel: "test",
        target: Some(link_target.Self),
      ),
      menu_item.new()
        |> menu_item.disabled(menu_item.IsDisabled)
        |> menu_item.download(Some("test"))
        |> menu_item.href("test")
        |> menu_item.rel("test")
        |> menu_item.target(Some(link_target.Self)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    menu_item.from_config(config)
    |> should.equal(expected)
  })
}

pub fn menu_item_new_test() {
  let cases = [
    menu_item.from_config(menu_item.Config(
      disabled: menu_item.IsNotDisabled,
      download: None,
      href: "",
      rel: "",
      target: None,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    menu_item.new()
    |> should.equal(expected)
  })
}

pub fn menu_item_disabled_test() {
  let mod = menu_item.new()
  let cases = [
    #(
      menu_item.IsDisabled,
      menu_item.from_config(
        menu_item.Config(
          ..menu_item.default_config(),
          disabled: menu_item.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    menu_item.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn menu_item_download_test() {
  let mod = menu_item.new()
  let cases = [
    #(
      Some("test"),
      menu_item.from_config(
        menu_item.Config(..menu_item.default_config(), download: Some("test")),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    menu_item.download(mod, field)
    |> should.equal(expected)
  })
}

pub fn menu_item_href_test() {
  let mod = menu_item.new()
  let cases = [
    #(
      "test",
      menu_item.from_config(
        menu_item.Config(..menu_item.default_config(), href: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    menu_item.href(mod, field)
    |> should.equal(expected)
  })
}

pub fn menu_item_rel_test() {
  let mod = menu_item.new()
  let cases = [
    #(
      "test",
      menu_item.from_config(
        menu_item.Config(..menu_item.default_config(), rel: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    menu_item.rel(mod, field)
    |> should.equal(expected)
  })
}

pub fn menu_item_target_test() {
  let mod = menu_item.new()
  let cases = [
    #(
      Some(link_target.Self),
      menu_item.from_config(
        menu_item.Config(
          ..menu_item.default_config(),
          target: Some(link_target.Self),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    menu_item.target(mod, field)
    |> should.equal(expected)
  })
}

pub fn menu_item_render_test() {
  let mod = menu_item.new()

  let mod_disabled = menu_item.new() |> menu_item.disabled(menu_item.IsDisabled)
  let mod_download = menu_item.new() |> menu_item.download(Some("test"))
  let mod_href = menu_item.new() |> menu_item.href("test")
  let mod_rel = menu_item.new() |> menu_item.rel("test")
  let mod_target = menu_item.new() |> menu_item.target(Some(link_target.Self))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-menu-item", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-menu-item", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-menu-item", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-menu-item",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a download attribute
    #(
      #(mod_download, [], []),
      element.element(
        "m3e-menu-item",
        [attribute.attribute("download", "test")],
        [],
      ),
    ),
    // Happy path with a href attribute
    #(
      #(mod_href, [], []),
      element.element(
        "m3e-menu-item",
        [attribute.attribute("href", "test")],
        [],
      ),
    ),
    // Happy path with a rel attribute
    #(
      #(mod_rel, [], []),
      element.element("m3e-menu-item", [attribute.attribute("rel", "test")], []),
    ),
    // Happy path with a target attribute
    #(
      #(mod_target, [], []),
      element.element(
        "m3e-menu-item",
        [attribute.attribute("target", link_target.to_string(link_target.Self))],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    menu_item.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn menu_item_slot_test() {
  let cases = [
    #(menu_item.Icon, attribute.attribute("slot", "icon")),
    #(menu_item.TrailingIcon, attribute.attribute("slot", "trailing-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    menu_item.slot(s)
    |> should.equal(expected)
  })
}

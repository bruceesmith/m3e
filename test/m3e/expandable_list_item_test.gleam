//// ExpandableListItem unit tests
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
import m3e/expandable_list_item.{Config}

pub fn expandable_list_item_default_config_test() {
  let cases = [
    Config(
      disabled: expandable_list_item.IsNotDisabled,
      open: expandable_list_item.IsNotOpen,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    expandable_list_item.default_config()
    |> should.equal(expected)
  })
}

pub fn expandable_list_item_from_config_test() {
  let cases = [
    #(
      expandable_list_item.Config(
        disabled: expandable_list_item.IsDisabled,
        open: expandable_list_item.IsOpen,
      ),
      expandable_list_item.new()
        |> expandable_list_item.disabled(expandable_list_item.IsDisabled)
        |> expandable_list_item.open(expandable_list_item.IsOpen),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    expandable_list_item.from_config(config)
    |> should.equal(expected)
  })
}

pub fn expandable_list_item_new_test() {
  let cases = [
    expandable_list_item.from_config(expandable_list_item.Config(
      disabled: expandable_list_item.IsNotDisabled,
      open: expandable_list_item.IsNotOpen,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    expandable_list_item.new()
    |> should.equal(expected)
  })
}

pub fn expandable_list_item_disabled_test() {
  let mod = expandable_list_item.new()
  let cases = [
    #(
      expandable_list_item.IsDisabled,
      expandable_list_item.from_config(
        expandable_list_item.Config(
          ..expandable_list_item.default_config(),
          disabled: expandable_list_item.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expandable_list_item.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn expandable_list_item_open_test() {
  let mod = expandable_list_item.new()
  let cases = [
    #(
      expandable_list_item.IsOpen,
      expandable_list_item.from_config(
        expandable_list_item.Config(
          ..expandable_list_item.default_config(),
          open: expandable_list_item.IsOpen,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    expandable_list_item.open(mod, field)
    |> should.equal(expected)
  })
}

pub fn expandable_list_item_render_test() {
  let mod = expandable_list_item.new()

  let mod_disabled =
    expandable_list_item.new()
    |> expandable_list_item.disabled(expandable_list_item.IsDisabled)
  let mod_open =
    expandable_list_item.new()
    |> expandable_list_item.open(expandable_list_item.IsOpen)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-expandable-list-item", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-expandable-list-item", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-expandable-list-item", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-expandable-list-item",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a open attribute
    #(
      #(mod_open, [], []),
      element.element(
        "m3e-expandable-list-item",
        [attribute.attribute("open", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    expandable_list_item.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn expandable_list_item_slot_test() {
  let cases = [
    #(expandable_list_item.Leading, attribute.attribute("slot", "leading")),
    #(expandable_list_item.Overline, attribute.attribute("slot", "overline")),
    #(
      expandable_list_item.SupportingText,
      attribute.attribute("slot", "supporting-text"),
    ),
    #(
      expandable_list_item.ToggleIcon,
      attribute.attribute("slot", "toggle-icon"),
    ),
    #(expandable_list_item.Items, attribute.attribute("slot", "items")),
    #(expandable_list_item.Trailing, attribute.attribute("slot", "trailing")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    expandable_list_item.slot(s)
    |> should.equal(expected)
  })
}

//// TreeItem unit tests
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
import m3e/tree_item.{Config}

pub fn tree_item_default_config_test() {
  let cases = [
    Config(
      disabled: tree_item.IsNotDisabled,
      indeterminate: tree_item.IsNotIndeterminate,
      open: tree_item.IsNotOpen,
      selected: tree_item.IsNotSelected,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    tree_item.default_config()
    |> should.equal(expected)
  })
}

pub fn tree_item_from_config_test() {
  let cases = [
    #(
      tree_item.Config(
        disabled: tree_item.IsDisabled,
        indeterminate: tree_item.IsIndeterminate,
        open: tree_item.IsOpen,
        selected: tree_item.IsSelected,
      ),
      tree_item.new()
        |> tree_item.disabled(tree_item.IsDisabled)
        |> tree_item.indeterminate(tree_item.IsIndeterminate)
        |> tree_item.open(tree_item.IsOpen)
        |> tree_item.selected(tree_item.IsSelected),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    tree_item.from_config(config)
    |> should.equal(expected)
  })
}

pub fn tree_item_new_test() {
  let cases = [
    tree_item.from_config(tree_item.Config(
      disabled: tree_item.IsNotDisabled,
      indeterminate: tree_item.IsNotIndeterminate,
      open: tree_item.IsNotOpen,
      selected: tree_item.IsNotSelected,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    tree_item.new()
    |> should.equal(expected)
  })
}

pub fn tree_item_disabled_test() {
  let mod = tree_item.new()
  let cases = [
    #(
      tree_item.IsDisabled,
      tree_item.from_config(
        tree_item.Config(
          ..tree_item.default_config(),
          disabled: tree_item.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tree_item.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn tree_item_indeterminate_test() {
  let mod = tree_item.new()
  let cases = [
    #(
      tree_item.IsIndeterminate,
      tree_item.from_config(
        tree_item.Config(
          ..tree_item.default_config(),
          indeterminate: tree_item.IsIndeterminate,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tree_item.indeterminate(mod, field)
    |> should.equal(expected)
  })
}

pub fn tree_item_open_test() {
  let mod = tree_item.new()
  let cases = [
    #(
      tree_item.IsOpen,
      tree_item.from_config(
        tree_item.Config(..tree_item.default_config(), open: tree_item.IsOpen),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tree_item.open(mod, field)
    |> should.equal(expected)
  })
}

pub fn tree_item_selected_test() {
  let mod = tree_item.new()
  let cases = [
    #(
      tree_item.IsSelected,
      tree_item.from_config(
        tree_item.Config(
          ..tree_item.default_config(),
          selected: tree_item.IsSelected,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    tree_item.selected(mod, field)
    |> should.equal(expected)
  })
}

pub fn tree_item_render_test() {
  let mod = tree_item.new()

  let mod_disabled = tree_item.new() |> tree_item.disabled(tree_item.IsDisabled)
  let mod_indeterminate =
    tree_item.new() |> tree_item.indeterminate(tree_item.IsIndeterminate)
  let mod_open = tree_item.new() |> tree_item.open(tree_item.IsOpen)
  let mod_selected = tree_item.new() |> tree_item.selected(tree_item.IsSelected)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-tree-item", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-tree-item", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-tree-item", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-tree-item",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a indeterminate attribute
    #(
      #(mod_indeterminate, [], []),
      element.element(
        "m3e-tree-item",
        [attribute.attribute("indeterminate", "")],
        [],
      ),
    ),
    // Happy path with a open attribute
    #(
      #(mod_open, [], []),
      element.element("m3e-tree-item", [attribute.attribute("open", "")], []),
    ),
    // Happy path with a selected attribute
    #(
      #(mod_selected, [], []),
      element.element(
        "m3e-tree-item",
        [attribute.attribute("selected", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    tree_item.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn tree_item_slot_test() {
  let cases = [
    #(tree_item.Label, attribute.attribute("slot", "label")),
    #(tree_item.Icon, attribute.attribute("slot", "icon")),
    #(tree_item.SelectedIcon, attribute.attribute("slot", "selected-icon")),
    #(tree_item.ToggleIcon, attribute.attribute("slot", "toggle-icon")),
    #(tree_item.OpenToggleIcon, attribute.attribute("slot", "open-toggle-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    tree_item.slot(s)
    |> should.equal(expected)
  })
}

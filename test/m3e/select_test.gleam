//// Select unit tests
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
import m3e/select.{Config}

pub fn select_default_config_test() {
  let cases = [
    Config(
      disabled: select.IsNotDisabled,
      hide_selection_indicator: select.IsNotHideSelectionIndicator,
      multi: select.IsNotMulti,
      name: "",
      panel_class: "",
      required: select.IsNotRequired,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    select.default_config()
    |> should.equal(expected)
  })
}

pub fn select_from_config_test() {
  let cases = [
    #(
      select.Config(
        disabled: select.IsDisabled,
        hide_selection_indicator: select.IsHideSelectionIndicator,
        multi: select.IsMulti,
        name: "test",
        panel_class: "test",
        required: select.IsRequired,
      ),
      select.new()
        |> select.disabled(select.IsDisabled)
        |> select.hide_selection_indicator(select.IsHideSelectionIndicator)
        |> select.multi(select.IsMulti)
        |> select.name("test")
        |> select.panel_class("test")
        |> select.required(select.IsRequired),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    select.from_config(config)
    |> should.equal(expected)
  })
}

pub fn select_new_test() {
  let cases = [
    select.from_config(select.Config(
      disabled: select.IsNotDisabled,
      hide_selection_indicator: select.IsNotHideSelectionIndicator,
      multi: select.IsNotMulti,
      name: "",
      panel_class: "",
      required: select.IsNotRequired,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    select.new()
    |> should.equal(expected)
  })
}

pub fn select_disabled_test() {
  let mod = select.new()
  let cases = [
    #(
      select.IsDisabled,
      select.from_config(
        select.Config(..select.default_config(), disabled: select.IsDisabled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    select.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn select_hide_selection_indicator_test() {
  let mod = select.new()
  let cases = [
    #(
      select.IsHideSelectionIndicator,
      select.from_config(
        select.Config(
          ..select.default_config(),
          hide_selection_indicator: select.IsHideSelectionIndicator,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    select.hide_selection_indicator(mod, field)
    |> should.equal(expected)
  })
}

pub fn select_multi_test() {
  let mod = select.new()
  let cases = [
    #(
      select.IsMulti,
      select.from_config(
        select.Config(..select.default_config(), multi: select.IsMulti),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    select.multi(mod, field)
    |> should.equal(expected)
  })
}

pub fn select_name_test() {
  let mod = select.new()
  let cases = [
    #(
      "test",
      select.from_config(select.Config(..select.default_config(), name: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    select.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn select_panel_class_test() {
  let mod = select.new()
  let cases = [
    #(
      "test",
      select.from_config(
        select.Config(..select.default_config(), panel_class: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    select.panel_class(mod, field)
    |> should.equal(expected)
  })
}

pub fn select_required_test() {
  let mod = select.new()
  let cases = [
    #(
      select.IsRequired,
      select.from_config(
        select.Config(..select.default_config(), required: select.IsRequired),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    select.required(mod, field)
    |> should.equal(expected)
  })
}

pub fn select_render_test() {
  let mod = select.new()

  let mod_disabled = select.new() |> select.disabled(select.IsDisabled)
  let mod_hide_selection_indicator =
    select.new()
    |> select.hide_selection_indicator(select.IsHideSelectionIndicator)
  let mod_multi = select.new() |> select.multi(select.IsMulti)
  let mod_name = select.new() |> select.name("test")
  let mod_panel_class = select.new() |> select.panel_class("test")
  let mod_required = select.new() |> select.required(select.IsRequired)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-select", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-select", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-select", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-select", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a hide_selection_indicator attribute
    #(
      #(mod_hide_selection_indicator, [], []),
      element.element(
        "m3e-select",
        [attribute.attribute("hide-selection-indicator", "")],
        [],
      ),
    ),
    // Happy path with a multi attribute
    #(
      #(mod_multi, [], []),
      element.element("m3e-select", [attribute.attribute("multi", "")], []),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element("m3e-select", [attribute.attribute("name", "test")], []),
    ),
    // Happy path with a panel_class attribute
    #(
      #(mod_panel_class, [], []),
      element.element(
        "m3e-select",
        [attribute.attribute("panel-class", "test")],
        [],
      ),
    ),
    // Happy path with a required attribute
    #(
      #(mod_required, [], []),
      element.element("m3e-select", [attribute.attribute("required", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    select.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn select_slot_test() {
  let cases = [
    #(select.Arrow, attribute.attribute("slot", "arrow")),
    #(select.Value, attribute.attribute("slot", "value")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    select.slot(s)
    |> should.equal(expected)
  })
}

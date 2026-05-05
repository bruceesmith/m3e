//// SegmentedButton unit tests
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
import m3e/segmented_button.{Config}

pub fn segmented_button_default_config_test() {
  let cases = [
    Config(
      disabled: segmented_button.IsNotDisabled,
      hide_selection_indicator: segmented_button.IsNotHideSelectionIndicator,
      multi: segmented_button.IsNotMulti,
      name: "",
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    segmented_button.default_config()
    |> should.equal(expected)
  })
}

pub fn segmented_button_from_config_test() {
  let cases = [
    #(
      segmented_button.Config(
        disabled: segmented_button.IsDisabled,
        hide_selection_indicator: segmented_button.IsHideSelectionIndicator,
        multi: segmented_button.IsMulti,
        name: "test",
      ),
      segmented_button.new()
        |> segmented_button.disabled(segmented_button.IsDisabled)
        |> segmented_button.hide_selection_indicator(
          segmented_button.IsHideSelectionIndicator,
        )
        |> segmented_button.multi(segmented_button.IsMulti)
        |> segmented_button.name("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    segmented_button.from_config(config)
    |> should.equal(expected)
  })
}

pub fn segmented_button_new_test() {
  let cases = [
    segmented_button.from_config(segmented_button.Config(
      disabled: segmented_button.IsNotDisabled,
      hide_selection_indicator: segmented_button.IsNotHideSelectionIndicator,
      multi: segmented_button.IsNotMulti,
      name: "",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    segmented_button.new()
    |> should.equal(expected)
  })
}

pub fn segmented_button_disabled_test() {
  let mod = segmented_button.new()
  let cases = [
    #(
      segmented_button.IsDisabled,
      segmented_button.from_config(
        segmented_button.Config(
          ..segmented_button.default_config(),
          disabled: segmented_button.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    segmented_button.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn segmented_button_hide_selection_indicator_test() {
  let mod = segmented_button.new()
  let cases = [
    #(
      segmented_button.IsHideSelectionIndicator,
      segmented_button.from_config(
        segmented_button.Config(
          ..segmented_button.default_config(),
          hide_selection_indicator: segmented_button.IsHideSelectionIndicator,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    segmented_button.hide_selection_indicator(mod, field)
    |> should.equal(expected)
  })
}

pub fn segmented_button_multi_test() {
  let mod = segmented_button.new()
  let cases = [
    #(
      segmented_button.IsMulti,
      segmented_button.from_config(
        segmented_button.Config(
          ..segmented_button.default_config(),
          multi: segmented_button.IsMulti,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    segmented_button.multi(mod, field)
    |> should.equal(expected)
  })
}

pub fn segmented_button_name_test() {
  let mod = segmented_button.new()
  let cases = [
    #(
      "test",
      segmented_button.from_config(
        segmented_button.Config(
          ..segmented_button.default_config(),
          name: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    segmented_button.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn segmented_button_render_test() {
  let mod = segmented_button.new()

  let mod_disabled =
    segmented_button.new()
    |> segmented_button.disabled(segmented_button.IsDisabled)
  let mod_hide_selection_indicator =
    segmented_button.new()
    |> segmented_button.hide_selection_indicator(
      segmented_button.IsHideSelectionIndicator,
    )
  let mod_multi =
    segmented_button.new() |> segmented_button.multi(segmented_button.IsMulti)
  let mod_name = segmented_button.new() |> segmented_button.name("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-segmented-button", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-segmented-button", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-segmented-button", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-segmented-button",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a hide_selection_indicator attribute
    #(
      #(mod_hide_selection_indicator, [], []),
      element.element(
        "m3e-segmented-button",
        [attribute.attribute("hide-selection-indicator", "")],
        [],
      ),
    ),
    // Happy path with a multi attribute
    #(
      #(mod_multi, [], []),
      element.element(
        "m3e-segmented-button",
        [attribute.attribute("multi", "")],
        [],
      ),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element(
        "m3e-segmented-button",
        [attribute.attribute("name", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    segmented_button.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

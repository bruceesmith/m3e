//// Option unit tests
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
import m3e/option.{Config}
import m3e/text_highlight_mode

pub fn option_default_config_test() {
  let cases = [
    Config(
      disabled: option.IsNotDisabled,
      disable_highlight: option.IsNotDisableHighlight,
      highlight_mode: text_highlight_mode.Contains,
      selected: option.IsNotSelected,
      term: "",
      value: "",
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    option.default_config()
    |> should.equal(expected)
  })
}

pub fn option_from_config_test() {
  let cases = [
    #(
      option.Config(
        disabled: option.IsDisabled,
        disable_highlight: option.IsDisableHighlight,
        highlight_mode: text_highlight_mode.StartsWith,
        selected: option.IsSelected,
        term: "test",
        value: "test",
      ),
      option.new()
        |> option.disabled(option.IsDisabled)
        |> option.disable_highlight(option.IsDisableHighlight)
        |> option.highlight_mode(text_highlight_mode.StartsWith)
        |> option.selected(option.IsSelected)
        |> option.term("test")
        |> option.value("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    option.from_config(config)
    |> should.equal(expected)
  })
}

pub fn option_new_test() {
  let cases = [
    option.from_config(option.Config(
      disabled: option.IsNotDisabled,
      disable_highlight: option.IsNotDisableHighlight,
      highlight_mode: text_highlight_mode.Contains,
      selected: option.IsNotSelected,
      term: "",
      value: "",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    option.new()
    |> should.equal(expected)
  })
}

pub fn option_disabled_test() {
  let mod = option.new()
  let cases = [
    #(
      option.IsDisabled,
      option.from_config(
        option.Config(..option.default_config(), disabled: option.IsDisabled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    option.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn option_disable_highlight_test() {
  let mod = option.new()
  let cases = [
    #(
      option.IsDisableHighlight,
      option.from_config(
        option.Config(
          ..option.default_config(),
          disable_highlight: option.IsDisableHighlight,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    option.disable_highlight(mod, field)
    |> should.equal(expected)
  })
}

pub fn option_highlight_mode_test() {
  let mod = option.new()
  let cases = [
    #(
      text_highlight_mode.StartsWith,
      option.from_config(
        option.Config(
          ..option.default_config(),
          highlight_mode: text_highlight_mode.StartsWith,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    option.highlight_mode(mod, field)
    |> should.equal(expected)
  })
}

pub fn option_selected_test() {
  let mod = option.new()
  let cases = [
    #(
      option.IsSelected,
      option.from_config(
        option.Config(..option.default_config(), selected: option.IsSelected),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    option.selected(mod, field)
    |> should.equal(expected)
  })
}

pub fn option_term_test() {
  let mod = option.new()
  let cases = [
    #(
      "test",
      option.from_config(option.Config(..option.default_config(), term: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    option.term(mod, field)
    |> should.equal(expected)
  })
}

pub fn option_value_test() {
  let mod = option.new()
  let cases = [
    #(
      "test",
      option.from_config(
        option.Config(..option.default_config(), value: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    option.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn option_render_test() {
  let mod = option.new()

  let mod_disabled = option.new() |> option.disabled(option.IsDisabled)
  let mod_disable_highlight =
    option.new() |> option.disable_highlight(option.IsDisableHighlight)
  let mod_highlight_mode =
    option.new() |> option.highlight_mode(text_highlight_mode.StartsWith)
  let mod_selected = option.new() |> option.selected(option.IsSelected)
  let mod_term = option.new() |> option.term("test")
  let mod_value = option.new() |> option.value("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-option", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-option", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-option", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-option", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a disable_highlight attribute
    #(
      #(mod_disable_highlight, [], []),
      element.element(
        "m3e-option",
        [attribute.attribute("disable-highlight", "")],
        [],
      ),
    ),
    // Happy path with a highlight_mode attribute
    #(
      #(mod_highlight_mode, [], []),
      element.element(
        "m3e-option",
        [
          attribute.attribute(
            "highlight-mode",
            text_highlight_mode.to_string(text_highlight_mode.StartsWith),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a selected attribute
    #(
      #(mod_selected, [], []),
      element.element("m3e-option", [attribute.attribute("selected", "")], []),
    ),
    // Happy path with a term attribute
    #(
      #(mod_term, [], []),
      element.element("m3e-option", [attribute.attribute("term", "test")], []),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element("m3e-option", [attribute.attribute("value", "test")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    option.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

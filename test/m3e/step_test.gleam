//// Step unit tests
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
import m3e/step.{Config}

pub fn step_default_config_test() {
  let cases = [
    Config(
      completed: step.IsNotCompleted,
      disabled: step.IsNotDisabled,
      editable: step.IsNotEditable,
      for: None,
      optional: step.IsNotOptional,
      selected: step.IsNotSelected,
      invalid: step.IsNotInvalid,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    step.default_config()
    |> should.equal(expected)
  })
}

pub fn step_from_config_test() {
  let cases = [
    #(
      step.Config(
        completed: step.IsCompleted,
        disabled: step.IsDisabled,
        editable: step.IsEditable,
        for: Some("test"),
        optional: step.IsOptional,
        selected: step.IsSelected,
        invalid: step.IsInvalid,
      ),
      step.new()
        |> step.completed(step.IsCompleted)
        |> step.disabled(step.IsDisabled)
        |> step.editable(step.IsEditable)
        |> step.for(Some("test"))
        |> step.optional(step.IsOptional)
        |> step.selected(step.IsSelected)
        |> step.invalid(step.IsInvalid),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    step.from_config(config)
    |> should.equal(expected)
  })
}

pub fn step_new_test() {
  let cases = [
    step.from_config(step.Config(
      completed: step.IsNotCompleted,
      disabled: step.IsNotDisabled,
      editable: step.IsNotEditable,
      for: None,
      optional: step.IsNotOptional,
      selected: step.IsNotSelected,
      invalid: step.IsNotInvalid,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    step.new()
    |> should.equal(expected)
  })
}

pub fn step_completed_test() {
  let mod = step.new()
  let cases = [
    #(
      step.IsCompleted,
      step.from_config(
        step.Config(..step.default_config(), completed: step.IsCompleted),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    step.completed(mod, field)
    |> should.equal(expected)
  })
}

pub fn step_disabled_test() {
  let mod = step.new()
  let cases = [
    #(
      step.IsDisabled,
      step.from_config(
        step.Config(..step.default_config(), disabled: step.IsDisabled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    step.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn step_editable_test() {
  let mod = step.new()
  let cases = [
    #(
      step.IsEditable,
      step.from_config(
        step.Config(..step.default_config(), editable: step.IsEditable),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    step.editable(mod, field)
    |> should.equal(expected)
  })
}

pub fn step_for_test() {
  let mod = step.new()
  let cases = [
    #(
      Some("test"),
      step.from_config(step.Config(..step.default_config(), for: Some("test"))),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    step.for(mod, field)
    |> should.equal(expected)
  })
}

pub fn step_optional_test() {
  let mod = step.new()
  let cases = [
    #(
      step.IsOptional,
      step.from_config(
        step.Config(..step.default_config(), optional: step.IsOptional),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    step.optional(mod, field)
    |> should.equal(expected)
  })
}

pub fn step_selected_test() {
  let mod = step.new()
  let cases = [
    #(
      step.IsSelected,
      step.from_config(
        step.Config(..step.default_config(), selected: step.IsSelected),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    step.selected(mod, field)
    |> should.equal(expected)
  })
}

pub fn step_invalid_test() {
  let mod = step.new()
  let cases = [
    #(
      step.IsInvalid,
      step.from_config(
        step.Config(..step.default_config(), invalid: step.IsInvalid),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    step.invalid(mod, field)
    |> should.equal(expected)
  })
}

pub fn step_render_test() {
  let mod = step.new()

  let mod_completed = step.new() |> step.completed(step.IsCompleted)
  let mod_disabled = step.new() |> step.disabled(step.IsDisabled)
  let mod_editable = step.new() |> step.editable(step.IsEditable)
  let mod_for = step.new() |> step.for(Some("test"))
  let mod_optional = step.new() |> step.optional(step.IsOptional)
  let mod_selected = step.new() |> step.selected(step.IsSelected)
  let mod_invalid = step.new() |> step.invalid(step.IsInvalid)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-step", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-step", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(#(mod, [], [html.br([])]), element.element("m3e-step", [], [html.br([])])),

    // Happy path with a completed attribute
    #(
      #(mod_completed, [], []),
      element.element("m3e-step", [attribute.attribute("completed", "")], []),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-step", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a editable attribute
    #(
      #(mod_editable, [], []),
      element.element("m3e-step", [attribute.attribute("editable", "")], []),
    ),
    // Happy path with a for attribute
    #(
      #(mod_for, [], []),
      element.element("m3e-step", [attribute.attribute("for", "test")], []),
    ),
    // Happy path with a optional attribute
    #(
      #(mod_optional, [], []),
      element.element("m3e-step", [attribute.attribute("optional", "")], []),
    ),
    // Happy path with a selected attribute
    #(
      #(mod_selected, [], []),
      element.element("m3e-step", [attribute.attribute("selected", "")], []),
    ),
    // Happy path with a invalid attribute
    #(
      #(mod_invalid, [], []),
      element.element("m3e-step", [attribute.attribute("invalid", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    step.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn step_slot_test() {
  let cases = [
    #(step.Icon, attribute.attribute("slot", "icon")),
    #(step.DoneIcon, attribute.attribute("slot", "done-icon")),
    #(step.EditIcon, attribute.attribute("slot", "edit-icon")),
    #(step.ErrorIcon, attribute.attribute("slot", "error-icon")),
    #(step.Hint, attribute.attribute("slot", "hint")),
    #(step.Error, attribute.attribute("slot", "error")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    step.slot(s)
    |> should.equal(expected)
  })
}

import gleam/option.{Some}
import gleeunit/should

import lustre/attribute.{attribute, for, id}
import lustre/element.{element, text}

import m3e/form_submission
import m3e/switch.{
  Both, Selected, checked, disabled, form, icon, label, new, render,
}

pub fn switch_basic_test() {
  let s = new("test_id") |> label(Some("Test Label"))
  let expected = [
    element("m3e-switch", [id("test_id"), attribute("icons", "none")], []),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  render(s, []) |> should.equal(expected)
}

pub fn switch_full_test() {
  let s =
    new("test_id")
    |> label(Some("Test Label"))
    |> checked(True)
    |> disabled(True)
    |> form(Some(
      form_submission.new()
      |> form_submission.name("key")
      |> form_submission.value("value"),
    ))
    |> icon(Both)

  let expected = [
    element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "both"),
        attribute("checked", ""),
        attribute("disabled", ""),
        attribute("name", "key"),
        attribute("value", "value"),
      ],
      [],
    ),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  render(s, []) |> should.equal(expected)
}

pub fn switch_element_test() {
  let s =
    new("test_id")
    |> label(Some("Test Label"))
  let expected = [
    element("m3e-switch", [id("test_id"), attribute("icons", "none")], []),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> render([])
  |> should.equal(expected)
}

pub fn switch_checked_test() {
  let s =
    new("test_id")
    |> label(Some("Test Label"))
    |> checked(True)

  let expected = [
    element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("checked", ""),
      ],
      [],
    ),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> render([])
  |> should.equal(expected)
}

pub fn switch_disabled_test() {
  let s =
    new("test_id")
    |> label(Some("Test Label"))
    |> disabled(True)

  let expected = [
    element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("disabled", ""),
      ],
      [],
    ),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> render([])
  |> should.equal(expected)
}

pub fn switch_form_test() {
  let s =
    new("test_id")
    |> label(Some("Test Label"))
    |> form(Some(
      form_submission.new()
      |> form_submission.name("some_key")
      |> form_submission.value("some_value"),
    ))

  let expected = [
    element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("name", "some_key"),
        attribute("value", "some_value"),
      ],
      [],
    ),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> render([])
  |> should.equal(expected)
}

pub fn switch_icon_test() {
  let s =
    new("test_id")
    |> label(Some("Test Label"))
    |> icon(Both)

  let expected = [
    element("m3e-switch", [id("test_id"), attribute("icons", "both")], []),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> render([])
  |> should.equal(expected)

  let s = s |> icon(Selected)
  let expected = [
    element("m3e-switch", [id("test_id"), attribute("icons", "selected")], []),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> render([])
  |> should.equal(expected)
}

pub fn render_with_label_test() {
  let s = switch.new("my-switch") |> switch.label(Some("My Label"))
  let expected = [
    element(
      "m3e-switch",
      [attribute.attribute("id", "my-switch"), attribute("icons", "none")],
      [],
    ),
    element("label", [attribute.attribute("for", "my-switch")], [
      text("My Label"),
    ]),
  ]

  s
  |> render([])
  |> should.equal(expected)
}

pub fn render_without_label_test() {
  let s = switch.new("my-switch")
  let expected = [
    element(
      "m3e-switch",
      [attribute.attribute("id", "my-switch"), attribute("icons", "none")],
      [],
    ),
  ]

  s
  |> render([])
  |> should.equal(expected)
}

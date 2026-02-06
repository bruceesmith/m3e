import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute, for, id}
import lustre/element.{element}
import m3e/switch.{
  Both, Selected, checked, disabled, form, icon, key, new, render, value,
}

pub fn switch_basic_test() {
  let s = new("test_id", "Test Label")
  let expected = [
    element("m3e-switch", [id("test_id"), attribute("icons", "none")], []),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  render(s, []) |> should.equal(expected)
}

pub fn switch_full_test() {
  let s =
    new("test_id", "Test Label")
    |> checked(True)
    |> disabled(True)
    |> form(Some("key"), Some("value"))
    |> icon(Both)
    |> key(Some("key"))
    |> value(Some("value"))

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
  let s = new("test_id", "Test Label")
  let expected = [
    element("m3e-switch", [id("test_id"), attribute("icons", "none")], []),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> render([])
  |> should.equal(expected)
}

pub fn switch_checked_test() {
  let s = new("test_id", "Test Label") |> checked(True)

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
  let s = new("test_id", "Test Label") |> disabled(True)

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
    new("test_id", "Test Label")
    |> form(Some("some_key"), Some("some_value"))

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
  let s = new("test_id", "Test Label") |> icon(Both)

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

pub fn switch_key_test() {
  let s = new("test_id", "Test Label") |> key(Some("test_key"))

  let expected = [
    element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("name", "test_key"),
      ],
      [],
    ),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> render([])
  |> should.equal(expected)
}

pub fn switch_value_test() {
  let s = new("test_id", "Test Label") |> value(Some("test_value"))

  let expected = [
    element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("value", "test_value"),
      ],
      [],
    ),
    element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> render([])
  |> should.equal(expected)
}

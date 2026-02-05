import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute, for, id}
import lustre/element
import m3e/switch.{
  Both, Selected, basic, checked, disabled, element, form, icon, key, switch,
  value,
}

pub fn switch_basic_test() {
  let s = basic("test_id", "Test Label")
  let expected = [
    element.element(
      "m3e-switch",
      [id("test_id"), attribute("icons", "none")],
      [],
    ),
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  element(s, []) |> should.equal(expected)
}

pub fn switch_full_test() {
  let s =
    switch(
      "test_id",
      "Test Label",
      Both,
      True,
      True,
      Some("key"),
      Some("value"),
    )
  let expected = [
    element.element(
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
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  element(s, []) |> should.equal(expected)
}

pub fn switch_element_test() {
  let s = basic("test_id", "Test Label")
  let expected = [
    element.element(
      "m3e-switch",
      [id("test_id"), attribute("icons", "none")],
      [],
    ),
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> element([])
  |> should.equal(expected)
}

pub fn switch_checked_test() {
  let s = basic("test_id", "Test Label") |> checked(True)

  let expected = [
    element.element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("checked", ""),
      ],
      [],
    ),
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> element([])
  |> should.equal(expected)
}

pub fn switch_disabled_test() {
  let s = basic("test_id", "Test Label") |> disabled(True)

  let expected = [
    element.element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("disabled", ""),
      ],
      [],
    ),
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> element([])
  |> should.equal(expected)
}

pub fn switch_form_test() {
  let s =
    basic("test_id", "Test Label")
    |> form(Some("some_key"), Some("some_value"))

  let expected = [
    element.element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("name", "some_key"),
        attribute("value", "some_value"),
      ],
      [],
    ),
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> element([])
  |> should.equal(expected)
}

pub fn switch_icon_test() {
  let s = basic("test_id", "Test Label") |> icon(Both)

  let expected = [
    element.element(
      "m3e-switch",
      [id("test_id"), attribute("icons", "both")],
      [],
    ),
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> element([])
  |> should.equal(expected)

  let s = s |> icon(Selected)
  let expected = [
    element.element(
      "m3e-switch",
      [id("test_id"), attribute("icons", "selected")],
      [],
    ),
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> element([])
  |> should.equal(expected)
}

pub fn switch_key_test() {
  let s = basic("test_id", "Test Label") |> key(Some("test_key"))

  let expected = [
    element.element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("name", "test_key"),
      ],
      [],
    ),
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> element([])
  |> should.equal(expected)
}

pub fn switch_value_test() {
  let s = basic("test_id", "Test Label") |> value(Some("test_value"))

  let expected = [
    element.element(
      "m3e-switch",
      [
        id("test_id"),
        attribute("icons", "none"),
        attribute("value", "test_value"),
      ],
      [],
    ),
    element.element("label", [for("test_id")], [element.text("Test Label")]),
  ]
  s
  |> element([])
  |> should.equal(expected)
}

import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute, for, id}
import lustre/element
import m3e/switch.{
  Both, Neither, Selected, basic, checked, disabled, element, form, icon, key,
  switch, value,
}

pub fn switch_basic_test() {
  let s = basic("test_id", "Test Label")
  s.id |> should.equal("test_id")
  s.label |> should.equal("Test Label")
  s.icons |> should.equal(Neither)
  s.checked |> should.be_false()
  s.disabled |> should.be_false()
  s.key |> should.equal(None)
  s.value |> should.equal(None)
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
  s.id |> should.equal("test_id")
  s.label |> should.equal("Test Label")
  s.icons |> should.equal(Both)
  s.checked |> should.be_true()
  s.disabled |> should.be_true()
  s.key |> should.equal(Some("key"))
  s.value |> should.equal(Some("value"))
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
  s.checked |> should.be_true()

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
  s.disabled |> should.be_true()

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
  s.key |> should.equal(Some("some_key"))
  s.value |> should.equal(Some("some_value"))

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
  s.icons |> should.equal(Both)

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
  s.key |> should.equal(Some("test_key"))

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
  s.value |> should.equal(Some("test_value"))

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

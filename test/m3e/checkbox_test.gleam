import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/checkbox.{
  checkbox, checked, disabled, form, key, render, required, value,
}

pub fn checkbox_basic_test() {
  let c = checkbox(False, False, None, False, None)
  let expected = element("m3e-checkbox", [], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_element_test() {
  let c = checkbox(False, False, None, False, None)
  let expected = element("m3e-checkbox", [], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_checked_test() {
  let c = checkbox(False, False, None, False, None) |> checked(True)

  let expected = element("m3e-checkbox", [attribute("checked", "")], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_disabled_test() {
  let c = checkbox(False, False, None, False, None) |> disabled(True)

  let expected =
    element("m3e-checkbox", [attribute("disabled", "")], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_form_test() {
  let c =
    checkbox(False, False, None, False, None)
    |> form(Some("some_key"), Some("some_value"))

  let expected =
    element(
      "m3e-checkbox",
      [attribute("name", "some_key"), attribute("value", "some_value")],
      [],
    )
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_key_test() {
  let c = checkbox(False, False, None, False, None) |> key(Some("test_key"))

  let expected =
    element("m3e-checkbox", [attribute("name", "test_key")], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_required_test() {
  let c = checkbox(False, False, None, False, None) |> required(True)

  let expected =
    element("m3e-checkbox", [attribute("required", "")], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_value_test() {
  let c = checkbox(False, False, None, False, None) |> value(Some("test_value"))

  let expected =
    element("m3e-checkbox", [attribute("value", "test_value")], [])
  c
  |> render()
  |> should.equal(expected)
}

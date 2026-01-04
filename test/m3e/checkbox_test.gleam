import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import m3e/checkbox.{
  checkbox, checked, disabled, element, form, key, required, value,
}

pub fn checkbox_basic_test() {
  let c = checkbox(False, False, None, False, None)
  c.checked |> should.be_false()
  c.disabled |> should.be_false()
  c.key |> should.equal(None)
  c.required |> should.be_false()
  c.value |> should.equal(None)
}

pub fn checkbox_element_test() {
  let c = checkbox(False, False, None, False, None)
  let expected = element.element("m3e-checkbox", [], [])
  c
  |> element()
  |> should.equal(expected)
}

pub fn checkbox_checked_test() {
  let c = checkbox(False, False, None, False, None) |> checked(True)
  c.checked |> should.be_true()

  let expected =
    element.element("m3e-checkbox", [attribute("checked", "")], [])
  c
  |> element()
  |> should.equal(expected)
}

pub fn checkbox_disabled_test() {
  let c = checkbox(False, False, None, False, None) |> disabled(True)
  c.disabled |> should.be_true()

  let expected =
    element.element("m3e-checkbox", [attribute("disabled", "")], [])
  c
  |> element()
  |> should.equal(expected)
}

pub fn checkbox_form_test() {
  let c =
    checkbox(False, False, None, False, None)
    |> form(Some("some_key"), Some("some_value"))
  c.key |> should.equal(Some("some_key"))
  c.value |> should.equal(Some("some_value"))

  let expected =
    element.element(
      "m3e-checkbox",
      [attribute("name", "some_key"), attribute("value", "some_value")],
      [],
    )
  c
  |> element()
  |> should.equal(expected)
}

pub fn checkbox_key_test() {
  let c = checkbox(False, False, None, False, None) |> key(Some("test_key"))
  c.key |> should.equal(Some("test_key"))

  let expected =
    element.element("m3e-checkbox", [attribute("name", "test_key")], [])
  c
  |> element()
  |> should.equal(expected)
}

pub fn checkbox_required_test() {
  let c = checkbox(False, False, None, False, None) |> required(True)
  c.required |> should.be_true()

  let expected =
    element.element("m3e-checkbox", [attribute("required", "")], [])
  c
  |> element()
  |> should.equal(expected)
}

pub fn checkbox_value_test() {
  let c =
    checkbox(False, False, None, False, None) |> value(Some("test_value"))
  c.value |> should.equal(Some("test_value"))

  let expected =
    element.element("m3e-checkbox", [attribute("value", "test_value")], [])
  c
  |> element()
  |> should.equal(expected)
}

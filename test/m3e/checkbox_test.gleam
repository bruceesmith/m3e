import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/checkbox.{checked, disabled, form, new, render, required}
import m3e/form_submission

pub fn checkbox_basic_test() {
  let c = new()
  let expected = element("m3e-checkbox", [], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_element_test() {
  let c = new()
  let expected = element("m3e-checkbox", [], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_checked_test() {
  let c = new() |> checked(True)

  let expected = element("m3e-checkbox", [attribute("checked", "")], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_disabled_test() {
  let c = new() |> disabled(True)

  let expected = element("m3e-checkbox", [attribute("disabled", "")], [])
  c
  |> render()
  |> should.equal(expected)
}

pub fn checkbox_form_test() {
  let c =
    new()
    |> form(Some(
      form_submission.new()
      |> form_submission.name("some_key")
      |> form_submission.value("some_value"),
    ))

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

pub fn checkbox_required_test() {
  let c = new() |> required(True)

  let expected = element("m3e-checkbox", [attribute("required", "")], [])
  c
  |> render()
  |> should.equal(expected)
}

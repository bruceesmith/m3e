import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/checkbox.{Config}
import m3e/form_submission
import m3e/state.{Checked, Disabled, Required}

pub fn checkbox_basic_test() {
  let c = checkbox.new()
  let expected = element.element("m3e-checkbox", [], [])
  c
  |> checkbox.render()
  |> should.equal(expected)
}

pub fn checkbox_element_test() {
  let c = checkbox.new()
  let expected = element.element("m3e-checkbox", [], [])
  c
  |> checkbox.render()
  |> should.equal(expected)
}

pub fn checkbox_checked_test() {
  let c = checkbox.new() |> checkbox.checked(Checked)

  let expected =
    element.element("m3e-checkbox", [attribute.attribute("checked", "")], [])
  c
  |> checkbox.render()
  |> should.equal(expected)
}

pub fn checkbox_disabled_test() {
  let c = checkbox.new() |> checkbox.disabled(Disabled)

  let expected =
    element.element("m3e-checkbox", [attribute.attribute("disabled", "")], [])
  c
  |> checkbox.render()
  |> should.equal(expected)
}

pub fn checkbox_form_test() {
  let c =
    checkbox.new()
    |> checkbox.form(Some(
      form_submission.new()
      |> form_submission.name("some_key")
      |> form_submission.value("some_value"),
    ))

  let expected =
    element.element(
      "m3e-checkbox",
      [
        attribute.attribute("name", "some_key"),
        attribute.attribute("value", "some_value"),
      ],
      [],
    )
  c
  |> checkbox.render()
  |> should.equal(expected)
}

pub fn checkbox_required_test() {
  let c = checkbox.new() |> checkbox.required(Required)

  let expected =
    element.element("m3e-checkbox", [attribute.attribute("required", "")], [])
  c
  |> checkbox.render()
  |> should.equal(expected)
}

pub fn checkbox_render_config_test() {
  let config =
    Config(..checkbox.default_config(), checked: Checked, requirement: Required)
  let expected =
    element.element(
      "m3e-checkbox",
      [attribute.attribute("checked", ""), attribute.attribute("required", "")],
      [],
    )

  checkbox.render_config(config)
  |> should.equal(expected)
}

import gleam/option.{None}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/radio
import m3e/state.{Checked, Disabled, Enabled, Optional, Required, Unchecked}

pub fn radio_creation_test() {
  let r = radio.new()
  let expected = element.element("m3e-radio", [], [])
  radio.render(r, [], []) |> should.equal(expected)
}

pub fn radio_setters_test() {
  let r = radio.new()

  let r_checked = r |> radio.checked(Checked)
  let expected_checked =
    element.element("m3e-radio", [attribute.attribute("checked", "")], [])
  radio.render(r_checked, [], []) |> should.equal(expected_checked)

  let r_disabled = r |> radio.disabled(Disabled)
  let expected_disabled =
    element.element("m3e-radio", [attribute.attribute("disabled", "")], [])
  radio.render(r_disabled, [], []) |> should.equal(expected_disabled)

  let r_required = r |> radio.required(Required)
  let expected_required =
    element.element("m3e-radio", [attribute.attribute("required", "")], [])
  radio.render(r_required, [], []) |> should.equal(expected_required)
}

pub fn radio_element_test() {
  let r = radio.new()
  let expected = element.element("m3e-radio", [], [element.text("Child")])
  radio.render(r, [], [element.text("Child")]) |> should.equal(expected)
}

pub fn config_test() {
  let c =
    radio.Config(
      checked: Checked,
      disabled: Disabled,
      form_submission: None,
      requirement: Required,
    )

  let r = radio.from_config(c)

  radio.render(r, [], [])
  |> should.equal(
    element.element(
      "m3e-radio",
      [
        attribute.attribute("checked", ""),
        attribute.attribute("disabled", ""),
        attribute.attribute("required", ""),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = radio.default_config()

  c.checked |> should.equal(Unchecked)
  c.disabled |> should.equal(Enabled)
  c.form_submission |> should.equal(None)
  c.requirement |> should.equal(Optional)
}

pub fn from_config_test() {
  let c = radio.default_config()
  let r = radio.from_config(c)

  radio.render(r, [], [])
  |> should.equal(radio.render(radio.new(), [], []))
}

pub fn render_config_test() {
  let c = radio.default_config()
  let expected = radio.render(radio.from_config(c), [], [])

  radio.render_config(c, [], [])
  |> should.equal(expected)
}

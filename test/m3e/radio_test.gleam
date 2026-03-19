import gleam/option.{None}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/radio.{checked, disabled, new, render, required}

pub fn radio_creation_test() {
  let r = new()
  let expected = element("m3e-radio", [], [])
  render(r, [], []) |> should.equal(expected)
}

pub fn radio_setters_test() {
  let r = new()

  let r_checked = r |> checked(radio.Checked)
  let expected_checked = element("m3e-radio", [attribute("checked", "")], [])
  render(r_checked, [], []) |> should.equal(expected_checked)

  let r_disabled = r |> disabled(radio.Disabled)
  let expected_disabled = element("m3e-radio", [attribute("disabled", "")], [])
  render(r_disabled, [], []) |> should.equal(expected_disabled)

  let r_required = r |> required(radio.Required)
  let expected_required = element("m3e-radio", [attribute("required", "")], [])
  render(r_required, [], []) |> should.equal(expected_required)
}

pub fn radio_element_test() {
  let r = new()
  let expected = element("m3e-radio", [], [text("Child")])
  render(r, [], [text("Child")]) |> should.equal(expected)
}

pub fn config_test() {
  let c =
    radio.Config(
      checked: radio.Checked,
      interaction: radio.Disabled,
      form_submission: None,
      requirement: radio.Required,
    )

  let r = radio.from_config(c)

  render(r, [], [])
  |> should.equal(
    element(
      "m3e-radio",
      [
        attribute("checked", ""),
        attribute("disabled", ""),
        attribute("required", ""),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = radio.default_config()

  c.checked |> should.equal(radio.Unchecked)
  c.interaction |> should.equal(radio.Enabled)
  c.form_submission |> should.equal(None)
  c.requirement |> should.equal(radio.Optional)
}

pub fn from_config_test() {
  let c = radio.default_config()
  let r = radio.from_config(c)

  render(r, [], [])
  |> should.equal(render(new(), [], []))
}

pub fn render_config_test() {
  let c = radio.default_config()
  let expected = render(radio.from_config(c), [], [])

  radio.render_config(c, [], [])
  |> should.equal(expected)
}

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

  let r_checked = r |> checked(True)
  let expected_checked = element("m3e-radio", [attribute("checked", "")], [])
  render(r_checked, [], []) |> should.equal(expected_checked)

  let r_disabled = r |> disabled(True)
  let expected_disabled = element("m3e-radio", [attribute("disabled", "")], [])
  render(r_disabled, [], []) |> should.equal(expected_disabled)

  let r_required = r |> required(True)
  let expected_required = element("m3e-radio", [attribute("required", "")], [])
  render(r_required, [], []) |> should.equal(expected_required)
}

pub fn radio_element_test() {
  let r = new()
  let expected = element("m3e-radio", [], [text("Child")])
  render(r, [], [text("Child")]) |> should.equal(expected)
}

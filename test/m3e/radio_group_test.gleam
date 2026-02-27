import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/radio_group.{disabled, id, name, new, render, required}

pub fn radio_group_creation_test() {
  let rg = new()
  let expected = element("m3e-radio-group", [], [])
  render(rg, [], []) |> should.equal(expected)
}

pub fn radio_group_setters_test() {
  let rg = new()

  let rg_disabled = rg |> disabled(True)
  let expected_disabled =
    element("m3e-radio-group", [attribute("disabled", "")], [])
  render(rg_disabled, [], []) |> should.equal(expected_disabled)

  let rg_id = rg |> id(Some("test-id"))
  let expected_id = element("m3e-radio-group", [attribute("id", "test-id")], [])
  render(rg_id, [], []) |> should.equal(expected_id)

  let rg_name = rg |> name(Some("test-name"))
  let expected_name =
    element("m3e-radio-group", [attribute("name", "test-name")], [])
  render(rg_name, [], []) |> should.equal(expected_name)

  let rg_required = rg |> required(True)
  let expected_required =
    element("m3e-radio-group", [attribute("required", "")], [])
  render(rg_required, [], []) |> should.equal(expected_required)
}

pub fn radio_group_element_test() {
  let rg = new()
  let expected = element("m3e-radio-group", [], [text("Child")])
  render(rg, [], [text("Child")]) |> should.equal(expected)
}

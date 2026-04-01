import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/radio_group
import m3e/state.{Disabled, Enabled, Optional, Required}

pub fn radio_group_creation_test() {
  let rg = radio_group.new()
  let expected = element.element("m3e-radio-group", [], [])
  radio_group.render(rg, [], []) |> should.equal(expected)
}

pub fn radio_group_setters_test() {
  let rg = radio_group.new()

  let rg_disabled = rg |> radio_group.disabled(Disabled)
  let expected_disabled =
    element.element(
      "m3e-radio-group",
      [attribute.attribute("disabled", "")],
      [],
    )
  radio_group.render(rg_disabled, [], []) |> should.equal(expected_disabled)

  let rg_id = rg |> radio_group.id(Some("test-id"))
  let expected_id =
    element.element(
      "m3e-radio-group",
      [attribute.attribute("id", "test-id")],
      [],
    )
  radio_group.render(rg_id, [], []) |> should.equal(expected_id)

  let rg_name = rg |> radio_group.name(Some("test-name"))
  let expected_name =
    element.element(
      "m3e-radio-group",
      [attribute.attribute("name", "test-name")],
      [],
    )
  radio_group.render(rg_name, [], []) |> should.equal(expected_name)

  let rg_required = rg |> radio_group.required(Required)
  let expected_required =
    element.element(
      "m3e-radio-group",
      [attribute.attribute("required", "")],
      [],
    )
  radio_group.render(rg_required, [], []) |> should.equal(expected_required)
}

pub fn radio_group_element_test() {
  let rg = radio_group.new()
  let expected = element.element("m3e-radio-group", [], [element.text("Child")])
  radio_group.render(rg, [], [element.text("Child")]) |> should.equal(expected)
}

pub fn config_test() {
  let c =
    radio_group.Config(
      disabled: Disabled,
      id: Some("config-id"),
      name: Some("config-name"),
      requirement: Required,
    )

  let rg = radio_group.from_config(c)

  radio_group.render(rg, [], [])
  |> should.equal(
    element.element(
      "m3e-radio-group",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("id", "config-id"),
        attribute.attribute("name", "config-name"),
        attribute.attribute("required", ""),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = radio_group.default_config()

  c.disabled |> should.equal(Enabled)
  c.id |> should.equal(None)
  c.name |> should.equal(None)
  c.requirement |> should.equal(Optional)
}

pub fn from_config_test() {
  let c = radio_group.default_config()
  let rg = radio_group.from_config(c)

  radio_group.render(rg, [], [])
  |> should.equal(radio_group.render(radio_group.new(), [], []))
}

pub fn render_config_test() {
  let c = radio_group.default_config()
  let expected = radio_group.render(radio_group.from_config(c), [], [])

  radio_group.render_config(c, [], [])
  |> should.equal(expected)
}

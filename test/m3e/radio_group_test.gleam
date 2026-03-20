import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/radio_group.{disabled, id, name, new, render, required}
import m3e/types.{Disabled, Enabled}

pub fn radio_group_creation_test() {
  let rg = new()
  let expected = element("m3e-radio-group", [], [])
  render(rg, [], []) |> should.equal(expected)
}

pub fn radio_group_setters_test() {
  let rg = new()

  let rg_disabled = rg |> disabled(Disabled)
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

  let rg_required = rg |> required(radio_group.Required)
  let expected_required =
    element("m3e-radio-group", [attribute("required", "")], [])
  render(rg_required, [], []) |> should.equal(expected_required)
}

pub fn radio_group_element_test() {
  let rg = new()
  let expected = element("m3e-radio-group", [], [text("Child")])
  render(rg, [], [text("Child")]) |> should.equal(expected)
}

pub fn config_test() {
  let c =
    radio_group.Config(
      interaction: Disabled,
      id: Some("config-id"),
      name: Some("config-name"),
      requirement: radio_group.Required,
    )

  let rg = radio_group.from_config(c)

  render(rg, [], [])
  |> should.equal(
    element(
      "m3e-radio-group",
      [
        attribute("disabled", ""),
        attribute("id", "config-id"),
        attribute("name", "config-name"),
        attribute("required", ""),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = radio_group.default_config()

  c.interaction |> should.equal(Enabled)
  c.id |> should.equal(None)
  c.name |> should.equal(None)
  c.requirement |> should.equal(radio_group.Optional)
}

pub fn from_config_test() {
  let c = radio_group.default_config()
  let rg = radio_group.from_config(c)

  render(rg, [], [])
  |> should.equal(render(new(), [], []))
}

pub fn render_config_test() {
  let c = radio_group.default_config()
  let expected = render(radio_group.from_config(c), [], [])

  radio_group.render_config(c, [], [])
  |> should.equal(expected)
}

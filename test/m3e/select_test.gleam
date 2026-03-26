import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/config.{Multi, Single}
import m3e/select
import m3e/state.{Disabled, Enabled, Optional, Required}

pub fn select_creation_test() {
  let s = select.new()
  let expected = element.element("m3e-select", [], [])
  select.render(s, [], []) |> should.equal(expected)
}

pub fn select_render_test() {
  let s = select.new()
  let expected =
    element.element("m3e-select", [attribute.attribute("class", "extra")], [
      element.text("Option"),
    ])
  select.render(s, [attribute.attribute("class", "extra")], [
    element.text("Option"),
  ])
  |> should.equal(expected)
}

pub fn select_setters_test() {
  let s =
    select.new()
    |> select.disabled(Disabled)
    |> select.hide_selection_indicator(select.Hidden)
    |> select.id(Some("my-id"))
    |> select.multi(Multi)
    |> select.name(Some("my-name"))
    |> select.required(Required)

  let expected =
    element.element(
      "m3e-select",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("hide-selection-indicator", ""),
        attribute.attribute("id", "my-id"),
        attribute.attribute("multi", ""),
        attribute.attribute("name", "my-name"),
        attribute.attribute("required", ""),
      ],
      [],
    )
  select.render(s, [], []) |> should.equal(expected)
}

pub fn config_test() {
  let c =
    select.Config(
      interaction: Disabled,
      indicator_visibility: select.Hidden,
      id: Some("config-id"),
      selection_mode: Multi,
      name: Some("config-name"),
      requirement: Required,
    )

  let s = select.from_config(c)

  select.render(s, [], [])
  |> should.equal(
    element.element(
      "m3e-select",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("hide-selection-indicator", ""),
        attribute.attribute("id", "config-id"),
        attribute.attribute("multi", ""),
        attribute.attribute("name", "config-name"),
        attribute.attribute("required", ""),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = select.default_config()

  c.interaction |> should.equal(Enabled)
  c.indicator_visibility |> should.equal(select.Visible)
  c.id |> should.equal(None)
  c.selection_mode |> should.equal(Single)
  c.name |> should.equal(None)
  c.requirement |> should.equal(Optional)
}

pub fn from_config_test() {
  let c = select.default_config()
  let s = select.from_config(c)

  select.render(s, [], [])
  |> should.equal(select.render(select.new(), [], []))
}

pub fn render_config_test() {
  let c = select.default_config()
  let expected = select.render(select.from_config(c), [], [])

  select.render_config(c, [], [])
  |> should.equal(expected)
}

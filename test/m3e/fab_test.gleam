import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/fab.{
  Config, Disabled, DisabledInteractive, Extended, Lowered, Tertiary,
  default_config, render_config,
}

import m3e/config
import m3e/form_submission.{Submit}

pub fn default_test() {
  fab.new()
  |> fab.render([], [])
  |> should.equal(
    element.element(
      "m3e-fab",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "primary-container"),
      ],
      [],
    ),
  )
}

pub fn extended_test() {
  fab.new()
  |> fab.extended(Extended)
  |> fab.extended_label(Some("Compose"))
  |> fab.render([], [element.text("icon")])
  |> should.equal(
    element.element(
      "m3e-fab",
      [
        attribute.attribute("extended", ""),
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "primary-container"),
      ],
      [
        element.element("span", [attribute.attribute("slot", "label")], [
          element.text("Compose"),
        ]),
        element.text("icon"),
      ],
    ),
  )
}

pub fn attributes_test() {
  fab.new()
  |> fab.disabled(Disabled)
  |> fab.form(Some(
    form_submission.new()
    |> form_submission.type_(Submit)
    |> form_submission.name("test-fab")
    |> form_submission.value("submitted"),
  ))
  |> fab.lowered(Lowered)
  |> fab.size(config.Small)
  |> fab.variant(fab.Tertiary)
  |> fab.render([], [])
  |> should.equal(
    element.element(
      "m3e-fab",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("lowered", ""),
        attribute.attribute("name", "test-fab"),
        attribute.attribute("size", "small"),
        attribute.attribute("type", "submit"),
        attribute.attribute("value", "submitted"),
        attribute.attribute("variant", "tertiary"),
      ],
      [],
    ),
  )
}

pub fn disabled_interactive_test() {
  fab.new()
  |> fab.disabled(DisabledInteractive)
  |> fab.render([], [])
  |> should.equal(
    element.element(
      "m3e-fab",
      [
        attribute.attribute("disabled-interactive", ""),
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "primary-container"),
      ],
      [],
    ),
  )
}

pub fn render_config_test() {
  let config =
    Config(
      ..default_config(),
      interaction: Disabled,
      extension: Extended,
      extended_label: Some("Config"),
      elevation: Lowered,
      variant: Tertiary,
    )
  let expected =
    element.element(
      "m3e-fab",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("extended", ""),
        attribute.attribute("lowered", ""),
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "tertiary"),
      ],
      [
        element.element("span", [attribute.attribute("slot", "label")], [
          element.text("Config"),
        ]),
      ],
    )

  render_config(config, [], [])
  |> should.equal(expected)
}

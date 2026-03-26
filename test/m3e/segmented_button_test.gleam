import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/config.{Multi, Single}
import m3e/segmented_button
import m3e/state.{Disabled, Enabled}

pub fn segmented_button_creation_test() {
  let s = segmented_button.new()
  let expected = element.element("m3e-segmented-button", [], [])
  segmented_button.render(s, [], []) |> should.equal(expected)
}

pub fn segmented_button_render_test() {
  let s = segmented_button.new()
  let expected =
    element.element(
      "m3e-segmented-button",
      [attribute.attribute("class", "extra")],
      [
        element.text("Child"),
      ],
    )
  segmented_button.render(s, [attribute.attribute("class", "extra")], [
    element.text("Child"),
  ])
  |> should.equal(expected)
}

pub fn segmented_button_setters_test() {
  let s =
    segmented_button.new()
    |> segmented_button.disabled(Disabled)
    |> segmented_button.hide_selection_indicator(segmented_button.Hidden)
    |> segmented_button.multi(Multi)
    |> segmented_button.name(Some("group"))

  let expected =
    element.element(
      "m3e-segmented-button",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("hide-selection-indicator", ""),
        attribute.attribute("multi", ""),
        attribute.attribute("name", "group"),
      ],
      [],
    )
  segmented_button.render(s, [], []) |> should.equal(expected)
}

pub fn config_test() {
  let c =
    segmented_button.Config(
      interaction: Disabled,
      indicator_visibility: segmented_button.Hidden,
      selection_mode: Multi,
      name: Some("config-group"),
    )

  let s = segmented_button.from_config(c)

  segmented_button.render(s, [], [])
  |> should.equal(
    element.element(
      "m3e-segmented-button",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("hide-selection-indicator", ""),
        attribute.attribute("multi", ""),
        attribute.attribute("name", "config-group"),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = segmented_button.default_config()

  c.interaction |> should.equal(Enabled)
  c.indicator_visibility |> should.equal(segmented_button.Visible)
  c.selection_mode |> should.equal(Single)
  c.name |> should.equal(None)
}

pub fn from_config_test() {
  let c = segmented_button.default_config()
  let s = segmented_button.from_config(c)

  segmented_button.render(s, [], [])
  |> should.equal(segmented_button.render(segmented_button.new(), [], []))
}

pub fn render_config_test() {
  let c = segmented_button.default_config()
  let expected =
    segmented_button.render(segmented_button.from_config(c), [], [])

  segmented_button.render_config(c, [], [])
  |> should.equal(expected)
}

import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/button_segment.{Config}
import m3e/state.{Disabled, Selected}

pub fn button_segment_creation_test() {
  let b = button_segment.new()
  let expected = element.element("m3e-button-segment", [], [])
  button_segment.render(b, [], []) |> should.equal(expected)
}

pub fn button_segment_render_test() {
  let b = button_segment.new()
  let expected =
    element.element(
      "m3e-button-segment",
      [attribute.attribute("class", "extra")],
      [element.text("Label")],
    )
  button_segment.render(b, [attribute.attribute("class", "extra")], [
    element.text("Label"),
  ])
  |> should.equal(expected)
}

pub fn button_segment_setters_test() {
  let b =
    button_segment.new()
    |> button_segment.checked(Selected)
    |> button_segment.disabled(Disabled)
    |> button_segment.value(Some("v"))

  let expected =
    element.element(
      "m3e-button-segment",
      [
        attribute.attribute("checked", ""),
        attribute.attribute("disabled", ""),
        attribute.attribute("value", "v"),
      ],
      [],
    )
  button_segment.render(b, [], []) |> should.equal(expected)
}

pub fn config_test() {
  let config = Config(checked: Selected, disabled: Disabled, value: Some("v"))

  let expected =
    element.element(
      "m3e-button-segment",
      [
        attribute.attribute("checked", ""),
        attribute.attribute("disabled", ""),
        attribute.attribute("value", "v"),
      ],
      [],
    )
  button_segment.render_config(config, [], []) |> should.equal(expected)
}

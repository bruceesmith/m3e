import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/button_segment.{
  Config, checked, disabled, new, render, render_config, value,
}
import m3e/state.{Disabled, Selected}

pub fn button_segment_creation_test() {
  let b = new()
  let expected = element.element("m3e-button-segment", [], [])
  render(b, [], []) |> should.equal(expected)
}

pub fn button_segment_render_test() {
  let b = new()
  let expected =
    element.element(
      "m3e-button-segment",
      [attribute.attribute("class", "extra")],
      [element.text("Label")],
    )
  render(b, [attribute.attribute("class", "extra")], [element.text("Label")])
  |> should.equal(expected)
}

pub fn button_segment_setters_test() {
  let b =
    new()
    |> checked(Selected)
    |> disabled(Disabled)
    |> value(Some("v"))

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
  render(b, [], []) |> should.equal(expected)
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
  render_config(config, [], []) |> should.equal(expected)
}

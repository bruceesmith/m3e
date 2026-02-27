import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/button_segment.{checked, disabled, new, render, value}

pub fn button_segment_creation_test() {
  let b = new()
  let expected = element("m3e-button-segment", [], [])
  render(b, [], []) |> should.equal(expected)
}

pub fn button_segment_render_test() {
  let b = new()
  let expected =
    element("m3e-button-segment", [attribute("class", "extra")], [text("Label")])
  render(b, [attribute("class", "extra")], [text("Label")])
  |> should.equal(expected)
}

pub fn button_segment_setters_test() {
  let b =
    new()
    |> checked(True)
    |> disabled(True)
    |> value(Some("v"))

  let expected =
    element(
      "m3e-button-segment",
      [
        attribute("checked", ""),
        attribute("disabled", ""),
        attribute("value", "v"),
      ],
      [],
    )
  render(b, [], []) |> should.equal(expected)
}

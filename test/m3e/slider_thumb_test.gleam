import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/slider_thumb

pub fn default_test() {
  slider_thumb.new()
  |> slider_thumb.render([])
  |> should.equal(element.element("m3e-slider-thumb", [], []))
}

pub fn disabled_test() {
  slider_thumb.new()
  |> slider_thumb.disabled(True)
  |> slider_thumb.render([])
  |> should.equal(
    element.element(
      "m3e-slider-thumb",
      [attribute.attribute("disabled", "")],
      [],
    ),
  )
}

pub fn name_test() {
  slider_thumb.new()
  |> slider_thumb.name(Some("test-name"))
  |> slider_thumb.render([])
  |> should.equal(
    element.element(
      "m3e-slider-thumb",
      [attribute.attribute("name", "test-name")],
      [],
    ),
  )
}

pub fn value_test() {
  slider_thumb.new()
  |> slider_thumb.value(Some(42.0))
  |> slider_thumb.render([])
  |> should.equal(
    element.element(
      "m3e-slider-thumb",
      [attribute.attribute("value", "42.0")],
      [],
    ),
  )
}

pub fn custom_attributes_test() {
  slider_thumb.new()
  |> slider_thumb.render([attribute.class("custom")])
  |> should.equal(
    element.element("m3e-slider-thumb", [attribute.class("custom")], []),
  )
}

pub fn combined_test() {
  slider_thumb.new()
  |> slider_thumb.disabled(True)
  |> slider_thumb.name(Some("vol"))
  |> slider_thumb.render([attribute.id("thumb-1")])
  |> should.equal(
    element.element(
      "m3e-slider-thumb",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("name", "vol"),
        attribute.id("thumb-1"),
      ],
      [],
    ),
  )
}

import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/slider_thumb
import m3e/state.{Disabled, Enabled}

pub fn default_test() {
  slider_thumb.new()
  |> slider_thumb.render([])
  |> should.equal(element.element("m3e-slider-thumb", [], []))
}

pub fn disabled_test() {
  slider_thumb.new()
  |> slider_thumb.disabled(Disabled)
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
  |> slider_thumb.disabled(Disabled)
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

pub fn config_test() {
  let c =
    slider_thumb.Config(
      disabled: Disabled,
      name: Some("config-name"),
      value: Some(10.5),
    )

  let s = slider_thumb.from_config(c)

  slider_thumb.render(s, [])
  |> should.equal(
    element.element(
      "m3e-slider-thumb",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("name", "config-name"),
        attribute.attribute("value", "10.5"),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = slider_thumb.default_config()

  c.disabled |> should.equal(Enabled)
  c.name |> should.equal(None)
  c.value |> should.equal(None)
}

pub fn from_config_test() {
  let c = slider_thumb.default_config()
  let s = slider_thumb.from_config(c)

  slider_thumb.render(s, [])
  |> should.equal(slider_thumb.render(slider_thumb.new(), []))
}

pub fn render_config_test() {
  let c = slider_thumb.default_config()
  let expected = slider_thumb.render(slider_thumb.from_config(c), [])

  slider_thumb.render_config(c, [])
  |> should.equal(expected)
}

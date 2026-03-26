import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/state.{Disabled, Enabled}
import m3e/tooltip.{Above, After, Before, Below}

const tip_text = "Hello, Tooltip!"

const for_id_text = "element-id"

pub fn tooltip_test() {
  let t =
    tooltip.new(tip_text, for_id_text)
    |> tooltip.position(Above)
    |> tooltip.hide_delay(100)
    |> tooltip.show_delay(200)
    |> tooltip.gestures(tooltip.On)

  let expected =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "on"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "above"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected)
}

pub fn tooltip_validation_test() {
  let t =
    tooltip.new(tip_text, for_id_text)
    |> tooltip.position(Below)
    |> tooltip.hide_delay(9999)
    |> tooltip.show_delay(9999)

  let expected =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "1500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "0"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected)

  let t_neg =
    tooltip.new(tip_text, for_id_text)
    |> tooltip.position(Below)
    |> tooltip.hide_delay(-1)
    |> tooltip.show_delay(-1)

  tooltip.render(t_neg, []) |> should.equal(expected)
}

pub fn element_test() {
  let t =
    tooltip.new(tip_text, for_id_text)
    |> tooltip.position(After)
    |> tooltip.hide_delay(100)
    |> tooltip.show_delay(200)
    |> tooltip.disabled(Disabled)
    |> tooltip.gestures(tooltip.Off)

  let expected =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("disabled", ""),
        attribute.attribute("touch-gestures", "off"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "after"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )

  tooltip.render(t, []) |> should.equal(expected)
}

pub fn defaults_test() {
  let expected =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "1500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "0"),
      ],
      [element.text(tip_text)],
    )

  tooltip.new(tip_text, for_id_text)
  |> tooltip.render([])
  |> should.equal(expected)
}

pub fn disabled_test() {
  let t =
    tooltip.new(tip_text, for_id_text)
    |> tooltip.hide_delay(100)
    |> tooltip.show_delay(200)

  let t = t |> tooltip.disabled(Disabled)
  let expected_true =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("disabled", ""),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_true)

  let t = t |> tooltip.disabled(Enabled)
  let expected_false =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_false)
}

pub fn gestures_test() {
  let t =
    tooltip.new(tip_text, for_id_text)
    |> tooltip.hide_delay(100)
    |> tooltip.show_delay(200)

  let t = t |> tooltip.gestures(tooltip.On)
  let expected_on =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "on"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_on)

  let t = t |> tooltip.gestures(tooltip.Off)
  let expected_off =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "off"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_off)

  let t = t |> tooltip.gestures(tooltip.Auto)
  let expected_auto =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_auto)
}

pub fn hide_delay_test() {
  let t =
    tooltip.new(tip_text, for_id_text)
    |> tooltip.hide_delay(100)
    |> tooltip.show_delay(200)

  let t = t |> tooltip.hide_delay(500)
  let expected_500 =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_500)

  let t = t |> tooltip.hide_delay(-1)
  let expected_default =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "1500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_default)

  let t = t |> tooltip.hide_delay(9999)
  tooltip.render(t, []) |> should.equal(expected_default)
}

pub fn position_test() {
  let t =
    tooltip.new(tip_text, for_id_text)
    |> tooltip.hide_delay(100)
    |> tooltip.show_delay(200)

  let t = t |> tooltip.position(Above)
  let expected_above =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "above"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_above)

  let t = t |> tooltip.position(After)
  let expected_after =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "after"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_after)

  let t = t |> tooltip.position(Before)
  let expected_before =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "before"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_before)

  let t = t |> tooltip.position(Below)
  let expected_below =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "200"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_below)
}

pub fn show_delay_test() {
  let t =
    tooltip.new(tip_text, for_id_text)
    |> tooltip.hide_delay(100)
    |> tooltip.show_delay(200)

  let t = t |> tooltip.show_delay(300)
  let expected_300 =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "300"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_300)

  let t = t |> tooltip.show_delay(-1)
  let expected_0 =
    element.element(
      "m3e-tooltip",
      [
        attribute.for(for_id_text),
        attribute.attribute("touch-gestures", "auto"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "0"),
      ],
      [element.text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_0)

  let t = t |> tooltip.show_delay(9999)
  tooltip.render(t, []) |> should.equal(expected_0)
}

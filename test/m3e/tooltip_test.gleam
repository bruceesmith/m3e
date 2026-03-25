import gleeunit/should
import lustre/attribute.{attribute, for}
import lustre/element.{element as lustre_element, text}

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
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "on"),
        attribute("hide-delay", "100"),
        attribute("position", "above"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
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
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "1500"),
        attribute("position", "below"),
        attribute("show-delay", "0"),
      ],
      [text(tip_text)],
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
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("disabled", ""),
        attribute("touch-gestures", "off"),
        attribute("hide-delay", "100"),
        attribute("position", "after"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
    )

  tooltip.render(t, []) |> should.equal(expected)
}

pub fn defaults_test() {
  let expected =
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "1500"),
        attribute("position", "below"),
        attribute("show-delay", "0"),
      ],
      [text(tip_text)],
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
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("disabled", ""),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "100"),
        attribute("position", "below"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_true)

  let t = t |> tooltip.disabled(Enabled)
  let expected_false =
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "100"),
        attribute("position", "below"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
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
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "on"),
        attribute("hide-delay", "100"),
        attribute("position", "below"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_on)

  let t = t |> tooltip.gestures(tooltip.Off)
  let expected_off =
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "off"),
        attribute("hide-delay", "100"),
        attribute("position", "below"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_off)

  let t = t |> tooltip.gestures(tooltip.Auto)
  let expected_auto =
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "100"),
        attribute("position", "below"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
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
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "500"),
        attribute("position", "below"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_500)

  let t = t |> tooltip.hide_delay(-1)
  let expected_default =
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "1500"),
        attribute("position", "below"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
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
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "100"),
        attribute("position", "above"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_above)

  let t = t |> tooltip.position(After)
  let expected_after =
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "100"),
        attribute("position", "after"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_after)

  let t = t |> tooltip.position(Before)
  let expected_before =
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "100"),
        attribute("position", "before"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_before)

  let t = t |> tooltip.position(Below)
  let expected_below =
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "100"),
        attribute("position", "below"),
        attribute("show-delay", "200"),
      ],
      [text(tip_text)],
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
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "100"),
        attribute("position", "below"),
        attribute("show-delay", "300"),
      ],
      [text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_300)

  let t = t |> tooltip.show_delay(-1)
  let expected_0 =
    lustre_element(
      "m3e-tooltip",
      [
        for(for_id_text),
        attribute("touch-gestures", "auto"),
        attribute("hide-delay", "100"),
        attribute("position", "below"),
        attribute("show-delay", "0"),
      ],
      [text(tip_text)],
    )
  tooltip.render(t, []) |> should.equal(expected_0)

  let t = t |> tooltip.show_delay(9999)
  tooltip.render(t, []) |> should.equal(expected_0)
}

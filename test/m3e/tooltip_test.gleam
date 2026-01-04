import gleeunit/should
import lustre/attribute.{attribute, for}
import lustre/element.{element as lustre_element, text}
import m3e/tooltip

const tip_text = "Hello, Tooltip!"

const for_id_text = "element-id"

pub fn tooltip_test() {
  let t =
    tooltip.tooltip(
      tip_text,
      for_id_text,
      tooltip.Above,
      100,
      200,
      False,
      tooltip.On,
    )

  t.tip |> should.equal(tip_text)
  t.for_id |> should.equal(for_id_text)
  t.position |> should.equal(tooltip.Above)
  t.hide_delay |> should.equal(100)
  t.show_delay |> should.equal(200)
  t.disabled |> should.be_false
  t.gestures |> should.equal(tooltip.On)
}

pub fn tooltip_validation_test() {
  let t =
    tooltip.tooltip(
      tip_text,
      for_id_text,
      tooltip.Below,
      9999,
      9999,
      False,
      tooltip.Auto,
    )

  t.hide_delay |> should.equal(tooltip.default_hide_delay)
  t.show_delay |> should.equal(tooltip.default_show_delay)

  let t_neg =
    tooltip.tooltip(
      tip_text,
      for_id_text,
      tooltip.Below,
      -1,
      -1,
      False,
      tooltip.Auto,
    )
  t_neg.hide_delay |> should.equal(tooltip.default_hide_delay)
  t_neg.show_delay |> should.equal(tooltip.default_show_delay)
}

pub fn element_test() {
  let t =
    tooltip.Tooltip(
      tip: tip_text,
      for_id: for_id_text,
      position: tooltip.After,
      hide_delay: 100,
      show_delay: 200,
      disabled: True,
      gestures: tooltip.Off,
    )

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

  tooltip.element(t) |> should.equal(expected)
}

pub fn basic_test() {
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

  tooltip.basic(tip_text, for_id_text) |> should.equal(expected)
}

pub fn disabled_test() {
  let t =
    tooltip.tooltip(
      tip_text,
      for_id_text,
      tooltip.Below,
      100,
      200,
      False,
      tooltip.Auto,
    )

  let t = t |> tooltip.disabled(True)
  t.disabled |> should.be_true
  let t = t |> tooltip.disabled(False)
  t.disabled |> should.be_false
}

pub fn gestures_test() {
  let t =
    tooltip.tooltip(
      tip_text,
      for_id_text,
      tooltip.Below,
      100,
      200,
      False,
      tooltip.Auto,
    )
  let t = t |> tooltip.gestures(tooltip.On)
  t.gestures |> should.equal(tooltip.On)
  let t = t |> tooltip.gestures(tooltip.Off)
  t.gestures |> should.equal(tooltip.Off)
  let t = t |> tooltip.gestures(tooltip.Auto)
  t.gestures |> should.equal(tooltip.Auto)
}

pub fn hide_delay_test() {
  let t =
    tooltip.tooltip(
      tip_text,
      for_id_text,
      tooltip.Below,
      100,
      200,
      False,
      tooltip.Auto,
    )
  let t = t |> tooltip.hide_delay(500)
  t.hide_delay |> should.equal(500)
  let t = t |> tooltip.hide_delay(-1)
  t.hide_delay |> should.equal(tooltip.default_hide_delay)
  let t = t |> tooltip.hide_delay(9999)
  t.hide_delay |> should.equal(tooltip.default_hide_delay)
}

pub fn position_test() {
  let t =
    tooltip.tooltip(
      tip_text,
      for_id_text,
      tooltip.Below,
      100,
      200,
      False,
      tooltip.Auto,
    )
  let t = t |> tooltip.position(tooltip.Above)
  t.position |> should.equal(tooltip.Above)
  let t = t |> tooltip.position(tooltip.After)
  t.position |> should.equal(tooltip.After)
  let t = t |> tooltip.position(tooltip.Before)
  t.position |> should.equal(tooltip.Before)
  let t = t |> tooltip.position(tooltip.Below)
  t.position |> should.equal(tooltip.Below)
}

pub fn show_delay_test() {
  let t =
    tooltip.tooltip(
      tip_text,
      for_id_text,
      tooltip.Below,
      100,
      200,
      False,
      tooltip.Auto,
    )
  let t = t |> tooltip.show_delay(300)
  t.show_delay |> should.equal(300)
  let t = t |> tooltip.show_delay(-1)
  t.show_delay |> should.equal(0)
  let t = t |> tooltip.show_delay(9999)
  t.show_delay |> should.equal(tooltip.default_show_delay)
}

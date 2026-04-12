import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/datepicker_toggle

pub fn datepicker_toggle_render_test() {
  let toggle = datepicker_toggle.new(None)
  let expected = element.element("m3e-datepicker-toggle", [], [])

  datepicker_toggle.render(toggle, [])
  |> should.equal(expected)
}

pub fn datepicker_toggle_for_test() {
  let toggle = datepicker_toggle.new(Some("my-datepicker"))
  let expected =
    element.element(
      "m3e-datepicker-toggle",
      [attribute.attribute("for", "my-datepicker")],
      [],
    )

  datepicker_toggle.render(toggle, [])
  |> should.equal(expected)
}

pub fn datepicker_toggle_attributes_test() {
  let toggle = datepicker_toggle.new(None)
  let expected =
    element.element(
      "m3e-datepicker-toggle",
      [attribute.class("custom-class")],
      [],
    )

  datepicker_toggle.render(toggle, [attribute.class("custom-class")])
  |> should.equal(expected)
}

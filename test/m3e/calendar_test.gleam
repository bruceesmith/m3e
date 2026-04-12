import gleam/option.{Some}
import gleam/result
import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/cal_date
import m3e/calendar
import m3e/datetime

pub fn default_config_test() {
  let config = calendar.default_config()
  // Config now contains a State
  let attrs = cal_date.attributes(config.state)
  attrs |> should.equal([])
}

pub fn new_test() {
  let cal = calendar.new()
  calendar.render(cal, [])
  |> should.equal(element.element("m3e-calendar", [], []))
}

pub fn from_config_test() {
  let date =
    datetime.from_string("2023-01-01")
    |> result.lazy_unwrap(fn() { panic as "Invalid date" })
  let state =
    cal_date.new()
    |> cal_date.date(Some(date))

  let config = calendar.Config(state: state)
  let cal = calendar.from_config(config)

  calendar.render(cal, [])
  |> should.equal(
    element.element(
      "m3e-calendar",
      [attribute.attribute("date", "2023-01-01")],
      [],
    ),
  )
}

pub fn state_setter_test() {
  let date =
    datetime.from_string("2023-01-01")
    |> result.lazy_unwrap(fn() { panic as "Invalid date" })
  let state =
    cal_date.new()
    |> cal_date.date(Some(date))

  let cal = calendar.new() |> calendar.state(state)

  calendar.render(cal, [])
  |> should.equal(
    element.element(
      "m3e-calendar",
      [attribute.attribute("date", "2023-01-01")],
      [],
    ),
  )
}

pub fn slot_header_test() {
  let header_slot = calendar.slot(calendar.Header)
  should.equal(header_slot, attribute.attribute("slot", "header"))
}

pub fn render_attributes_test() {
  let cal = calendar.new()
  calendar.render(cal, [attribute.class("custom")])
  |> should.equal(
    element.element("m3e-calendar", [attribute.class("custom")], []),
  )
}

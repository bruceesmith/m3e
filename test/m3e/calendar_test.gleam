import gleam/option.{None, Some}
import gleam/result
import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/calendar
import m3e/datetime

pub fn default_config_test() {
  let config = calendar.default_config()
  config.date |> should.equal(None)
  config.max_date |> should.equal(None)
  config.min_date |> should.equal(None)
  config.range_end |> should.equal(None)
  config.range_start |> should.equal(None)
  config.start_at |> should.equal(None)
  config.start_view |> should.equal(calendar.Month)
  config.previous_month_label
  |> should.equal(calendar.default_previous_month_label)
  config.next_month_label |> should.equal(calendar.default_next_month_label)
  config.previous_year_label
  |> should.equal(calendar.default_previous_year_label)
  config.next_year_label |> should.equal(calendar.default_next_year_label)
  config.previous_multi_year_label
  |> should.equal(calendar.default_previous_multi_year_label)
  config.next_multi_year_label
  |> should.equal(calendar.default_next_multi_year_label)
  config.special_dates |> should.equal(None)
  config.blackout_dates |> should.equal(None)
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

  let config = calendar.Config(..calendar.default_config(), date: Some(date))
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

pub fn setters_test() {
  let date =
    datetime.from_string("2023-01-01")
    |> result.lazy_unwrap(fn() { panic as "Invalid date" })
  let max_date =
    datetime.from_string("2023-12-31")
    |> result.lazy_unwrap(fn() { panic as "Invalid date" })

  calendar.new()
  |> calendar.date(Some(date))
  |> calendar.max_date(Some(max_date))
  |> calendar.min_date(Some(date))
  |> calendar.range_start(Some(date))
  |> calendar.range_end(Some(max_date))
  |> calendar.start_at(Some(date))
  |> calendar.start_view(calendar.Year)
  |> calendar.previous_month_label("Prev")
  |> calendar.next_month_label("Next")
  |> calendar.previous_year_label("Prev Year")
  |> calendar.next_year_label("Next Year")
  |> calendar.previous_multi_year_label("Prev 24")
  |> calendar.next_multi_year_label("Next 24")
  |> calendar.special_dates(Some("special"))
  |> calendar.blackout_dates(Some("blackout"))
  |> calendar.render([])
  |> should.equal(
    element.element(
      "m3e-calendar",
      [
        attribute.attribute("date", "2023-01-01"),
        attribute.attribute("min-date", "2023-01-01"),
        attribute.attribute("max-date", "2023-12-31"),
        attribute.attribute("range-end", "2023-12-31"),
        attribute.attribute("range-start", "2023-01-01"),
        attribute.attribute("start-at", "2023-01-01"),
        attribute.attribute("start-view", "year"),
        attribute.attribute("previous-month-label", "Prev"),
        attribute.attribute("next-month-label", "Next"),
        attribute.attribute("previous-year-label", "Prev Year"),
        attribute.attribute("next-year-label", "Next Year"),
        attribute.attribute("previous-multi-year-label", "Prev 24"),
        attribute.attribute("next-multi-year-label", "Next 24"),
        attribute.attribute("specialDates", "special"),
        attribute.attribute("blackoutDates", "blackout"),
      ],
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

pub fn render_config_test() {
  let config = calendar.default_config()
  calendar.render_config(config, [attribute.class("custom")])
  |> should.equal(
    element.element("m3e-calendar", [attribute.class("custom")], []),
  )
}

import gleam/option.{None, Some}
import gleam/result
import gleeunit/should
import lustre/attribute

import m3e/cal_date.{
  Config, Month, MultiYear, Year, attributes, default_config, from_config, new,
}
import m3e/datetime

pub fn default_config_test() {
  let config = default_config()
  config.date |> should.equal(None)
  config.start_view |> should.equal(Month)
  config.previous_month_label |> should.equal("Previous month")
}

pub fn new_test() {
  let state = new()
  // We can't inspect opaque types directly, but we can check the rendered attributes
  let attrs = attributes(state)
  attrs |> should.equal([])
}

pub fn from_config_test() {
  let date =
    datetime.from_string("2023-01-01")
    |> result.lazy_unwrap(fn() { panic as "Invalid date" })
  let config =
    Config(
      ..default_config(),
      date: Some(date),
      start_view: Year,
      previous_month_label: "Prev",
    )
  let state = from_config(config)
  let attrs = attributes(state)

  attrs
  |> should.equal([
    attribute.attribute("date", "2023-01-01"),
    attribute.attribute("start-view", "year"),
    attribute.attribute("previous-month-label", "Prev"),
  ])
}

pub fn setters_test() {
  let d1 =
    datetime.from_string("2023-01-01")
    |> result.lazy_unwrap(fn() { panic as "Invalid date" })
  let d2 =
    datetime.from_string("2023-12-31")
    |> result.lazy_unwrap(fn() { panic as "Invalid date" })

  let state =
    new()
    |> cal_date.date(Some(d1))
    |> cal_date.min_date(Some(d1))
    |> cal_date.max_date(Some(d2))
    |> cal_date.range_start(Some(d1))
    |> cal_date.range_end(Some(d2))
    |> cal_date.start_at(Some(d1))
    |> cal_date.start_view(MultiYear)
    |> cal_date.previous_month_label("PM")
    |> cal_date.next_month_label("NM")
    |> cal_date.previous_year_label("PY")
    |> cal_date.next_year_label("NY")
    |> cal_date.previous_multi_year_label("PMY")
    |> cal_date.next_multi_year_label("NMY")
    |> cal_date.special_dates(Some("special"))
    |> cal_date.blackout_dates(Some("blackout"))

  attributes(state)
  |> should.equal([
    attribute.attribute("date", "2023-01-01"),
    attribute.attribute("min-date", "2023-01-01"),
    attribute.attribute("max-date", "2023-12-31"),
    attribute.attribute("range-end", "2023-12-31"),
    attribute.attribute("range-start", "2023-01-01"),
    attribute.attribute("start-at", "2023-01-01"),
    attribute.attribute("start-view", "multi-year"),
    attribute.attribute("previous-month-label", "PM"),
    attribute.attribute("next-month-label", "NM"),
    attribute.attribute("previous-year-label", "PY"),
    attribute.attribute("next-year-label", "NY"),
    attribute.attribute("previous-multi-year-label", "PMY"),
    attribute.attribute("next-multi-year-label", "NMY"),
    attribute.attribute("specialDates", "special"),
    attribute.attribute("blackoutDates", "blackout"),
  ])
}

pub fn attributes_filtering_test() {
  // Check that default values and None are filtered out
  let state = new()
  attributes(state) |> should.equal([])

  let state_with_some =
    new()
    |> cal_date.start_view(Year)
    // Non-default label
    |> cal_date.previous_month_label("Custom")

  attributes(state_with_some)
  |> should.equal([
    attribute.attribute("start-view", "year"),
    attribute.attribute("previous-month-label", "Custom"),
  ])
}

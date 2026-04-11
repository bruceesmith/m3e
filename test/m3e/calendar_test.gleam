import gleam/option.{None, Some}

import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/calendar
import m3e/date
import m3e/datetime
import m3e/time

pub fn default_config_test() {
  let config = calendar.default_config()
  should.equal(config.date, None)
  should.equal(config.max_date, None)
  should.equal(config.min_date, None)
  should.equal(config.range_end, None)
  should.equal(config.range_start, None)
  should.equal(config.start_at, None)
  should.equal(config.start_view, calendar.Month)
  should.equal(
    config.previous_month_label,
    calendar.default_previous_month_label,
  )
  should.equal(config.next_month_label, calendar.default_next_month_label)
  should.equal(config.previous_year_label, calendar.default_previous_year_label)
  should.equal(config.next_year_label, calendar.default_next_year_label)
  should.equal(
    config.previous_multi_year_label,
    calendar.default_previous_multi_year_label,
  )
  should.equal(
    config.next_multi_year_label,
    calendar.default_next_multi_year_label,
  )
  should.equal(config.special_dates, None)
  should.equal(config.blackout_dates, None)
}

pub fn new_valid_test() {
  should.equal(calendar.new(), calendar.from_config(calendar.default_config()))
}

pub fn from_config_valid_test() {
  let config =
    calendar.Config(
      date: Some(datetime.new(
        date.from_string("2024-10-05") |> should.be_ok(),
        time.new(12, 30, 45) |> should.be_ok(),
        None,
      )),
      max_date: Some(datetime.new(
        date.from_string("2024-12-31") |> should.be_ok(),
        time.new(23, 59, 59) |> should.be_ok(),
        None,
      )),
      min_date: Some(datetime.new(
        date.from_string("2023-01-01") |> should.be_ok(),
        time.new(0, 0, 0) |> should.be_ok(),
        None,
      )),
      range_end: Some(datetime.new(
        date.from_string("2024-12-31") |> should.be_ok(),
        time.new(23, 59, 59) |> should.be_ok(),
        None,
      )),
      range_start: Some(datetime.new(
        date.from_string("2024-01-01") |> should.be_ok(),
        time.new(0, 0, 0) |> should.be_ok(),
        None,
      )),
      start_at: Some(datetime.new(
        date.from_string("2024-10-05") |> should.be_ok(),
        time.new(12, 30, 45) |> should.be_ok(),
        None,
      )),
      start_view: calendar.Month,
      previous_month_label: "Custom Previous Month",
      next_month_label: "Custom Next Month",
      previous_year_label: "Custom Previous Year",
      next_year_label: "Custom Next Year",
      previous_multi_year_label: "Custom Previous 24 Years",
      next_multi_year_label: "Custom Next 24 Years",
      special_dates: Some("2024-10-10"),
      blackout_dates: Some("2024-10-15"),
    )

  let cal = calendar.from_config(config)
  let expected =
    calendar.new()
    |> calendar.date(config.date)
    |> calendar.max_date(config.max_date)
    |> calendar.min_date(config.min_date)
    |> calendar.range_end(config.range_end)
    |> calendar.range_start(config.range_start)
    |> calendar.start_at(config.start_at)
    |> calendar.start_view(config.start_view)
    |> calendar.previous_month_label(config.previous_month_label)
    |> calendar.next_month_label(config.next_month_label)
    |> calendar.previous_year_label(config.previous_year_label)
    |> calendar.next_year_label(config.next_year_label)
    |> calendar.previous_multi_year_label(config.previous_multi_year_label)
    |> calendar.next_multi_year_label(config.next_multi_year_label)
    |> calendar.special_dates(config.special_dates)
    |> calendar.blackout_dates(config.blackout_dates)
  should.equal(cal, expected)
}

pub fn date_valid_test() {
  let date =
    Some(datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.new(12, 30, 45) |> should.be_ok(),
      None,
    ))
  let cal = calendar.new() |> calendar.date(date)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.date(date)
  should.equal(cal, expected)
}

pub fn max_date_valid_test() {
  let date =
    Some(datetime.new(
      date.from_string("2024-12-31") |> should.be_ok(),
      time.new(23, 59, 59) |> should.be_ok(),
      None,
    ))
  let cal = calendar.new() |> calendar.max_date(date)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.max_date(date)
  should.equal(cal, expected)
}

pub fn min_date_valid_test() {
  let date =
    Some(datetime.new(
      date.from_string("2023-01-01") |> should.be_ok(),
      time.new(0, 0, 0) |> should.be_ok(),
      None,
    ))
  let cal = calendar.new() |> calendar.min_date(date)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.min_date(date)
  should.equal(cal, expected)
}

pub fn range_end_valid_test() {
  let date =
    Some(datetime.new(
      date.from_string("2024-12-31") |> should.be_ok(),
      time.new(23, 59, 59) |> should.be_ok(),
      None,
    ))
  let cal = calendar.new() |> calendar.range_end(date)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.range_end(date)
  should.equal(cal, expected)
}

pub fn range_start_valid_test() {
  let date =
    Some(datetime.new(
      date.from_string("2024-01-01") |> should.be_ok(),
      time.new(0, 0, 0) |> should.be_ok(),
      None,
    ))
  let cal = calendar.new() |> calendar.range_start(date)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.range_start(date)
  should.equal(cal, expected)
}

pub fn start_at_valid_test() {
  let date =
    Some(datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.new(12, 30, 45) |> should.be_ok(),
      None,
    ))
  let cal = calendar.new() |> calendar.start_at(date)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.start_at(date)
  should.equal(cal, expected)
}

pub fn start_view_valid_test() {
  let cal = calendar.new() |> calendar.start_view(calendar.Year)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.start_view(calendar.Year)
  should.equal(cal, expected)
}

pub fn previous_month_label_valid_test() {
  let new_previous_month_label = "Custom Previous Month"
  let cal =
    calendar.new() |> calendar.previous_month_label(new_previous_month_label)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.previous_month_label(new_previous_month_label)
  should.equal(cal, expected)
}

pub fn next_month_label_valid_test() {
  let new_next_month_label = "Custom Next Month"
  let cal = calendar.new() |> calendar.next_month_label(new_next_month_label)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.next_month_label(new_next_month_label)
  should.equal(cal, expected)
}

pub fn previous_year_label_valid_test() {
  let new_previous_year_label = "Custom Previous Year"
  let cal =
    calendar.new() |> calendar.previous_year_label(new_previous_year_label)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.previous_year_label(new_previous_year_label)
  should.equal(cal, expected)
}

pub fn next_year_label_valid_test() {
  let new_next_year_label = "Custom Next Year"
  let cal = calendar.new() |> calendar.next_year_label(new_next_year_label)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.next_year_label(new_next_year_label)
  should.equal(cal, expected)
}

pub fn previous_multi_year_label_valid_test() {
  let new_previous_multi_year_label = "Custom Previous 24 Years"
  let cal =
    calendar.new()
    |> calendar.previous_multi_year_label(new_previous_multi_year_label)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.previous_multi_year_label(new_previous_multi_year_label)
  should.equal(cal, expected)
}

pub fn next_multi_year_label_valid_test() {
  let new_next_multi_year_label = "Custom Next 24 Years"
  let cal =
    calendar.new()
    |> calendar.next_multi_year_label(new_next_multi_year_label)
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.next_multi_year_label(new_next_multi_year_label)
  should.equal(cal, expected)
}

pub fn special_dates_valid_test() {
  let cal = calendar.new() |> calendar.special_dates(Some("special()"))
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.special_dates(Some("special()"))
  should.equal(cal, expected)
}

pub fn blackout_dates_valid_test() {
  let cal = calendar.new() |> calendar.blackout_dates(Some("blackout()"))
  let expected =
    calendar.from_config(calendar.default_config())
    |> calendar.blackout_dates(Some("blackout()"))
  should.equal(cal, expected)
}

pub fn render_valid_test() {
  let cal = calendar.render(calendar.new(), [])
  let elt = element.element("m3e-calendar", [], [])
  should.equal(cal, elt)
}

pub fn render_config_valid_test() {
  let cal = calendar.render(calendar.from_config(calendar.default_config()), [])
  let elt = element.element("m3e-calendar", [], [])
  should.equal(cal, elt)
}

pub fn slot_header_valid_test() {
  let header_slot = calendar.slot(calendar.Header)
  should.equal(header_slot, attribute.attribute("slot", "header"))
}

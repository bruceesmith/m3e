//// MonthView unit tests
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/date
import m3e/month_view.{Config}

pub fn month_view_default_config_test() {
  let cases = [
    Config(
      range_start: None,
      range_end: None,
      today: date.default,
      date: None,
      active_date: date.default,
      min_date: None,
      max_date: None,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    month_view.default_config()
    |> should.equal(expected)
  })
}

pub fn month_view_from_config_test() {
  let cases = [
    #(
      month_view.Config(
        range_start: Some(date.today_utc()),
        range_end: Some(date.today_utc()),
        today: date.today_utc(),
        date: Some(date.today_utc()),
        active_date: date.today_utc(),
        min_date: Some(date.today_utc()),
        max_date: Some(date.today_utc()),
      ),
      month_view.new()
        |> month_view.range_start(Some(date.today_utc()))
        |> month_view.range_end(Some(date.today_utc()))
        |> month_view.today(date.today_utc())
        |> month_view.date(Some(date.today_utc()))
        |> month_view.active_date(date.today_utc())
        |> month_view.min_date(Some(date.today_utc()))
        |> month_view.max_date(Some(date.today_utc())),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    month_view.from_config(config)
    |> should.equal(expected)
  })
}

pub fn month_view_new_test() {
  let cases = [
    month_view.from_config(month_view.Config(
      range_start: None,
      range_end: None,
      today: date.default,
      date: None,
      active_date: date.default,
      min_date: None,
      max_date: None,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    month_view.new()
    |> should.equal(expected)
  })
}

pub fn month_view_range_start_test() {
  let mod = month_view.new()
  let cases = [
    #(
      Some(date.today_utc()),
      month_view.from_config(
        month_view.Config(
          ..month_view.default_config(),
          range_start: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    month_view.range_start(mod, field)
    |> should.equal(expected)
  })
}

pub fn month_view_range_end_test() {
  let mod = month_view.new()
  let cases = [
    #(
      Some(date.today_utc()),
      month_view.from_config(
        month_view.Config(
          ..month_view.default_config(),
          range_end: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    month_view.range_end(mod, field)
    |> should.equal(expected)
  })
}

pub fn month_view_today_test() {
  let mod = month_view.new()
  let cases = [
    #(
      date.today_utc(),
      month_view.from_config(
        month_view.Config(
          ..month_view.default_config(),
          today: date.today_utc(),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    month_view.today(mod, field)
    |> should.equal(expected)
  })
}

pub fn month_view_date_test() {
  let mod = month_view.new()
  let cases = [
    #(
      Some(date.today_utc()),
      month_view.from_config(
        month_view.Config(
          ..month_view.default_config(),
          date: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    month_view.date(mod, field)
    |> should.equal(expected)
  })
}

pub fn month_view_active_date_test() {
  let mod = month_view.new()
  let cases = [
    #(
      date.today_utc(),
      month_view.from_config(
        month_view.Config(
          ..month_view.default_config(),
          active_date: date.today_utc(),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    month_view.active_date(mod, field)
    |> should.equal(expected)
  })
}

pub fn month_view_min_date_test() {
  let mod = month_view.new()
  let cases = [
    #(
      Some(date.today_utc()),
      month_view.from_config(
        month_view.Config(
          ..month_view.default_config(),
          min_date: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    month_view.min_date(mod, field)
    |> should.equal(expected)
  })
}

pub fn month_view_max_date_test() {
  let mod = month_view.new()
  let cases = [
    #(
      Some(date.today_utc()),
      month_view.from_config(
        month_view.Config(
          ..month_view.default_config(),
          max_date: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    month_view.max_date(mod, field)
    |> should.equal(expected)
  })
}

pub fn month_view_render_test() {
  let mod = month_view.new()

  let mod_range_start =
    month_view.new() |> month_view.range_start(Some(date.today_utc()))
  let mod_range_end =
    month_view.new() |> month_view.range_end(Some(date.today_utc()))
  let mod_today = month_view.new() |> month_view.today(date.today_utc())
  let mod_date = month_view.new() |> month_view.date(Some(date.today_utc()))
  let mod_active_date =
    month_view.new() |> month_view.active_date(date.today_utc())
  let mod_min_date =
    month_view.new() |> month_view.min_date(Some(date.today_utc()))
  let mod_max_date =
    month_view.new() |> month_view.max_date(Some(date.today_utc()))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-month-view", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-month-view", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-month-view", [], [html.br([])]),
    ),

    // Happy path with a range_start attribute
    #(
      #(mod_range_start, [], []),
      element.element(
        "m3e-month-view",
        [attribute.attribute("range-start", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a range_end attribute
    #(
      #(mod_range_end, [], []),
      element.element(
        "m3e-month-view",
        [attribute.attribute("range-end", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a today attribute
    #(
      #(mod_today, [], []),
      element.element(
        "m3e-month-view",
        [attribute.attribute("today", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a date attribute
    #(
      #(mod_date, [], []),
      element.element(
        "m3e-month-view",
        [attribute.attribute("date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a active_date attribute
    #(
      #(mod_active_date, [], []),
      element.element(
        "m3e-month-view",
        [attribute.attribute("active-date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a min_date attribute
    #(
      #(mod_min_date, [], []),
      element.element(
        "m3e-month-view",
        [attribute.attribute("min-date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a max_date attribute
    #(
      #(mod_max_date, [], []),
      element.element(
        "m3e-month-view",
        [attribute.attribute("max-date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    month_view.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

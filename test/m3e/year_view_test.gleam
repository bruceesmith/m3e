//// YearView unit tests
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
import m3e/year_view.{Config}

pub fn year_view_default_config_test() {
  let cases = [
    Config(
      today: date.default,
      date: None,
      active_date: date.default,
      min_date: None,
      max_date: None,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    year_view.default_config()
    |> should.equal(expected)
  })
}

pub fn year_view_from_config_test() {
  let cases = [
    #(
      year_view.Config(
        today: date.today_utc(),
        date: Some(date.today_utc()),
        active_date: date.today_utc(),
        min_date: Some(date.today_utc()),
        max_date: Some(date.today_utc()),
      ),
      year_view.new()
        |> year_view.today(date.today_utc())
        |> year_view.date(Some(date.today_utc()))
        |> year_view.active_date(date.today_utc())
        |> year_view.min_date(Some(date.today_utc()))
        |> year_view.max_date(Some(date.today_utc())),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    year_view.from_config(config)
    |> should.equal(expected)
  })
}

pub fn year_view_new_test() {
  let cases = [
    year_view.from_config(year_view.Config(
      today: date.default,
      date: None,
      active_date: date.default,
      min_date: None,
      max_date: None,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    year_view.new()
    |> should.equal(expected)
  })
}

pub fn year_view_today_test() {
  let mod = year_view.new()
  let cases = [
    #(
      date.today_utc(),
      year_view.from_config(
        year_view.Config(..year_view.default_config(), today: date.today_utc()),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    year_view.today(mod, field)
    |> should.equal(expected)
  })
}

pub fn year_view_date_test() {
  let mod = year_view.new()
  let cases = [
    #(
      Some(date.today_utc()),
      year_view.from_config(
        year_view.Config(
          ..year_view.default_config(),
          date: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    year_view.date(mod, field)
    |> should.equal(expected)
  })
}

pub fn year_view_active_date_test() {
  let mod = year_view.new()
  let cases = [
    #(
      date.today_utc(),
      year_view.from_config(
        year_view.Config(
          ..year_view.default_config(),
          active_date: date.today_utc(),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    year_view.active_date(mod, field)
    |> should.equal(expected)
  })
}

pub fn year_view_min_date_test() {
  let mod = year_view.new()
  let cases = [
    #(
      Some(date.today_utc()),
      year_view.from_config(
        year_view.Config(
          ..year_view.default_config(),
          min_date: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    year_view.min_date(mod, field)
    |> should.equal(expected)
  })
}

pub fn year_view_max_date_test() {
  let mod = year_view.new()
  let cases = [
    #(
      Some(date.today_utc()),
      year_view.from_config(
        year_view.Config(
          ..year_view.default_config(),
          max_date: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    year_view.max_date(mod, field)
    |> should.equal(expected)
  })
}

pub fn year_view_render_test() {
  let mod = year_view.new()

  let mod_today = year_view.new() |> year_view.today(date.today_utc())
  let mod_date = year_view.new() |> year_view.date(Some(date.today_utc()))
  let mod_active_date =
    year_view.new() |> year_view.active_date(date.today_utc())
  let mod_min_date =
    year_view.new() |> year_view.min_date(Some(date.today_utc()))
  let mod_max_date =
    year_view.new() |> year_view.max_date(Some(date.today_utc()))

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-year-view", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-year-view", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-year-view", [], [html.br([])]),
    ),

    // Happy path with a today attribute
    #(
      #(mod_today, [], []),
      element.element(
        "m3e-year-view",
        [attribute.attribute("today", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a date attribute
    #(
      #(mod_date, [], []),
      element.element(
        "m3e-year-view",
        [attribute.attribute("date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a active_date attribute
    #(
      #(mod_active_date, [], []),
      element.element(
        "m3e-year-view",
        [attribute.attribute("active-date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a min_date attribute
    #(
      #(mod_min_date, [], []),
      element.element(
        "m3e-year-view",
        [attribute.attribute("min-date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a max_date attribute
    #(
      #(mod_max_date, [], []),
      element.element(
        "m3e-year-view",
        [attribute.attribute("max-date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    year_view.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

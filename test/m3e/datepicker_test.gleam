//// Datepicker unit tests
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
import m3e/calendar_view
import m3e/date
import m3e/datepicker.{Config}
import m3e/datepicker_variant

pub fn datepicker_default_config_test() {
  let cases = [
    Config(
      variant: datepicker_variant.Docked,
      clearable: datepicker.IsNotClearable,
      date: None,
      max_date: None,
      min_date: None,
      range_end: None,
      range_start: None,
      start_at: None,
      start_view: calendar_view.Month,
      previous_month_label: "Previous month",
      next_month_label: "Next month",
      previous_year_label: "Previous year",
      next_year_label: "Next year",
      previous_multi_year_label: "Previous 24 years",
      next_multi_year_label: "Next 24 years",
      clear_label: "Clear",
      confirm_label: "OK",
      dismiss_label: "Cancel",
      label: "Select date",
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    datepicker.default_config()
    |> should.equal(expected)
  })
}

pub fn datepicker_from_config_test() {
  let cases = [
    #(
      datepicker.Config(
        variant: datepicker_variant.Modal,
        clearable: datepicker.IsClearable,
        date: Some(date.today_utc()),
        max_date: Some(date.today_utc()),
        min_date: Some(date.today_utc()),
        range_end: Some(date.today_utc()),
        range_start: Some(date.today_utc()),
        start_at: Some(date.today_utc()),
        start_view: calendar_view.Year,
        previous_month_label: "test",
        next_month_label: "test",
        previous_year_label: "test",
        next_year_label: "test",
        previous_multi_year_label: "test",
        next_multi_year_label: "test",
        clear_label: "test",
        confirm_label: "test",
        dismiss_label: "test",
        label: "test",
      ),
      datepicker.new()
        |> datepicker.variant(datepicker_variant.Modal)
        |> datepicker.clearable(datepicker.IsClearable)
        |> datepicker.date(Some(date.today_utc()))
        |> datepicker.max_date(Some(date.today_utc()))
        |> datepicker.min_date(Some(date.today_utc()))
        |> datepicker.range_end(Some(date.today_utc()))
        |> datepicker.range_start(Some(date.today_utc()))
        |> datepicker.start_at(Some(date.today_utc()))
        |> datepicker.start_view(calendar_view.Year)
        |> datepicker.previous_month_label("test")
        |> datepicker.next_month_label("test")
        |> datepicker.previous_year_label("test")
        |> datepicker.next_year_label("test")
        |> datepicker.previous_multi_year_label("test")
        |> datepicker.next_multi_year_label("test")
        |> datepicker.clear_label("test")
        |> datepicker.confirm_label("test")
        |> datepicker.dismiss_label("test")
        |> datepicker.label("test"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    datepicker.from_config(config)
    |> should.equal(expected)
  })
}

pub fn datepicker_new_test() {
  let cases = [
    datepicker.from_config(datepicker.Config(
      variant: datepicker_variant.Docked,
      clearable: datepicker.IsNotClearable,
      date: None,
      max_date: None,
      min_date: None,
      range_end: None,
      range_start: None,
      start_at: None,
      start_view: calendar_view.Month,
      previous_month_label: "Previous month",
      next_month_label: "Next month",
      previous_year_label: "Previous year",
      next_year_label: "Next year",
      previous_multi_year_label: "Previous 24 years",
      next_multi_year_label: "Next 24 years",
      clear_label: "Clear",
      confirm_label: "OK",
      dismiss_label: "Cancel",
      label: "Select date",
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    datepicker.new()
    |> should.equal(expected)
  })
}

pub fn datepicker_variant_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      datepicker_variant.Modal,
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          variant: datepicker_variant.Modal,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_clearable_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      datepicker.IsClearable,
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          clearable: datepicker.IsClearable,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.clearable(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_date_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      Some(date.today_utc()),
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          date: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.date(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_max_date_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      Some(date.today_utc()),
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          max_date: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.max_date(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_min_date_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      Some(date.today_utc()),
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          min_date: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.min_date(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_range_end_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      Some(date.today_utc()),
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          range_end: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.range_end(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_range_start_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      Some(date.today_utc()),
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          range_start: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.range_start(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_start_at_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      Some(date.today_utc()),
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          start_at: Some(date.today_utc()),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.start_at(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_start_view_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      calendar_view.Year,
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          start_view: calendar_view.Year,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.start_view(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_previous_month_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          previous_month_label: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.previous_month_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_next_month_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          next_month_label: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.next_month_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_previous_year_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          previous_year_label: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.previous_year_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_next_year_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          next_year_label: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.next_year_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_previous_multi_year_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          previous_multi_year_label: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.previous_multi_year_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_next_multi_year_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(
          ..datepicker.default_config(),
          next_multi_year_label: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.next_multi_year_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_clear_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(..datepicker.default_config(), clear_label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.clear_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_confirm_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(..datepicker.default_config(), confirm_label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.confirm_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_dismiss_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(..datepicker.default_config(), dismiss_label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.dismiss_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_label_test() {
  let mod = datepicker.new()
  let cases = [
    #(
      "test",
      datepicker.from_config(
        datepicker.Config(..datepicker.default_config(), label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    datepicker.label(mod, field)
    |> should.equal(expected)
  })
}

pub fn datepicker_render_test() {
  let mod = datepicker.new()

  let mod_variant =
    datepicker.new() |> datepicker.variant(datepicker_variant.Modal)
  let mod_clearable =
    datepicker.new() |> datepicker.clearable(datepicker.IsClearable)
  let mod_date = datepicker.new() |> datepicker.date(Some(date.today_utc()))
  let mod_max_date =
    datepicker.new() |> datepicker.max_date(Some(date.today_utc()))
  let mod_min_date =
    datepicker.new() |> datepicker.min_date(Some(date.today_utc()))
  let mod_range_end =
    datepicker.new() |> datepicker.range_end(Some(date.today_utc()))
  let mod_range_start =
    datepicker.new() |> datepicker.range_start(Some(date.today_utc()))
  let mod_start_at =
    datepicker.new() |> datepicker.start_at(Some(date.today_utc()))
  let mod_start_view =
    datepicker.new() |> datepicker.start_view(calendar_view.Year)
  let mod_previous_month_label =
    datepicker.new() |> datepicker.previous_month_label("test")
  let mod_next_month_label =
    datepicker.new() |> datepicker.next_month_label("test")
  let mod_previous_year_label =
    datepicker.new() |> datepicker.previous_year_label("test")
  let mod_next_year_label =
    datepicker.new() |> datepicker.next_year_label("test")
  let mod_previous_multi_year_label =
    datepicker.new() |> datepicker.previous_multi_year_label("test")
  let mod_next_multi_year_label =
    datepicker.new() |> datepicker.next_multi_year_label("test")
  let mod_clear_label = datepicker.new() |> datepicker.clear_label("test")
  let mod_confirm_label = datepicker.new() |> datepicker.confirm_label("test")
  let mod_dismiss_label = datepicker.new() |> datepicker.dismiss_label("test")
  let mod_label = datepicker.new() |> datepicker.label("test")

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-datepicker", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-datepicker", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-datepicker", [], [html.br([])]),
    ),

    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-datepicker",
        [
          attribute.attribute(
            "variant",
            datepicker_variant.to_string(datepicker_variant.Modal),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a clearable attribute
    #(
      #(mod_clearable, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("clearable", "")],
        [],
      ),
    ),
    // Happy path with a date attribute
    #(
      #(mod_date, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a max_date attribute
    #(
      #(mod_max_date, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("max-date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a min_date attribute
    #(
      #(mod_min_date, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("min-date", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a range_end attribute
    #(
      #(mod_range_end, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("range-end", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a range_start attribute
    #(
      #(mod_range_start, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("range-start", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a start_at attribute
    #(
      #(mod_start_at, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("start-at", date.to_string(date.today_utc()))],
        [],
      ),
    ),
    // Happy path with a start_view attribute
    #(
      #(mod_start_view, [], []),
      element.element(
        "m3e-datepicker",
        [
          attribute.attribute(
            "start-view",
            calendar_view.to_string(calendar_view.Year),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a previous_month_label attribute
    #(
      #(mod_previous_month_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("previous-month-label", "test")],
        [],
      ),
    ),
    // Happy path with a next_month_label attribute
    #(
      #(mod_next_month_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("next-month-label", "test")],
        [],
      ),
    ),
    // Happy path with a previous_year_label attribute
    #(
      #(mod_previous_year_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("previous-year-label", "test")],
        [],
      ),
    ),
    // Happy path with a next_year_label attribute
    #(
      #(mod_next_year_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("next-year-label", "test")],
        [],
      ),
    ),
    // Happy path with a previous_multi_year_label attribute
    #(
      #(mod_previous_multi_year_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("previous-multi-year-label", "test")],
        [],
      ),
    ),
    // Happy path with a next_multi_year_label attribute
    #(
      #(mod_next_multi_year_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("next-multi-year-label", "test")],
        [],
      ),
    ),
    // Happy path with a clear_label attribute
    #(
      #(mod_clear_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("clear-label", "test")],
        [],
      ),
    ),
    // Happy path with a confirm_label attribute
    #(
      #(mod_confirm_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("confirm-label", "test")],
        [],
      ),
    ),
    // Happy path with a dismiss_label attribute
    #(
      #(mod_dismiss_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("dismiss-label", "test")],
        [],
      ),
    ),
    // Happy path with a label attribute
    #(
      #(mod_label, [], []),
      element.element(
        "m3e-datepicker",
        [attribute.attribute("label", "test")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    datepicker.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

import gleam/dynamic/decode
import gleam/option.{Some}
import gleam/result

import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

import m3e/calendar
import m3e/calendar_view
import m3e/date

import components/calendar_effects
import layout
import model
import msg.{type Msg}
import package.{type Package, Package}
import view_helpers

fn calendar(model: model.Model) -> Element(Msg) {
  view_helpers.page([
    view_helpers.panel(model, "Date selection", date_selection),
    view_helpers.panel(model, "Start at", start_at),
    view_helpers.panel(model, "Start view", start_view),
    view_helpers.panel(model, "Date ranges", date_ranges),
    view_helpers.panel(model, "Min and max", min_max),
    view_helpers.panel(model, "Blackout dates", blackout),
  ])
}

fn date_selection(model: model.Model) -> Element(Msg) {
  let id = "calendar1"
  let the_date = date.from_string(model.date_str) |> result.unwrap(date.default)
  html.div([layout.flex_column()], [
    calendar.new()
      |> calendar.date(Some(the_date))
      |> calendar.render(
        [
          event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
          attribute.id(id),
        ],
        [],
      ),
    element.text("Selected date: "),
    element.text(model.date_str),
  ])
}

fn start_at(_: model.Model) -> Element(Msg) {
  let id = "calendar2"
  let the_date = date.from_string("2026-01-01") |> result.unwrap(date.default)
  html.div([layout.flex_column()], [
    calendar.new()
    |> calendar.start_at(Some(the_date))
    |> calendar.render(
      [
        event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
        attribute.id(id),
      ],
      [],
    ),
  ])
}

fn start_view(_: model.Model) -> Element(Msg) {
  let id = "calendar3"
  html.div([layout.flex_column()], [
    calendar.new()
    |> calendar.start_view(calendar_view.MultiYear)
    |> calendar.render(
      [
        event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
        attribute.id(id),
      ],
      [],
    ),
  ])
}

fn date_ranges(_: model.Model) -> Element(Msg) {
  let id = "calendar4"
  let range_start =
    date.from_string("2026-01-05") |> result.unwrap(date.default)
  let range_end = date.from_string("2026-01-15") |> result.unwrap(date.default)
  let start_at = date.from_string("2026-01-01") |> result.unwrap(date.default)
  html.div([layout.flex_column()], [
    calendar.new()
    |> calendar.range_start(Some(range_start))
    |> calendar.range_end(Some(range_end))
    |> calendar.start_at(Some(start_at))
    |> calendar.render(
      [
        event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
        attribute.id(id),
      ],
      [],
    ),
  ])
}

fn min_max(_: model.Model) -> Element(Msg) {
  let id = "calendar5"
  let min_date = date.from_string("2026-01-01") |> result.unwrap(date.default)
  let max_date = date.from_string("2026-04-30") |> result.unwrap(date.default)
  let start_at = date.from_string("2026-04-01") |> result.unwrap(date.default)
  html.div([layout.flex_column()], [
    calendar.new()
    |> calendar.min_date(Some(min_date))
    |> calendar.max_date(Some(max_date))
    |> calendar.start_at(Some(start_at))
    |> calendar.render(
      [
        event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
        attribute.id(id),
      ],
      [],
    ),
  ])
}

fn blackout(_: model.Model) -> Element(Msg) {
  let id = "calendar6"
  let _ = calendar_effects.is_blackout_date("2026-01-01")
  html.div([layout.flex_column()], [
    calendar.new()
    |> calendar.render(
      [
        attribute.id(id),
      ],
      [],
    ),
  ])
}

/// package() describes the calendar showcase in the standard Package record format
///
pub fn package() -> Package {
  Package(
    state: model.Calendar,
    label: "Calendar",
    view: calendar,
    msg: msg.CalendarSelected("#calendar6"),
  )
}

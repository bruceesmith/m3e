import gleam/dynamic/decode
import gleam/option.{None, Some}
import gleam/result

import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

import m3e/calendar
import m3e/card
import m3e/date
import m3e/datetime
import m3e/time

import components/calendar_effects
import layout
import model
import msg.{type Msg}
import package.{type Package, Package}

/// calendar displays all facets of the M3E Calendar wrapper component
///
fn calendar(model: model.Model) -> Element(Msg) {
  html.div(
    [
      layout.frame_style(),
    ],
    [
      card(model, "Date selection", date_selection),
      card(model, "Start at", start_at),
      card(model, "Start view", start_view),
      card(model, "Date ranges", date_ranges),
      card(model, "Min and max", min_max),
      card(model, "Blackout dates", blackout),
    ],
  )
}

fn card(
  model: model.Model,
  description: String,
  content: fn(model.Model) -> Element(Msg),
) -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Outlined),
    [
      layout.card_style(),
    ],
    [
      html.div(
        [
          layout.card_content_style(),
          card.slot(card.Content),
        ],
        [
          element.text(description),
          content(model),
        ],
      ),
    ],
  )
}

fn date_selection(model: model.Model) -> Element(Msg) {
  let id = "calendar1"
  let the_date = date.from_string(model.date_str) |> result.unwrap(date.zero())
  html.div([layout.calendar_style()], [
    calendar.new()
      |> calendar.date(Some(datetime.new(the_date, time.zero(), None)))
      |> calendar.render([
        event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
        attribute.id(id),
      ]),
    element.text("Selected date: "),
    element.text(model.date_str),
  ])
}

fn start_at(_: model.Model) -> Element(Msg) {
  let id = "calendar2"
  let the_date = date.from_string("2026-01-01") |> result.unwrap(date.zero())
  html.div([layout.calendar_style()], [
    calendar.new()
    |> calendar.start_at(Some(datetime.new(the_date, time.zero(), None)))
    |> calendar.render([
      event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
      attribute.id(id),
    ]),
  ])
}

fn start_view(_: model.Model) -> Element(Msg) {
  let id = "calendar3"
  html.div([layout.calendar_style()], [
    calendar.new()
    |> calendar.start_view(calendar.MultiYear)
    |> calendar.render([
      event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
      attribute.id(id),
    ]),
  ])
}

fn date_ranges(_: model.Model) -> Element(Msg) {
  let id = "calendar4"
  let range_start = date.from_string("2026-01-05") |> result.unwrap(date.zero())
  let range_end = date.from_string("2026-01-15") |> result.unwrap(date.zero())
  let start_at = date.from_string("2026-01-01") |> result.unwrap(date.zero())
  html.div([layout.calendar_style()], [
    calendar.new()
    |> calendar.range_start(Some(datetime.new(range_start, time.zero(), None)))
    |> calendar.range_end(Some(datetime.new(range_end, time.zero(), None)))
    |> calendar.start_at(Some(datetime.new(start_at, time.zero(), None)))
    |> calendar.render([
      event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
      attribute.id(id),
    ]),
  ])
}

fn min_max(_: model.Model) -> Element(Msg) {
  let id = "calendar5"
  let min_date = date.from_string("2026-01-01") |> result.unwrap(date.zero())
  let max_date = date.from_string("2026-04-30") |> result.unwrap(date.zero())
  let start_at = date.from_string("2026-04-01") |> result.unwrap(date.zero())
  html.div([layout.calendar_style()], [
    calendar.new()
    |> calendar.min_date(Some(datetime.new(min_date, time.zero(), None)))
    |> calendar.max_date(Some(datetime.new(max_date, time.zero(), None)))
    |> calendar.start_at(Some(datetime.new(start_at, time.zero(), None)))
    |> calendar.render([
      event.on("change", { decode.success(msg.CalendarDateSelected(id)) }),
      attribute.id(id),
    ]),
  ])
}

fn blackout(_: model.Model) -> Element(Msg) {
  let id = "calendar6"
  let _ = calendar_effects.is_blackout_date("2026-01-01")
  html.div([layout.calendar_style()], [
    calendar.new()
    |> calendar.render([
      attribute.id(id),
    ]),
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

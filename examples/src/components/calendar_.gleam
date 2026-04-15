import gleam/option.{None, Some}
import gleam/result

import lustre/element.{type Element}
import lustre/element/html

import m3e/calendar
import m3e/card
import m3e/date
import m3e/datetime
import m3e/time

import layout
import model
import msg.{type Msg}
import package.{type Package, Package}

/// calendar displays all facets of the M3E Calendar wrapper component
///
fn calendar() -> Element(Msg) {
  html.div(
    [
      layout.frame_style(),
    ],
    [
      basic(),
    ],
  )
}

fn basic() -> Element(Msg) {
  let the_date = date.new(2026, 4, 1) |> result.unwrap(date.zero())
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
          element.text("Date selection"),
          calendar.new()
            |> calendar.date(Some(datetime.new(the_date, time.zero(), None)))
            |> calendar.render([]),
        ],
      ),
    ],
  )
}

/// package() describes the calendar showcase in the standard Package record format
///
pub fn package() -> Package {
  Package(
    state: model.Calendar,
    label: "Calendar",
    view: calendar,
    msg: msg.CalendarSelected,
  )
}

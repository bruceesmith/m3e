//// MonthView is an internal component used to display a single month in a calendar.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/date.{type Date}

// --- Types ---

/// MonthView is a View Model for this component
///
/// ## Fields:
///
/// - range_start: Start of a date range.
/// - range_end: End of a date range.
/// - today: Today's date.
/// - date: The selected date.
/// - active_date: The active date.
/// - min_date: The minimum date that can be selected.
/// - max_date: The maximum date that can be selected.
///
pub opaque type MonthView {
  MonthView(
    range_start: Option(Date),
    range_end: Option(Date),
    today: Date,
    date: Option(Date),
    active_date: Date,
    min_date: Option(Date),
    max_date: Option(Date),
  )
}

// --- Defaults ---

pub const default_range_start: Option(Date) = None

pub const default_range_end: Option(Date) = None

pub const default_today: Date = date.default

pub const default_date: Option(Date) = None

pub const default_active_date: Date = date.default

pub const default_min_date: Option(Date) = None

pub const default_max_date: Option(Date) = None

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    range_start: Option(Date),
    range_end: Option(Date),
    today: Date,
    date: Option(Date),
    active_date: Date,
    min_date: Option(Date),
    max_date: Option(Date),
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    range_start: None,
    range_end: None,
    today: date.default,
    date: None,
    active_date: date.default,
    min_date: None,
    max_date: None,
  )
}

// --- Constructors ---

/// from_config creates a new MonthView from the given configuration.
///
pub fn from_config(config: Config) -> MonthView {
  MonthView(
    range_start: config.range_start,
    range_end: config.range_end,
    today: config.today,
    date: config.date,
    active_date: config.active_date,
    min_date: config.min_date,
    max_date: config.max_date,
  )
}

/// new creates a new MonthView with the default configuration.
///
pub fn new() -> MonthView {
  from_config(default_config())
}

// --- Setters ---

/// range_start sets the value of range_start for this MonthView.
///
pub fn range_start(record: MonthView, range_start: Option(Date)) -> MonthView {
  MonthView(..record, range_start: range_start)
}

/// range_end sets the value of range_end for this MonthView.
///
pub fn range_end(record: MonthView, range_end: Option(Date)) -> MonthView {
  MonthView(..record, range_end: range_end)
}

/// today sets the value of today for this MonthView.
///
pub fn today(record: MonthView, today: Date) -> MonthView {
  MonthView(..record, today: today)
}

/// date sets the value of date for this MonthView.
///
pub fn date(record: MonthView, date: Option(Date)) -> MonthView {
  MonthView(..record, date: date)
}

/// active_date sets the value of active_date for this MonthView.
///
pub fn active_date(record: MonthView, active_date: Date) -> MonthView {
  MonthView(..record, active_date: active_date)
}

/// min_date sets the value of min_date for this MonthView.
///
pub fn min_date(record: MonthView, min_date: Option(Date)) -> MonthView {
  MonthView(..record, min_date: min_date)
}

/// max_date sets the value of max_date for this MonthView.
///
pub fn max_date(record: MonthView, max_date: Option(Date)) -> MonthView {
  MonthView(..record, max_date: max_date)
}

// --- Renderers ---

/// render creates a Lustre Element for a MonthView
///
pub fn render(
  model: MonthView,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-month-view",
    list.flatten([
      [
        attr.option(
          model.range_start,
          fn(_) { "range-start" },
          date.to_string,
          default_range_start,
        ),
        attr.option(
          model.range_end,
          fn(_) { "range-end" },
          date.to_string,
          default_range_end,
        ),
        attr.with_default(
          "today",
          date.to_string(model.today),
          date.to_string(default_today),
        ),
        attr.option(model.date, fn(_) { "date" }, date.to_string, default_date),
        attr.with_default(
          "active-date",
          date.to_string(model.active_date),
          date.to_string(default_active_date),
        ),
        attr.option(
          model.min_date,
          fn(_) { "min-date" },
          date.to_string,
          default_min_date,
        ),
        attr.option(
          model.max_date,
          fn(_) { "max-date" },
          date.to_string,
          default_max_date,
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a MonthView Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

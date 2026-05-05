//// MultiYearView is an internal component used to display a year selector in a calendar.
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

/// MultiYearView is a View Model for this component
///
/// ## Fields:
///
/// - today: Today's date.
/// - date: The selected date.
/// - active_date: The active date.
/// - min_date: The minimum date that can be selected.
/// - max_date: The maximum date that can be selected.
///
pub opaque type MultiYearView {
  MultiYearView(
    today: Date,
    date: Option(Date),
    active_date: Date,
    min_date: Option(Date),
    max_date: Option(Date),
  )
}

// --- Defaults ---

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
    today: date.default,
    date: None,
    active_date: date.default,
    min_date: None,
    max_date: None,
  )
}

// --- Constructors ---

/// from_config creates a new MultiYearView from the given configuration.
///
pub fn from_config(config: Config) -> MultiYearView {
  MultiYearView(
    today: config.today,
    date: config.date,
    active_date: config.active_date,
    min_date: config.min_date,
    max_date: config.max_date,
  )
}

/// new creates a new MultiYearView with the default configuration.
///
pub fn new() -> MultiYearView {
  from_config(default_config())
}

// --- Setters ---

/// today sets the value of today for this MultiYearView.
///
pub fn today(record: MultiYearView, today: Date) -> MultiYearView {
  MultiYearView(..record, today: today)
}

/// date sets the value of date for this MultiYearView.
///
pub fn date(record: MultiYearView, date: Option(Date)) -> MultiYearView {
  MultiYearView(..record, date: date)
}

/// active_date sets the value of active_date for this MultiYearView.
///
pub fn active_date(record: MultiYearView, active_date: Date) -> MultiYearView {
  MultiYearView(..record, active_date: active_date)
}

/// min_date sets the value of min_date for this MultiYearView.
///
pub fn min_date(record: MultiYearView, min_date: Option(Date)) -> MultiYearView {
  MultiYearView(..record, min_date: min_date)
}

/// max_date sets the value of max_date for this MultiYearView.
///
pub fn max_date(record: MultiYearView, max_date: Option(Date)) -> MultiYearView {
  MultiYearView(..record, max_date: max_date)
}

// --- Renderers ---

/// render creates a Lustre Element for a MultiYearView
///
pub fn render(
  model: MultiYearView,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-multi-year-view",
    list.flatten([
      [
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

/// render_config creates a Lustre Element from a MultiYearView Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

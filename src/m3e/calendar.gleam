//// Calendar is a calendar used to select a date.
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
import m3e/calendar_view.{type CalendarView}
import m3e/date.{type Date}

// --- Types ---

/// Calendar is a View Model for this component
///
/// ## Fields:
///
/// - date: The selected date.
/// - max_date: The maximum date that can be selected.
/// - min_date: The minimum date that can be selected.
/// - range_end: End of a date range.
/// - range_start: Start of a date range.
/// - start_at: A date specifying the period (month or year) to start the calendar in.
/// - start_view: The initial view used to select a date.
/// - previous_month_label: The accessible label given to the button used to move to the previous month.
/// - next_month_label: The accessible label given to the button used to move to the next month.
/// - previous_year_label: The accessible label given to the button used to move to the previous year.
/// - next_year_label: The accessible label given to the button used to move to the next year.
/// - previous_multi_year_label: The accessible label given to the button used to move to the previous 24 years.
/// - next_multi_year_label: The accessible label given to the button used to move to the next 24 years.
///
pub opaque type Calendar {
  Calendar(
    date: Option(Date),
    max_date: Option(Date),
    min_date: Option(Date),
    range_end: Option(Date),
    range_start: Option(Date),
    start_at: Option(Date),
    start_view: CalendarView,
    previous_month_label: String,
    next_month_label: String,
    previous_year_label: String,
    next_year_label: String,
    previous_multi_year_label: String,
    next_multi_year_label: String,
  )
}

// --- Defaults ---

pub const default_date: Option(Date) = None

pub const default_max_date: Option(Date) = None

pub const default_min_date: Option(Date) = None

pub const default_range_end: Option(Date) = None

pub const default_range_start: Option(Date) = None

pub const default_start_at: Option(Date) = None

pub const default_start_view: CalendarView = calendar_view.Month

pub const default_previous_month_label: String = "Previous month"

pub const default_next_month_label: String = "Next month"

pub const default_previous_year_label: String = "Previous year"

pub const default_next_year_label: String = "Next year"

pub const default_previous_multi_year_label: String = "Previous 24 years"

pub const default_next_multi_year_label: String = "Next 24 years"

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Header
  // Renders the header of the calendar.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    date: Option(Date),
    max_date: Option(Date),
    min_date: Option(Date),
    range_end: Option(Date),
    range_start: Option(Date),
    start_at: Option(Date),
    start_view: CalendarView,
    previous_month_label: String,
    next_month_label: String,
    previous_year_label: String,
    next_year_label: String,
    previous_multi_year_label: String,
    next_multi_year_label: String,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
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
  )
}

// --- Constructors ---

/// from_config creates a new Calendar from the given configuration.
///
pub fn from_config(config: Config) -> Calendar {
  Calendar(
    date: config.date,
    max_date: config.max_date,
    min_date: config.min_date,
    range_end: config.range_end,
    range_start: config.range_start,
    start_at: config.start_at,
    start_view: config.start_view,
    previous_month_label: config.previous_month_label,
    next_month_label: config.next_month_label,
    previous_year_label: config.previous_year_label,
    next_year_label: config.next_year_label,
    previous_multi_year_label: config.previous_multi_year_label,
    next_multi_year_label: config.next_multi_year_label,
  )
}

/// new creates a new Calendar with the default configuration.
///
pub fn new() -> Calendar {
  from_config(default_config())
}

// --- Setters ---

/// date sets the value of date for this Calendar.
///
pub fn date(record: Calendar, date: Option(Date)) -> Calendar {
  Calendar(..record, date: date)
}

/// max_date sets the value of max_date for this Calendar.
///
pub fn max_date(record: Calendar, max_date: Option(Date)) -> Calendar {
  Calendar(..record, max_date: max_date)
}

/// min_date sets the value of min_date for this Calendar.
///
pub fn min_date(record: Calendar, min_date: Option(Date)) -> Calendar {
  Calendar(..record, min_date: min_date)
}

/// range_end sets the value of range_end for this Calendar.
///
pub fn range_end(record: Calendar, range_end: Option(Date)) -> Calendar {
  Calendar(..record, range_end: range_end)
}

/// range_start sets the value of range_start for this Calendar.
///
pub fn range_start(record: Calendar, range_start: Option(Date)) -> Calendar {
  Calendar(..record, range_start: range_start)
}

/// start_at sets the value of start_at for this Calendar.
///
pub fn start_at(record: Calendar, start_at: Option(Date)) -> Calendar {
  Calendar(..record, start_at: start_at)
}

/// start_view sets the value of start_view for this Calendar.
///
pub fn start_view(record: Calendar, start_view: CalendarView) -> Calendar {
  Calendar(..record, start_view: start_view)
}

/// previous_month_label sets the value of previous_month_label for this Calendar.
///
pub fn previous_month_label(
  record: Calendar,
  previous_month_label: String,
) -> Calendar {
  Calendar(..record, previous_month_label: previous_month_label)
}

/// next_month_label sets the value of next_month_label for this Calendar.
///
pub fn next_month_label(record: Calendar, next_month_label: String) -> Calendar {
  Calendar(..record, next_month_label: next_month_label)
}

/// previous_year_label sets the value of previous_year_label for this Calendar.
///
pub fn previous_year_label(
  record: Calendar,
  previous_year_label: String,
) -> Calendar {
  Calendar(..record, previous_year_label: previous_year_label)
}

/// next_year_label sets the value of next_year_label for this Calendar.
///
pub fn next_year_label(record: Calendar, next_year_label: String) -> Calendar {
  Calendar(..record, next_year_label: next_year_label)
}

/// previous_multi_year_label sets the value of previous_multi_year_label for this Calendar.
///
pub fn previous_multi_year_label(
  record: Calendar,
  previous_multi_year_label: String,
) -> Calendar {
  Calendar(..record, previous_multi_year_label: previous_multi_year_label)
}

/// next_multi_year_label sets the value of next_multi_year_label for this Calendar.
///
pub fn next_multi_year_label(
  record: Calendar,
  next_multi_year_label: String,
) -> Calendar {
  Calendar(..record, next_multi_year_label: next_multi_year_label)
}

// --- Renderers ---

/// render creates a Lustre Element for a Calendar
///
pub fn render(
  model: Calendar,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-calendar",
    list.flatten([
      [
        attr.option(model.date, fn(_) { "date" }, date.to_string, default_date),
        attr.option(
          model.max_date,
          fn(_) { "max-date" },
          date.to_string,
          default_max_date,
        ),
        attr.option(
          model.min_date,
          fn(_) { "min-date" },
          date.to_string,
          default_min_date,
        ),
        attr.option(
          model.range_end,
          fn(_) { "range-end" },
          date.to_string,
          default_range_end,
        ),
        attr.option(
          model.range_start,
          fn(_) { "range-start" },
          date.to_string,
          default_range_start,
        ),
        attr.option(
          model.start_at,
          fn(_) { "start-at" },
          date.to_string,
          default_start_at,
        ),
        attr.with_default(
          "start-view",
          calendar_view.to_string(model.start_view),
          calendar_view.to_string(default_start_view),
        ),
        attr.with_default(
          "previous-month-label",
          model.previous_month_label,
          default_previous_month_label,
        ),
        attr.with_default(
          "next-month-label",
          model.next_month_label,
          default_next_month_label,
        ),
        attr.with_default(
          "previous-year-label",
          model.previous_year_label,
          default_previous_year_label,
        ),
        attr.with_default(
          "next-year-label",
          model.next_year_label,
          default_next_year_label,
        ),
        attr.with_default(
          "previous-multi-year-label",
          model.previous_multi_year_label,
          default_previous_multi_year_label,
        ),
        attr.with_default(
          "next-multi-year-label",
          model.next_multi_year_label,
          default_next_multi_year_label,
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Calendar Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Header -> attribute.attribute("slot", "header")
  }
}

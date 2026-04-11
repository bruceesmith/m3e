////// calendar provides Lustre support for the [M3E Calendar component](https:///matraic.github.io/m3e/#/components/calendar.html)
//// View is the view used to select a date
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/datetime.{type DateTime}
import m3e/helpers

// --- Types ---

/// Calendar provides structured navigation and selection across month, year, and multi_year views
///
/// ##Fields:
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
    date: Option(DateTime),
    max_date: Option(DateTime),
    min_date: Option(DateTime),
    range_end: Option(DateTime),
    range_start: Option(DateTime),
    start_at: Option(DateTime),
    start_view: View,
    previous_month_label: String,
    next_month_label: String,
    previous_year_label: String,
    next_year_label: String,
    previous_multi_year_label: String,
    next_multi_year_label: String,
    special_dates: Option(String),
    blackout_dates: Option(String),
  )
}

pub const default_previous_month_label = "Previous month"

pub const default_next_month_label = "Next month"

pub const default_previous_year_label = "Previous month"

pub const default_next_year_label = "Previous year"

pub const default_previous_multi_year_label = "Previous 24 years"

pub const default_next_multi_year_label = "Next 24 years"

/// Slot gives type-safe names to each of the defined HTML named slots
///
pub type Slot {
  Header
  // Renders the header of the calendar
}

/// View is the possible views of a calendar
///
pub type View {
  Month
  MultiYear
  Year
}

pub const default_view = Month

// --- CONFIGURATION ---

/// Config allows for a declarative configuration of the Calendar
///
pub type Config {
  Config(
    date: Option(DateTime),
    max_date: Option(DateTime),
    min_date: Option(DateTime),
    range_end: Option(DateTime),
    range_start: Option(DateTime),
    start_at: Option(DateTime),
    start_view: View,
    previous_month_label: String,
    next_month_label: String,
    previous_year_label: String,
    next_year_label: String,
    previous_multi_year_label: String,
    next_multi_year_label: String,
    special_dates: Option(String),
    blackout_dates: Option(String),
  )
}

/// Default config
///
pub fn default_config() -> Config {
  Config(
    date: None,
    max_date: None,
    min_date: None,
    range_end: None,
    range_start: None,
    start_at: None,
    start_view: default_view,
    previous_month_label: default_previous_month_label,
    next_month_label: default_next_month_label,
    previous_year_label: default_previous_year_label,
    next_year_label: default_next_year_label,
    previous_multi_year_label: default_previous_multi_year_label,
    next_multi_year_label: default_next_multi_year_label,
    special_dates: None,
    blackout_dates: None,
  )
}

// --- CONSTRUCTORS ---

/// from_config creates a Calendar from a Config
///
pub fn from_config(c: Config) -> Calendar {
  Calendar(
    date: c.date,
    max_date: c.max_date,
    min_date: c.min_date,
    range_end: c.range_end,
    range_start: c.range_start,
    start_at: c.start_at,
    start_view: c.start_view,
    previous_month_label: c.previous_month_label,
    next_month_label: c.next_month_label,
    previous_year_label: c.previous_year_label,
    next_year_label: c.next_year_label,
    previous_multi_year_label: c.previous_multi_year_label,
    next_multi_year_label: c.next_multi_year_label,
    special_dates: c.special_dates,
    blackout_dates: c.blackout_dates,
  )
}

/// new creates a new Calendar
///
pub fn new() -> Calendar {
  from_config(default_config())
}

// --- SETTERS ---

/// date sets the `date` field
///
pub fn date(c: Calendar, date: Option(DateTime)) -> Calendar {
  Calendar(..c, date: date)
}

/// max_date sets the `max_date` field
///
pub fn max_date(c: Calendar, max_date: Option(DateTime)) -> Calendar {
  Calendar(..c, max_date: max_date)
}

/// min_date sets the `min_date` field
///
pub fn min_date(c: Calendar, min_date: Option(DateTime)) -> Calendar {
  Calendar(..c, min_date: min_date)
}

/// range_end sets the `range_end` field
///
pub fn range_end(c: Calendar, range_end: Option(DateTime)) -> Calendar {
  Calendar(..c, range_end: range_end)
}

/// range_start sets the `range_start` field
///
pub fn range_start(c: Calendar, range_start: Option(DateTime)) -> Calendar {
  Calendar(..c, range_start: range_start)
}

/// start_at sets the `start_at` field
///
pub fn start_at(c: Calendar, start_at: Option(DateTime)) -> Calendar {
  Calendar(..c, start_at: start_at)
}

/// start_view sets the `start_view` field
///
pub fn start_view(c: Calendar, start_view: View) -> Calendar {
  Calendar(..c, start_view: start_view)
}

/// previous_month_label sets the `previous_month_label` field
///
pub fn previous_month_label(c: Calendar, previous_month_label: String) {
  Calendar(..c, previous_month_label: previous_month_label)
}

/// next_month_label sets the `next_month_label` field
///
pub fn next_month_label(c: Calendar, next_month_label: String) {
  Calendar(..c, next_month_label: next_month_label)
}

/// previous_year_label sets the `previous_year_label` field
///
pub fn previous_year_label(c: Calendar, previous_year_label: String) {
  Calendar(..c, previous_year_label: previous_year_label)
}

/// next_year_label sets the `next_year_label` field
///
pub fn next_year_label(c: Calendar, next_year_label: String) {
  Calendar(..c, next_year_label: next_year_label)
}

/// previous_multi_year_label sets the `previous_multi_year_label` field
///
pub fn previous_multi_year_label(c: Calendar, previous_multi_year_label: String) {
  Calendar(..c, previous_multi_year_label: previous_multi_year_label)
}

/// next_multi_year_label sets the `next_multi_year_label` field
///
pub fn next_multi_year_label(c: Calendar, next_multi_year_label: String) {
  Calendar(..c, next_multi_year_label: next_multi_year_label)
}

/// special_dates sets the `special_dates` field
///
pub fn special_dates(c: Calendar, special_dates: Option(String)) -> Calendar {
  Calendar(..c, special_dates: special_dates)
}

/// blackout_dates sets the `blackout_dates` field
///
pub fn blackout_dates(c: Calendar, blackout_dates: Option(String)) -> Calendar {
  Calendar(..c, blackout_dates: blackout_dates)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Calendar
///
pub fn render(c: Calendar, attributes: List(Attribute(msg))) -> Element(msg) {
  element.element(
    "m3e-calendar",
    list.flatten([
      [
        helpers.option_attribute(
          c.date,
          fn(_) { "date" },
          datetime.to_string,
          None,
        ),
        helpers.option_attribute(
          c.min_date,
          fn(_) { "min-date" },
          datetime.to_string,
          None,
        ),
        helpers.option_attribute(
          c.max_date,
          fn(_) { "max-date" },
          datetime.to_string,
          None,
        ),
        helpers.option_attribute(
          c.range_end,
          fn(_) { "range-end" },
          datetime.to_string,
          None,
        ),
        helpers.option_attribute(
          c.range_start,
          fn(_) { "range-start" },
          datetime.to_string,
          None,
        ),
        helpers.option_attribute(
          c.start_at,
          fn(_) { "start-at" },
          datetime.to_string,
          None,
        ),
        helpers.attribute_with_default(
          "start-view",
          view_to_string(c.start_view),
          view_to_string(default_view),
        ),
        helpers.attribute_with_default(
          "previous-month-label",
          c.previous_month_label,
          default_previous_month_label,
        ),
        helpers.attribute_with_default(
          "next-month-label",
          c.next_month_label,
          default_next_month_label,
        ),
        helpers.attribute_with_default(
          "previous-year-label",
          c.previous_year_label,
          default_previous_year_label,
        ),
        helpers.attribute_with_default(
          "next-year-label",
          c.next_year_label,
          default_next_year_label,
        ),
        helpers.attribute_with_default(
          "previous-multi-year-label",
          c.previous_multi_year_label,
          default_previous_multi_year_label,
        ),
        helpers.attribute_with_default(
          "next-multi-year-label",
          c.next_multi_year_label,
          default_next_multi_year_label,
        ),
        helpers.option_attribute(
          c.special_dates,
          fn(_) { "specialDates" },
          function.identity,
          None,
        ),
        helpers.option_attribute(
          c.blackout_dates,
          fn(_) { "blackoutDates" },
          function.identity,
          None,
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    [],
  )
}

/// render_config creates a Lustre Element(msg) from a Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  render(from_config(c), attributes)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Header -> attribute.attribute("slot", "header")
  }
}

// --- PRIVATE HELPER FUNCTIONS ---

fn view_to_string(v: View) -> String {
  case v {
    Month -> "month"
    MultiYear -> "multi-year"
    Year -> "year"
  }
}

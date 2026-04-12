//// cal_date provides definitions and functions shared between State and Datepicker components.
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}

import m3e/datetime.{type DateTime}
import m3e/helpers

// --- Types ---

/// State is a record representing the state of a State or datepicker component.
///
/// ##Fields:
/// - date: The selected date.
/// - max_date: The maximum date that can be selected.
/// - min_date: The minimum date that can be selected.
/// - range_end: End of a date range.
/// - range_start: Start of a date range.
/// - start_at: A date specifying the period (month or year) to start the State in.
/// - start_view: The initial view used to select a date.
/// - previous_month_label: The accessible label given to the button used to move to the previous month.
/// - next_month_label: The accessible label given to the button used to move to the next month.
/// - previous_year_label: The accessible label given to the button used to move to the previous year.
/// - next_year_label: The accessible label given to the button used to move to the next year.
/// - previous_multi_year_label: The accessible label given to the button used to move to the previous 24 years.
/// - next_multi_year_label: The accessible label given to the button used to move to the next 24 years.
/// - special_dates: A function used to determine whether a date has a highlighted look and feel
/// - blackout_dates: A function used to determine whether a date is disabled and cannot be selected by the user
///
///
pub opaque type State {
  State(
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

/// View is the possible views of a State or datepicker
///
pub type View {
  Month
  MultiYear
  Year
}

pub const default_view = Month

// --- CONFIGURATION ---

/// Config allows for a declarative configuration of the State
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

/// default_config returns a Config with all fields set to None and the default view
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

/// new creates a State with all fields set to None and the default view
///
pub fn new() -> State {
  from_config(default_config())
}

/// from_config creates a State from a Config
///
pub fn from_config(c: Config) -> State {
  State(
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

// --- SETTERS ---

/// date sets the `date` field
///
pub fn date(c: State, date: Option(DateTime)) -> State {
  State(..c, date: date)
}

/// max_date sets the `max_date` field
///
pub fn max_date(c: State, max_date: Option(DateTime)) -> State {
  State(..c, max_date: max_date)
}

/// min_date sets the `min_date` field
///
pub fn min_date(c: State, min_date: Option(DateTime)) -> State {
  State(..c, min_date: min_date)
}

/// range_end sets the `range_end` field
///
pub fn range_end(c: State, range_end: Option(DateTime)) -> State {
  State(..c, range_end: range_end)
}

/// range_start sets the `range_start` field
///
pub fn range_start(c: State, range_start: Option(DateTime)) -> State {
  State(..c, range_start: range_start)
}

/// start_at sets the `start_at` field
///
pub fn start_at(c: State, start_at: Option(DateTime)) -> State {
  State(..c, start_at: start_at)
}

/// start_view sets the `start_view` field
///
pub fn start_view(c: State, start_view: View) -> State {
  State(..c, start_view: start_view)
}

/// previous_month_label sets the `previous_month_label` field
///
pub fn previous_month_label(c: State, previous_month_label: String) -> State {
  State(..c, previous_month_label: previous_month_label)
}

/// next_month_label sets the `next_month_label` field
///
pub fn next_month_label(c: State, next_month_label: String) -> State {
  State(..c, next_month_label: next_month_label)
}

/// previous_year_label sets the `previous_year_label` field
///
pub fn previous_year_label(c: State, previous_year_label: String) -> State {
  State(..c, previous_year_label: previous_year_label)
}

/// next_year_label sets the `next_year_label` field
///
pub fn next_year_label(c: State, next_year_label: String) -> State {
  State(..c, next_year_label: next_year_label)
}

/// previous_multi_year_label sets the `previous_multi_year_label` field
///
pub fn previous_multi_year_label(
  c: State,
  previous_multi_year_label: String,
) -> State {
  State(..c, previous_multi_year_label: previous_multi_year_label)
}

/// next_multi_year_label sets the `next_multi_year_label` field
///
pub fn next_multi_year_label(c: State, next_multi_year_label: String) -> State {
  State(..c, next_multi_year_label: next_multi_year_label)
}

/// special_dates sets the `special_dates` field
///
pub fn special_dates(c: State, special_dates: Option(String)) -> State {
  State(..c, special_dates: special_dates)
}

/// blackout_dates sets the `blackout_dates` field
///
pub fn blackout_dates(c: State, blackout_dates: Option(String)) -> State {
  State(..c, blackout_dates: blackout_dates)
}

// --- RENDERING ---

/// attributes returns a list of attributes for the calendar and
/// datepicker element common state
///
pub fn attributes(c: State) -> List(Attribute(msg)) {
  [
    helpers.option_attribute(c.date, fn(_) { "date" }, datetime.to_string, None),
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
  ]
  |> list.filter(fn(a) { a != attribute.none() })
}

// --- PRIVATE HELPER FUNCTIONS ---

fn view_to_string(v: View) -> String {
  case v {
    Month -> "month"
    MultiYear -> "multi-year"
    Year -> "year"
  }
}

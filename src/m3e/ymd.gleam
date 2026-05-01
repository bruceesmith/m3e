import birl

import gleam/int
import gleam/result
import gleam/string
import gleam/time/timestamp

import m3e/day
import m3e/month
import m3e/year

// --- Types ---

/// Ymd is a date only consisting of year, month, and day.
///
pub opaque type Ymd {
  Ymd(year: year.Year, month: month.Month, day: day.Day)
}

// --- Defaults ---

pub const default = Ymd(year.default, month.default, day.default)

// --- Constructors ---

/// from_string parses a Ymd value from a string, returning a Result.
/// The string must be in the format yyyy-mm-dd, with valid year, month, and day values.
///
pub fn from_string(input: String) -> Result(Ymd, String) {
  case string.split(input, "-") {
    [y, m, d] -> {
      use yr <- result.try(
        int.parse(y) |> result.replace_error(y <> " can't be parsed as a year"),
      )
      use year <- result.try(year.new(yr))
      use mon <- result.try(
        int.parse(m) |> result.replace_error(m <> " can't be parsed as a month"),
      )
      use month <- result.try(month.new(mon))
      use dy <- result.try(
        int.parse(d) |> result.replace_error(d <> " can't be parsed as a day"),
      )
      use day <- result.try(day.new(dy, mon, yr))
      Ok(Ymd(year: year, month: month, day: day))
    }
    _ -> Error(input <> " is an invalid date string, must be yyyy-mm-dd")
  }
}

/// new creates a Ymd value from year, month, and day integers, returning a Result.
/// The year must be between 1800 and 2500, inclusive.
/// The month must be between 1 and 12, inclusive.
/// The day must be between 1 and the number of days in the given month and year, inclusive.
///
pub fn new(year: Int, month: Int, day: Int) -> Result(Ymd, String) {
  use yr <- result.try(year.new(year))
  use mth <- result.try(month.new(month))
  use day <- result.try(day.new(day, month.month(mth), year.year(yr)))
  Ok(Ymd(year: yr, month: mth, day: day))
}

/// today_utc creates a Ymd (pure year-month-day) with today's date
///
pub fn today_utc() -> Ymd {
  let assert Ok(today) =
    from_string(string.remove_suffix(
      birl.to_date_string(birl.from_timestamp(timestamp.system_time())),
      "Z",
    ))
  today
}

// --- Rendering ---

/// to_string converts a Ymd value to a string in the format yyyy-mm-dd.
///
pub fn to_string(d: Ymd) -> String {
  year.to_string(d.year)
  <> "-"
  <> string.pad_start(month.to_string(d.month), 2, "0")
  <> "-"
  <> string.pad_start(day.to_string(d.day), 2, "0")
}

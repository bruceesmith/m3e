import gleam/int
import gleam/result
import gleam/string

import m3e/positive
import m3e/range

// --- Types ---

/// Day represents a day of the month, aligned with the ISO 8601 standard.
///
pub opaque type Day {
  Day(day: Int, month_: Int, year_: Int)
}

// --- Defaults ---

pub const default = Day(1, 1, 1970)

// --- Constructors ---

/// from_string parses a day from a string in the format "DD". This constructor
/// takes a day, month, and year as separate strings and returns a Result. It requires
/// the day, month, and year to prevent an invalid day from being created, for example
/// the 29th February in a Leap Year, or the 32nd day of a month.
///
pub fn from_string(dd: String, mm: String, yy: String) -> Result(Day, String) {
  use day <- result.try(
    int.parse(dd)
    |> result.map_error(fn(_) { dd <> " cannot be converted to a day" }),
  )
  use month <- result.try(
    int.parse(mm)
    |> result.map_error(fn(_) { mm <> " cannot be converted to a month" }),
  )
  use year <- result.try(
    int.parse(yy)
    |> result.map_error(fn(_) { yy <> " cannot be converted to a year" }),
  )
  use d <- result.try(day_(day, month, year))
  Ok(Day(d, month, year))
}

/// new creates a Day value from a day, month, and year. This constructor
/// takes a day, a Month, and a Year  and returns a Result. It requires
/// the day, month, and year to prevent an invalid day from being created, for example
/// the 29th February in a Leap Year, or the 32nd day of a month.
///
pub fn new(day: Int, m: Int, y: Int) -> Result(Day, String) {
  use d <- result.try(day_(day, m, y))
  Ok(Day(d, m, y))
}

@internal
pub fn day(d: Day) -> Int {
  d.day
}

// --- Setters ---

pub fn with_day(d: Day, day: Int) -> Result(Day, String) {
  use day <- result.try(
    positive.positive(day)
    |> result.map_error(fn(_) { int.to_string(day) <> " is not a valid day" }),
  )
  use day <- result.try(day_(day, d.month_, d.year_))
  Ok(Day(day, d.month_, d.year_))
}

// --- Rendering ---

pub fn to_string(d: Day) -> String {
  string.pad_start(int.to_string(d.day), 2, "0")
}

// --- Private Helper Functions

fn day_(dd: Int, month: Int, year: Int) -> Result(Int, String) {
  use day <- result.try(
    positive.positive(dd)
    |> result.map_error(fn(_) { int.to_string(dd) <> " is not a valid day" }),
  )
  use month <- result.try(range.range(month, 1, 12))
  use year <- result.try(positive.positive(year))

  let is_leap = { year % 4 == 0 && year % 100 != 0 } || { year % 400 == 0 }

  let day_ok = case month {
    4 | 6 | 9 | 11 -> day >= 1 && day <= 30
    2 if is_leap -> day >= 1 && day <= 29
    2 -> day >= 1 && day <= 28
    _ -> day >= 1 && day <= 31
  }

  case day_ok {
    True -> Ok(day)
    False ->
      Error(
        int.to_string(dd)
        <> " is not a valid day for month "
        <> int.to_string(month)
        <> " in year "
        <> int.to_string(year),
      )
  }
}

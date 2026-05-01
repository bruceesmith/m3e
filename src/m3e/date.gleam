import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string

import m3e/time.{type Time}
import m3e/timezone.{type TimeZone}
import m3e/ymd.{type Ymd}

// --- Types ---

/// Date represents a date value, optionally with a time and timezone. Aligning with
/// Material Expressive's subset of the ISO 8601 standard, Date supprts the following
/// string formats:
/// - yyyy-MM-dd,
/// - yyyy-MM-ddTHH:mm:ss,
/// - yyyy-MM-ddTHH:mm:ssZ,
/// - yyyy-MM-ddTHH:mm:ss±HH:mm.
///
pub opaque type Date {
  Full(date: Ymd, time: Time, timezone: TimeZone)
  Date(date: Ymd)
  DateTime(date: Ymd, time: Time)
}

// --- Defaults ---

pub const default = Date(ymd.default)

// --- Constructors ---

/// from_string parses a string into a DateTime value.
///
pub fn from_string(input: String) -> Result(Date, String) {
  let input = string.uppercase(input)
  case string.split(input, "T") {
    // Case 1: yyyy-MM-dd
    [date] -> {
      use d <- result.try(ymd.from_string(date))
      Ok(Date(d))
    }

    // Case 2: yyyy-MM-ddTHH:mm:ss...
    [date, rest] -> {
      full(date, rest)
    }
    _ ->
      Error(
        input
        <> " is an invalid date-time format, must be yyyy-MM-dd or yyyy-MM-ddTHH:mm:ss or yyyy-MM-ddTHH:mm:ssZ or yyyy-MM-ddTHH:mm:ss±HH:mm",
      )
  }
}

/// new creates a Date value from a Ymd, Time, and TimeZone.
///
pub fn new(d: Ymd, t: Option(Time), tz: Option(TimeZone)) -> Date {
  case t, tz {
    Some(t), Some(tz) -> Full(d, t, tz)
    Some(t), None -> DateTime(d, t)
    None, _ -> Date(d)
  }
}

/// today_utc creates a Date (pure year-month-day form) with today's
/// date in UTC (i.e. no timezone)
///
pub fn today_utc() -> Date {
  new(ymd.today_utc(), None, None)
}

// --- Rendering ---

/// to_string converts a Date value to a string in the format yyyy-MM-dd or
/// yyyy-MM-ddTHH:mm:ss or yyyy-MM-ddTHH:mm:ssZ or yyyy-MM-ddTHH:mm:ss±HH:mm.
///
pub fn to_string(d: Date) -> String {
  case d {
    Full(date, time, tz) ->
      ymd.to_string(date)
      <> "T"
      <> time.to_string(time)
      <> timezone.to_string(tz)
    Date(date) -> ymd.to_string(date)
    DateTime(date, time) -> ymd.to_string(date) <> "T" <> time.to_string(time)
  }
}

// --- Private Helper Functions

fn date_time(date: String, time: String) -> Result(Date, String) {
  use tim <- result.try(time.from_string(time))
  use d <- result.try(ymd.from_string(date))
  Ok(DateTime(d, tim))
}

fn date_time_tz(
  date: String,
  time: String,
  offset: String,
  sign: timezone.Direction,
) -> Result(Date, String) {
  use tim <- result.try(time.from_string(time))
  use d <- result.try(ymd.from_string(date))
  use tz_time <- result.try(time.from_string(offset))
  use tz <- result.try(timezone.new(sign, tz_time))
  Ok(Full(d, tim, tz))
}

fn date_time_zulu(date: String, time: String) -> Result(Date, String) {
  use t <- result.try(time.from_string(time))
  use d <- result.try(ymd.from_string(date))
  Ok(Full(d, t, timezone.zulu()))
}

fn full(date: String, rest: String) -> Result(Date, String) {
  let rest = string.uppercase(rest)
  case string.ends_with(rest, "Z") {
    True -> {
      date_time_zulu(date, string.drop_end(rest, 1))
    }
    False -> {
      full_not_zulu(date, rest)
    }
  }
}

fn full_not_zulu(date: String, rest: String) -> Result(Date, String) {
  case string.split(rest, "+"), string.split(rest, "-") {
    [a, b], [_] -> {
      date_time_tz(date, a, b, timezone.Plus)
    }
    [_], [a, b] -> {
      date_time_tz(date, a, b, timezone.Minus)
    }
    [a], [_] -> {
      date_time(date, a)
    }
    _, _ -> Error(rest <> " is an invalid timezone offset, must be ±HH:mm")
  }
}

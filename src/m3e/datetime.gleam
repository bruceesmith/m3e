import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string

import m3e/date.{type Date}
import m3e/time.{type Time}
import m3e/timezone.{type TimeZone}

// --- Types ---

/// DateTime is a date and time
///
pub opaque type DateTime {
  DateTime(date: Date, time: Time, timezone: Option(TimeZone))
}

// --- CONSTRUCTORS ---

/// new creates a DateTime value from a Date, Time, and optional TimeZone.
///
pub fn new(date: Date, time: Time, tz: Option(TimeZone)) -> DateTime {
  DateTime(date: date, time: time, timezone: tz)
}

/// from_string parses a string into a DateTime value.
///
pub fn from_string(input: String) -> Result(DateTime, String) {
  case string.split(input, "T") {
    // Case 1: yyyy-MM-dd
    [date] -> {
      local_date_(date)
    }

    // Case 2: yyyy-MM-ddTHH:mm:ss...
    [date, rest] -> {
      date_and_time_(date, rest)
    }
    _ ->
      Error(
        input
        <> " is an invalid date-time format, must be yyyy-MM-dd or yyyy-MM-ddTHH:mm:ss or yyyy-MM-ddTHH:mm:ssZ or yyyy-MM-ddTHH:mm:ss±HH:mm",
      )
  }
}

// --- SETTERS ---

/// date returns a new DateTime with the given date.
///
pub fn date(dt: DateTime, date: Date) -> DateTime {
  DateTime(..dt, date: date)
}

/// time returns a new DateTime with the given time.
///
pub fn time(dt: DateTime, time: Time) -> DateTime {
  DateTime(..dt, time: time)
}

/// timezone returns a new DateTime with the given timezone.
///
pub fn timezone(dt: DateTime, tz: Option(TimeZone)) -> DateTime {
  DateTime(..dt, timezone: tz)
}

// --- RENDERING ---

/// to_string returns a string representation of the DateTime.
///
pub fn to_string(dt: DateTime) -> String {
  date.to_string(dt.date)
  <> case dt.timezone {
    Some(tz) -> "T" <> time.to_string(dt.time) <> timezone.to_string(tz)
    None ->
      case time.is_zero(dt.time) {
        True -> ""
        False -> "T" <> time.to_string(dt.time)
      }
  }
}

// --- PRIVATE HELPER FUNCTIONS ---

fn date_and_time_(date: String, rest: String) -> Result(DateTime, String) {
  // yyyy-MM-ddTHH:mm:ss or yyyy-MM-ddTHH:mm:ssZ or yyyy-MM-ddTHH:mm:ss±HH:mm
  use the_date <- result.try(date.from_string(date))

  // Determine if there is an offset (Z, +, or -)
  let has_z = string.ends_with(rest, "Z")
  let has_plus = string.contains(rest, "+")
  let has_minus = string.contains(rest, "-")

  case has_z, has_plus, has_minus {
    // yyyy-MM-ddTHH:mm:ssZ
    True, False, False -> {
      utc_date_and_time_(the_date, rest)
    }

    False, True, False -> {
      // yyyy-MM-ddTHH:mm:ss+HH:mm or
      date_and_time_with_offset_(the_date, rest, "+")
    }

    False, False, True -> {
      // yyyy-MM-ddTHH:mm:ss-HH:mm
      date_and_time_with_offset_(the_date, rest, "-")
    }

    // yyyy-MM-ddTHH:mm:ss (Local)
    False, False, False -> {
      local_date_and_time_(the_date, rest)
    }
    True, False, True | True, True, False | False, True, True | True, True, True
    ->
      Error(
        date
        <> "T"
        <> rest
        <> " is an invalid date-time format, must be yyyy-MM-ddTHH:mm:ss or yyyy-MM-ddTHH:mm:ssZ or yyyy-MM-ddTHH:mm:ss±HH:mm",
      )
  }
}

fn date_and_time_with_offset_(
  // yyyy-MM-ddTHH:mm:ss±HH:mm
  date: Date,
  time_and_offset: String,
  sign: String,
) -> Result(DateTime, String) {
  case string.split(time_and_offset, sign) {
    [time_part, offset_part] -> {
      use time <- result.try(time.from_string(time_part))
      use offset <- result.try(timezone.from_string(sign <> offset_part))
      Ok(DateTime(date: date, time: time, timezone: Some(offset)))
    }
    _ -> Error("Invalid time and offset format " <> time_and_offset)
  }
}

fn local_date_(s: String) -> Result(DateTime, String) {
  // yyyy-MM-dd
  use date <- result.try(date.from_string(s))
  Ok(DateTime(date: date, time: time.zero(), timezone: None))
}

fn local_date_and_time_(date: Date, rest: String) -> Result(DateTime, String) {
  // yyyy-MM-ddTHH:mm:ss
  use time <- result.try(time.from_string(rest))
  Ok(DateTime(date: date, time: time, timezone: None))
}

fn utc_date_and_time_(date: Date, rest: String) -> Result(DateTime, String) {
  // yyyy-MM-ddTHH:mm:ssZ
  let time = string.drop_end(rest, 1)
  use time <- result.try(time.from_string(time))
  Ok(DateTime(date:, time: time, timezone: Some(timezone.zulu())))
}

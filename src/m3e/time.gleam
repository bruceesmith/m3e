import gleam/int
import gleam/result
import gleam/string

import m3e/hour
import m3e/minute
import m3e/second

// --- Types ---

/// Time is a time
///
pub opaque type Time {
  Time(hour: hour.Hour, minute: minute.Minute, second: second.Second)
}

// --- Defaults ---

pub const default = Time(hour.default, minute.default, second.default)

// --- Constructors ---

/// from_string creates a new Time, returning an Error if the supplied string is invalid
///
pub fn from_string(input: String) -> Result(Time, String) {
  use #(hour, minute, second) <- result.try(time_(input))
  Ok(Time(hour: hour, minute: minute, second: second))
}

/// new creates a new Time, returning an Error if the supplied values are invalid
///
pub fn new(hour: Int, minute: Int, second: Int) -> Result(Time, String) {
  use hour <- result.try(hour.new(hour))
  use minute <- result.try(minute.new(minute))
  use second <- result.try(second.new(second))
  Ok(Time(hour: hour, minute: minute, second: second))
}

// --- PREDICATES ---

/// less_than returns true if the first time is less than the second time
///
pub fn less_than(time1: Time, time2: Time) -> Bool {
  let c1 = hour.hour(time1.hour) < hour.hour(time2.hour)
  let c2 =
    hour.hour(time1.hour) == hour.hour(time2.hour)
    && minute.minute(time1.minute) < minute.minute(time2.minute)
  let c3 =
    hour.hour(time1.hour) == hour.hour(time2.hour)
    && minute.minute(time1.minute) == minute.minute(time2.minute)
    && second.second(time1.second) < second.second(time2.second)
  c1 || c2 || c3
}

// --- Rendering ---

/// to_hhmm converts a Time to a string in the format hh:mm (i.e.truncating the seconds)
///
pub fn to_hhmm(t: Time) -> String {
  string.pad_start(int.to_string(hour.hour(t.hour)), 2, "0")
  <> ":"
  <> string.pad_start(int.to_string(minute.minute(t.minute)), 2, "0")
}

/// to_string converts a Time to a string in the format hh:mm:ss
///
pub fn to_string(t: Time) -> String {
  string.pad_start(int.to_string(hour.hour(t.hour)), 2, "0")
  <> ":"
  <> string.pad_start(int.to_string(minute.minute(t.minute)), 2, "0")
  <> ":"
  <> string.pad_start(int.to_string(second.second(t.second)), 2, "0")
}

// --- Private Helper Functions

fn time_(
  input: String,
) -> Result(#(hour.Hour, minute.Minute, second.Second), String) {
  case string.split(input, ":") {
    [h, m, s] -> {
      full_time_(h, m, s)
    }
    [h, m] -> {
      full_time_(h, m, "00")
    }
    _ -> Error(input <> " is an invalid time string, must be hh:mm:ss or hh:mm")
  }
}

fn full_time_(
  h: String,
  m: String,
  s: String,
) -> Result(#(hour.Hour, minute.Minute, second.Second), String) {
  use hh <- result.try(
    int.parse(h) |> result.replace_error(h <> " is an invalid hour"),
  )
  use hour <- result.try(hour.new(hh))
  use mm <- result.try(
    int.parse(m) |> result.replace_error(m <> " is an invalid minute"),
  )
  use minutes <- result.try(minute.new(mm))
  use ss <- result.try(
    int.parse(s) |> result.replace_error(s <> " is an invalid second"),
  )
  use seconds <- result.try(second.new(ss))
  Ok(#(hour, minutes, seconds))
}

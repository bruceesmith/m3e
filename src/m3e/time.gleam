import gleam/int
import gleam/result
import gleam/string

import m3e/helpers

// --- Types ---

/// Time is a time
///
pub opaque type Time {
  Time(hour: Int, minute: Int, second: Int)
}

// --- CONSTRUCTORS ---

/// new creates a new Time, returning an Error if the supplied values are invalid
///
pub fn new(hour: Int, minute: Int, second: Int) -> Result(Time, String) {
  use hour <- result.try(hour_(int.to_string(hour)))
  use minute <- result.try(minutes_or_seconds_(int.to_string(minute)))
  use second <- result.try(minutes_or_seconds_(int.to_string(second)))
  Ok(Time(hour: hour, minute: minute, second: second))
}

/// from_string creates a new Time, returning an Error if the supplied string is invalid
///
pub fn from_string(input: String) -> Result(Time, String) {
  use #(hour, minute, second) <- result.try(time_(input))
  Ok(Time(hour: hour, minute: minute, second: second))
}

/// zero creates a zero Time
///
pub fn zero() -> Time {
  Time(hour: 0, minute: 0, second: 0)
}

// --- PREDICATES ---

/// less_than returns true if the first time is less than the second time
///
pub fn less_than(time1: Time, time2: Time) -> Bool {
  let c1 = time1.hour < time2.hour
  let c2 = time1.hour == time2.hour && time1.minute < time2.minute
  let c3 =
    time1.hour == time2.hour
    && time1.minute == time2.minute
    && time1.second < time2.second
  c1 || c2 || c3
}

/// is_zero returns true if the time is zero (00:00:00)
///
pub fn is_zero(time: Time) -> Bool {
  time.hour == 0 && time.minute == 0 && time.second == 0
}

// --- RENDERING ---

/// to_hhmm converts a Time to a string in the format hh:mm (i.e.truncating the seconds)
///
pub fn to_hhmm(time: Time) -> String {
  string.pad_start(int.to_string(time.hour), 2, "0")
  <> ":"
  <> string.pad_start(int.to_string(time.minute), 2, "0")
}

/// to_string converts a Time to a string in the format hh:mm:ss
///
pub fn to_string(time: Time) -> String {
  string.pad_start(int.to_string(time.hour), 2, "0")
  <> ":"
  <> string.pad_start(int.to_string(time.minute), 2, "0")
  <> ":"
  <> string.pad_start(int.to_string(time.second), 2, "0")
}

// --- PRIVATE HELPER FUNCTIONS ---

fn hour_(hh: String) -> Result(Int, String) {
  use hour <- result.try(
    int.parse(hh)
    |> result.replace_error("Cannot parse " <> hh <> " as an integer"),
  )
  use hour <- result.try(helpers.range_(hour, 0, 23))
  Ok(hour)
}

fn minutes_or_seconds_(s: String) -> Result(Int, String) {
  use m <- result.try(
    int.parse(s)
    |> result.replace_error("Cannot parse " <> s <> " as an integer"),
  )
  use m <- result.try(helpers.range_(m, 0, 59))
  Ok(m)
}

pub fn time_(input: String) -> Result(#(Int, Int, Int), String) {
  case string.split(input, ":") {
    [h, m, s] -> {
      use hour <- result.try(hour_(h))
      use minutes <- result.try(minutes_or_seconds_(m))
      use seconds <- result.try(minutes_or_seconds_(s))
      Ok(#(hour, minutes, seconds))
    }
    [h, m] -> {
      use hour <- result.try(hour_(h))
      use minutes <- result.try(minutes_or_seconds_(m))
      Ok(#(hour, minutes, 0))
    }
    _ -> Error(input <> " is an invalid time string, must be hh:mm:ss or hh:mm")
  }
}

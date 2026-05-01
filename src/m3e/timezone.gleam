import gleam/bool
import gleam/result
import gleam/string

import m3e/time.{type Time}

// --- Types ---

/// Direction is the direction of a timezone's offset from UTC
///
pub type Direction {
  Plus
  Minus
}

/// TimeZone is a time zone
///
pub opaque type TimeZone {
  Zulu
  Offset(sign: Direction, amount: Time)
}

// --- Defaults ---

pub const default = Zulu

// --- Constructors ---

/// from_string parses a timezone string into a TimeZone value.
///
pub fn from_string(input: String) -> Result(TimeZone, String) {
  case input {
    "Z" -> Ok(Zulu)
    _ -> {
      let sign = string.slice(input, 0, 1)
      use s <- result.try(offset_sign_(sign))
      let time_part = string.drop_start(input, 1)
      use tim <- result.try(time.from_string(time_part))
      offset_(s, tim)
    }
  }
}

/// new creates a TimeZone value from a direction string and a Time value.
///
pub fn new(direction: Direction, time: Time) -> Result(TimeZone, String) {
  use os <- result.try(offset_(direction, time))

  Ok(os)
}

/// zulu returns the Zulu timezone (UTC).
///
pub fn zulu() -> TimeZone {
  Zulu
}

// --- Rendering ---

/// to_string converts a TimeZone value to a string representation.
///
pub fn to_string(tz: TimeZone) -> String {
  case tz {
    Zulu -> "Z"
    Offset(sign, time) -> {
      sign_to_string_(sign) <> time.to_hhmm(time)
    }
  }
}

// --- Private Helper Functions

fn offset_(sign: Direction, time: Time) -> Result(TimeZone, String) {
  case sign {
    Plus ->
      validate_limit(
        time,
        "14:01",
        Plus,
        "Positive timezone offset must be less than 14:00",
      )
    Minus ->
      validate_limit(
        time,
        "12:01",
        Minus,
        "Negative timezone offset must be less than 12:00",
      )
  }
}

fn offset_sign_(s: String) -> Result(Direction, String) {
  case s {
    "+" -> Ok(Plus)
    "-" -> Ok(Minus)
    _ -> Error("Invalid offset sign " <> s <> " must be + or -")
  }
}

fn sign_to_string_(sign: Direction) -> String {
  case sign {
    Plus -> "+"
    Minus -> "-"
  }
}

fn validate_limit(t: Time, limit_str: String, sign: Direction, err: String) {
  use limit <- result.try(
    time.from_string(limit_str)
    |> result.replace_error("Invalid timezone offset limit"),
  )
  use <- bool.guard(!time.less_than(t, limit), Error(err))
  Ok(Offset(sign, t))
}

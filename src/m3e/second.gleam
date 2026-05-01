import gleam/int
import gleam/result
import gleam/string

import m3e/range

// --- Types ---

/// Second represents a second of the minute, between 0 and 59, inclusive.
///
pub opaque type Second {
  Second(second: Int)
}

// --- Defaults ---

pub const default = Second(0)

// --- Constructors ---

/// from_string creates a Second value from a numeric string representation, returning a Result.
/// The string must be a two-digit number between 00 and 59, inclusive.
///
pub fn from_string(s: String) -> Result(Second, String) {
  use sec <- result.try(
    int.parse(s)
    |> result.replace_error(s <> " cannot be converted to a second"),
  )
  use second <- result.try(
    range.range(sec, 0, 59)
    |> result.replace_error(s <> " is not a valid second"),
  )
  Ok(Second(second))
}

/// new creates a Second value from an integer second, returning a Result.
/// The second must be between 0 and 59, inclusive.
///
pub fn new(second: Int) -> Result(Second, String) {
  use s <- result.try(
    range.range(second, 0, 59)
    |> result.replace_error(int.to_string(second) <> " is not a valid second"),
  )
  Ok(Second(s))
}

@internal
pub fn second(s: Second) -> Int {
  s.second
}

// --- Rendering ---

/// to_string converts a Second value to a numeric string representation
///
pub fn to_string(s: Second) -> String {
  string.pad_start(int.to_string(s.second), 2, "0")
}

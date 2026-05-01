import gleam/int
import gleam/result
import gleam/string
import m3e/range

// --- Types ---

/// An Hour is a value representing an hour of the day, from 0 to 23.
///
pub opaque type Hour {
  Hour(hour: Int)
}

// --- Defaults ---

pub const default = Hour(0)

// --- Constructors ---

/// from_string creates an Hour value from a string. This constructor takes a string
/// and returns a Result. It requires the string to be a valid hour, between 0 and 23, inclusive.
///
pub fn from_string(hour: String) -> Result(Hour, String) {
  use h <- result.try(
    int.parse(hour)
    |> result.replace_error(hour <> " cannot be converted to an hour"),
  )
  use h <- result.try(
    range.range(h, 0, 23)
    |> result.replace_error(hour <> " is not a valid hour"),
  )
  new(h)
}

/// new creates an Hour value from an hour. This constructor takes an hour as an Int
/// and returns a Result. It requires the hour to be between 0 and 23, inclusive.
///
pub fn new(hour: Int) -> Result(Hour, String) {
  use h <- result.try(
    range.range(hour, 0, 23)
    |> result.replace_error(int.to_string(hour) <> " is not a valid hour"),
  )
  Ok(Hour(h))
}

@internal
pub fn hour(h: Hour) -> Int {
  h.hour
}

// --- Rendering ---

/// to_string converts an Hour value to a string.
///
pub fn to_string(h: Hour) -> String {
  string.pad_start(int.to_string(h.hour), 2, "0")
}

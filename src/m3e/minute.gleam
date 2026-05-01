import gleam/int
import gleam/result
import gleam/string
import m3e/range

// --- Types ---

/// Minute represents a minute of the hour, between 0 and 59, inclusive.
///
pub opaque type Minute {
  Minute(minute: Int)
}

// --- Defaults ---

pub const default = Minute(0)

// --- Constructors ---

/// from_string creates a Minute value from a string representation of a minute.
/// This constructor takes a string and returns a Result. It requires the string
/// to be a valid minute, i.e. a number between 00 and 59, inclusive.
///
pub fn from_string(minute: String) -> Result(Minute, String) {
  use m <- result.try(
    int.parse(minute)
    |> result.replace_error(minute <> " cannot be converted to a minute"),
  )
  use m <- result.try(
    range.range(m, 0, 59)
    |> result.replace_error(minute <> " is not a valid minute"),
  )
  Ok(Minute(m))
}

/// new creates a Minute value from a minute. This constructor takes a minute as an Int
/// and returns a Result. It requires the minute to be between 0 and 59, inclusive.
///
pub fn new(minute: Int) -> Result(Minute, String) {
  use m <- result.try(
    range.range(minute, 0, 59)
    |> result.replace_error(int.to_string(minute) <> " is not a valid minute"),
  )
  Ok(Minute(m))
}

@internal
pub fn minute(m: Minute) -> Int {
  m.minute
}

// --- Rendering ---

/// to_string returns a string representation of the minute, padded with a leading zero if necessary.
///
pub fn to_string(m: Minute) -> String {
  string.pad_start(int.to_string(m.minute), 2, "0")
}

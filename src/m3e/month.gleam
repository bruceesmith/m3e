import gleam/int
import gleam/result
import gleam/string
import m3e/range

// --- Types ---

/// Month represents a month of the year, between 1 and 12, inclusive.
///
pub type Month {
  Month(month: Int)
}

// --- Defaults ---

pub const default = Month(1)

// --- Constructors ---

/// from_string creates a Month value from a numeric string representation, returning a Result.
/// The string must be a two-digit number between 01 and 12, inclusive.
///
pub fn from_string(m: String) -> Result(Month, String) {
  use mon <- result.try(
    int.parse(m)
    |> result.replace_error(m <> " cannot be converted to a month"),
  )
  use month <- result.try(
    range.range(mon, 1, 12)
    |> result.replace_error(m <> " is not a valid month"),
  )
  Ok(Month(month))
}

/// new creates a Month value from an integer month, returning a Result.
/// The month must be between 1 and 12, inclusive.
///
pub fn new(month: Int) -> Result(Month, String) {
  use m <- result.try(range.range(month, 1, 12))
  Ok(Month(m))
}

@internal
pub fn month(m: Month) -> Int {
  m.month
}

// --- Rendering ---

/// to_string converts a Month value to a numeric string representation
///
pub fn to_string(m: Month) -> String {
  string.pad_start(int.to_string(m.month), 2, "0")
}

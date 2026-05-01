import gleam/int
import gleam/result
import m3e/range

// --- Types ---

/// Year represents a year value, constrained to be between 1800 and 2500, inclusive.
///
pub opaque type Year {
  Year(year: Int)
}

// --- Defaults ---

pub const default = Year(1800)

// --- Constructors ---

/// from_string parses a Year value from a string, returning a Result.
/// The string must represent an integer year between 1800 and 2500, inclusive.
///
pub fn from_string(s: String) -> Result(Year, String) {
  use yr <- result.try(
    int.parse(s)
    |> result.replace_error(s <> " cannot be converted to a year"),
  )
  use year <- result.try(
    range.range(yr, 1800, 2500)
    |> result.replace_error(s <> " is out of range >=1800 and <=2500"),
  )
  Ok(Year(year))
}

/// new creates a Year value from an integer year, returning a Result.
/// The year must be between 1800 and 2500, inclusive.
///
pub fn new(year: Int) -> Result(Year, String) {
  use y <- result.try(range.range(year, 1800, 2500))
  Ok(Year(y))
}

@internal
pub fn year(y: Year) -> Int {
  y.year
}

// --- Rendering ---

/// to_string converts a Year value to a string.
///
pub fn to_string(y: Year) -> String {
  int.to_string(y.year)
}

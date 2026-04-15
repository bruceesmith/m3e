import gleam/int
import gleam/result
import gleam/string

import m3e/helpers

// --- Types ---

/// Date is a date
///
pub opaque type Date {
  Date(year: Int, month: Int, day: Int)
}

// --- CONSTRUCTORS ---

pub fn new(year: Int, month: Int, day: Int) -> Result(Date, String) {
  use year <- result.try(year_(int.to_string(year)))
  use month <- result.try(month_(int.to_string(month)))
  use day <- result.try(day_(int.to_string(day), month, year))
  Ok(Date(year: year, month: month, day: day))
}

pub fn from_string(input: String) -> Result(Date, String) {
  case string.split(input, "-") {
    [y, m, d] -> {
      use year <- result.try(year_(y))
      use month <- result.try(month_(m))
      use day <- result.try(day_(d, month, year))
      Ok(Date(year: year, month: month, day: day))
    }
    _ -> Error(input <> " is an invalid date string, must be yyyy-mm-dd")
  }
}

/// zero returns the date 1970-01-01
pub fn zero() -> Date {
  Date(year: 1970, month: 1, day: 1)
}

// --- RENDERING ---

pub fn to_string(date: Date) -> String {
  int.to_string(date.year)
  <> "-"
  <> string.pad_start(int.to_string(date.month), 2, "0")
  <> "-"
  <> string.pad_start(int.to_string(date.day), 2, "0")
}

// --- PRIVATE HELPER FUNCTIONS ---

fn day_(dd: String, month: Int, year: Int) -> Result(Int, String) {
  use day <- result.try(
    int.parse(dd)
    |> result.replace_error("Cannot parse day " <> dd <> " as an integer"),
  )
  use day <- result.try(helpers.positive_(day))
  use month <- result.try(helpers.range_(month, 1, 12))
  use year <- result.try(helpers.positive_(year))

  let is_leap = { year % 4 == 0 && year % 100 != 0 } || { year % 400 == 0 }

  let day_ok = case month {
    4 | 6 | 9 | 11 -> day >= 1 && day <= 30
    2 if is_leap -> day >= 1 && day <= 29
    2 -> day >= 1 && day <= 28
    _ -> day >= 1 && day <= 31
  }

  case day_ok {
    True -> Ok(day)
    False ->
      Error(
        dd
        <> " is not a valid day for month "
        <> int.to_string(month)
        <> " in year "
        <> int.to_string(year),
      )
  }
}

fn month_(mm: String) -> Result(Int, String) {
  use month <- result.try(
    int.parse(mm)
    |> result.replace_error("Cannot parse month " <> mm <> " as an integer"),
  )
  use month <- result.try(helpers.range_(month, 1, 12))
  Ok(month)
}

fn year_(y: String) -> Result(Int, String) {
  use year <- result.try(
    int.parse(y)
    |> result.replace_error("Cannot parse year " <> y <> " as an integer"),
  )
  use year <- result.try(helpers.positive_(year))
  Ok(year)
}

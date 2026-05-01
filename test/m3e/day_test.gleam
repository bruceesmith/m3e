import gleam/list

import gleeunit/should

import m3e/day

pub fn day_from_string_test() {
  let cases = [
    // Happy paths  - regular day
    #(#("24", "04", "2026"), day.new(24, 4, 2026)),
    // Happy path - single digit day
    #(#("5", "04", "2026"), day.new(5, 4, 2026)),
    // Happy path - single digit month
    #(#("05", "4", "2026"), day.new(5, 4, 2026)),
    // Happy paths  - 29th Feb in a leap year
    #(#("29", "02", "2024"), day.new(29, 2, 2024)),

    // Boundary: min
    #(#("1", "1", "1800"), day.new(1, 1, 1800)),

    // Boundary: max
    #(#("31", "12", "2500"), day.new(31, 12, 2500)),

    // Sad path - day below min for any month/year
    #(#("-1", "4", "2026"), Error("-1 is not a valid day")),
    // Sad path - day above max for any month/year
    #(
      #("40", "3", "2026"),
      Error("40 is not a valid day for month 3 in year 2026"),
    ),
    // Sad path - day incorrect for the specific month
    #(
      #("31", "4", "2024"),
      Error("31 is not a valid day for month 4 in year 2024"),
    ),
    // Sad path - day incorrect for the specific month in the specific year
    #(
      #("29", "2", "2026"),
      Error("29 is not a valid day for month 2 in year 2026"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(d, m, y), expected) = c

    day.from_string(d, m, y)
    |> should.equal(expected)
  })
}

pub fn day_new_test() {
  let cases = [
    // Happy paths  - regular day
    #(#(23, 4, 2026), day.new(23, 4, 2026)),
    // Happy paths  - 29th Feb in a leap year
    #(#(29, 2, 2024), day.new(29, 2, 2024)),

    // Boundary: min
    #(#(1, 1, 1800), day.new(1, 1, 1800)),

    // Boundary: max
    #(#(31, 12, 2500), day.new(31, 12, 2500)),

    // Sad path - day below min for any month/year
    #(#(-1, 4, 2026), Error("-1 is not a valid day")),
    // Sad path - day above max for any month/year
    #(#(40, 4, 2026), Error("40 is not a valid day for month 4 in year 2026")),
    // Sad path - day incorrect for the specific month
    #(#(31, 4, 2024), Error("31 is not a valid day for month 4 in year 2024")),
    // Sad path - day incorrect for the specific month in the specific year
    #(#(29, 2, 2026), Error("29 is not a valid day for month 2 in year 2026")),
  ]

  list.each(cases, fn(c) {
    let #(#(d, m, y), expected) = c

    day.new(d, m, y)
    |> should.equal(expected)
  })
}

pub fn day_day_test() {
  let assert Ok(d2026_04_23) = day.new(23, 4, 2026)
  let cases = [
    // Happy paths
    #(d2026_04_23, 23),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    day.day(input)
    |> should.equal(expected)
  })
}

pub fn day_to_string_test() {
  let assert Ok(d2026_04_01) = day.new(1, 4, 2026)
  let assert Ok(d2026_04_23) = day.new(23, 4, 2026)
  let cases = [
    // Happy paths
    #(d2026_04_23, "23"),

    // Boundary - single digit day should be padded with a leading zero
    #(d2026_04_01, "01"),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    day.to_string(input)
    |> should.equal(expected)
  })
}

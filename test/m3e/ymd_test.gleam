import gleam/list

import gleeunit/should

import m3e/ymd

pub fn ymd_from_string_test() {
  let assert Ok(ymd2026_04_23) = ymd.from_string("2026-04-23")
  let assert Ok(ymd2026_04_03) = ymd.from_string("2026-04-03")
  let assert Ok(ymd2024_02_29) = ymd.from_string("2024-02-29")
  let cases = [
    // Happy paths
    #("2026-04-23", Ok(ymd2026_04_23)),
    // Happy paths - single digit month/day
    #("2026-4-23", Ok(ymd2026_04_23)),
    #("2026-04-3", Ok(ymd2026_04_03)),
    // Happy path - 29th Feb in leap year
    #("2024-02-29", Ok(ymd2024_02_29)),

    // Sad path - invalid day
    #("2026-04-32", Error("32 is not a valid day for month 4 in year 2026")),
    // Sad path - invalid year
    #("1788-04-23", Error("1788 is out of range >=1800 and <=2500")),
    // Sad path - invalid month
    #("2026-13-23", Error("13 is out of range >=1 and <=12")),
    // Sad path - invalid date for month
    #("2026-02-29", Error("29 is not a valid day for month 2 in year 2026")),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    ymd.from_string(input)
    |> should.equal(expected)
  })
}

pub fn ymd_new_test() {
  let cases = [
    // Happy paths
    #(#(2026, 4, 23), ymd.new(2026, 4, 23)),

    // Boundary: min
    #(#(1800, 1, 1), ymd.new(1800, 1, 1)),

    // Boundary: max
    #(#(2500, 12, 31), ymd.new(2500, 12, 31)),

    // Sad path - year below min
    #(#(1778, 1, 1), Error("1778 is out of range >=1800 and <=2500")),
    // Sad path - year above max
    #(#(2642, 1, 1), Error("2642 is out of range >=1800 and <=2500")),
    // Sad path - month below min
    #(#(2642, -1, 1), Error("2642 is out of range >=1800 and <=2500")),
    // Sad path - month above max
    #(#(2642, 13, 1), Error("2642 is out of range >=1800 and <=2500")),
    // Sad path, date invalid for a leap year
    #(#(2026, 2, 29), Error("29 is not a valid day for month 2 in year 2026")),
    // Sad path - day below min
    #(#(2026, 4, 0), Error("0 is not a valid day")),
    // Sad path - day above max
    #(#(2026, 4, 32), Error("32 is not a valid day for month 4 in year 2026")),
  ]

  list.each(cases, fn(c) {
    let #(#(y, m, d), expected) = c

    ymd.new(y, m, d)
    |> should.equal(expected)
  })
}

pub fn ymd_to_string_test() {
  let assert Ok(y2026_04_23) = ymd.new(2026, 4, 23)
  let cases = [
    // Happy paths
    #(y2026_04_23, "2026-04-23"),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    ymd.to_string(input)
    |> should.equal(expected)
  })
}

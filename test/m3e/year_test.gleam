import gleam/list

import gleeunit/should

import m3e/year

pub fn year_from_string_test() {
  let cases = [
    // Happy paths
    #("2042", year.new(2042)),

    // Boundary: min
    #("1800", year.new(1800)),

    // Boundary: max
    #("2500", year.new(2500)),

    // Sad path - below min
    #("1778", Error("1778 is out of range >=1800 and <=2500")),
    // Sad path - above max
    #("2642", Error("2642 is out of range >=1800 and <=2500")),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    year.from_string(input)
    |> should.equal(expected)
  })
}

pub fn year_new_test() {
  let cases = [
    // Happy paths
    #(1970, year.new(1970)),

    // Boundary: min
    #(1800, year.new(1800)),

    // Boundary: max
    #(2500, year.new(2500)),

    // Sad path - below min
    #(1778, Error("1778 is out of range >=1800 and <=2500")),
    // Sad path - above max
    #(2642, Error("2642 is out of range >=1800 and <=2500")),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    year.new(input)
    |> should.equal(expected)
  })
}

pub fn year_year_test() {
  let assert Ok(y2042) = year.new(2042)
  let cases = [
    // Happy paths
    #(y2042, 2042),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    year.year(input)
    |> should.equal(expected)
  })
}

pub fn year_to_string_test() {
  let assert Ok(y2042) = year.new(2042)
  let cases = [
    // Happy paths
    #(y2042, "2042"),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    year.to_string(input)
    |> should.equal(expected)
  })
}

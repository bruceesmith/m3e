import gleam/list

import gleeunit/should

import m3e/month

pub fn month_from_string_test() {
  let cases = [
    // Happy paths
    #("02", month.new(2)),
    // Happy path with single digit
    #("9", month.new(9)),

    // Boundary: min
    #("01", month.new(1)),

    // Boundary: max
    #("12", month.new(12)),

    // Sad paths - below min
    #("0", Error("0 is not a valid month")),

    // Sad paths - above max
    #("13", Error("13 is not a valid month")),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    month.from_string(input)
    |> should.equal(expected)
  })
}

pub fn month_new_test() {
  let cases = [
    // Happy paths
    #(2, month.new(2)),

    // Boundary: min
    #(1, month.new(1)),

    // Boundary: max
    #(12, month.new(12)),

    // Sad paths - below min
    #(0, Error("0 is out of range >=1 and <=12")),

    // Sad paths - above max
    #(13, Error("13 is out of range >=1 and <=12")),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    month.new(input)
    |> should.equal(expected)
  })
}

pub fn month_month_test() {
  let assert Ok(m2) = month.new(2)
  let cases = [
    // Happy paths
    #(m2, 2),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    month.month(input)
    |> should.equal(expected)
  })
}

pub fn month_to_string_test() {
  let assert Ok(m2) = month.new(2)
  let cases = [
    // Happy paths
    #(m2, "02"),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    month.to_string(input)
    |> should.equal(expected)
  })
}

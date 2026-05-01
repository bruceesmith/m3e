import gleam/list

import gleeunit/should

import m3e/second

pub fn second_from_string_test() {
  let cases = [
    // Happy paths  - regular second
    #("21", second.new(21)),

    // Boundary: min & single digit second
    #("0", second.new(0)),

    // Boundary: max
    #("59", second.new(59)),

    // Sad path - hour below min
    #("-1", Error("-1 is not a valid second")),
    // Sad path - second above max for any month/year
    #("70", Error("70 is not a valid second")),
  ]

  list.each(cases, fn(c) {
    let #(ss, expected) = c

    second.from_string(ss)
    |> should.equal(expected)
  })
}

pub fn second_new_test() {
  let cases = [
    // Happy paths  - regular second
    #(21, second.new(21)),

    // Boundary: min
    #(0, second.new(0)),

    // Boundary: max
    #(59, second.new(59)),

    // Sad path - hour below min
    #(-1, Error("-1 is not a valid second")),
    // Sad path - second above max for any month/year
    #(70, Error("70 is not a valid second")),
  ]

  list.each(cases, fn(c) {
    let #(hh, expected) = c

    second.new(hh)
    |> should.equal(expected)
  })
}

pub fn second_second_test() {
  let assert Ok(s21) = second.new(21)
  let cases = [
    // Happy paths  - regular second
    #(s21, 21),
  ]

  list.each(cases, fn(c) {
    let #(hh, expected) = c

    second.second(hh)
    |> should.equal(expected)
  })
}

pub fn second_to_string_test() {
  let assert Ok(s0) = second.new(0)
  let assert Ok(s21) = second.new(21)
  let assert Ok(s59) = second.new(59)

  let cases = [
    // Happy paths  - regular second
    #(s21, "21"),

    // Boundary: min
    #(s0, "00"),
    // Boundary: max
    #(s59, "59"),
  ]

  list.each(cases, fn(c) {
    let #(hh, expected) = c

    second.to_string(hh)
    |> should.equal(expected)
  })
}

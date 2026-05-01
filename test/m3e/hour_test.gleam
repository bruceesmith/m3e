import gleam/list

import gleeunit/should

import m3e/hour

pub fn hour_from_string_test() {
  let cases = [
    // Happy paths  - regular hour
    #("21", hour.new(21)),

    // Boundary: min & single digit hour
    #("0", hour.new(0)),

    // Boundary: max
    #("23", hour.new(23)),

    // Sad path - hour below min
    #("-1", Error("-1 is not a valid hour")),
    // Sad path - hour above max
    #("25", Error("25 is not a valid hour")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    hour.from_string(s)
    |> should.equal(expected)
  })
}

pub fn hour_new_test() {
  let cases = [
    // Happy paths  - regular hour
    #(21, hour.new(21)),

    // Boundary: min
    #(0, hour.new(0)),

    // Boundary: max
    #(23, hour.new(23)),

    // Sad path - hour below min
    #(-1, Error("-1 is not a valid hour")),
    // Sad path - hour above max
    #(25, Error("25 is not a valid hour")),
  ]

  list.each(cases, fn(c) {
    let #(hh, expected) = c

    hour.new(hh)
    |> should.equal(expected)
  })
}

pub fn hours_hour_test() {
  let assert Ok(h21) = hour.new(21)
  let cases = [
    // Happy paths  - regular hour
    #(h21, 21),
  ]

  list.each(cases, fn(c) {
    let #(hh, expected) = c

    hour.hour(hh)
    |> should.equal(expected)
  })
}

pub fn hour_to_string_test() {
  let assert Ok(h0) = hour.new(0)
  let assert Ok(h21) = hour.new(21)
  let cases = [
    // Happy paths  - regular hour
    #(h21, "21"),

    // Boundary: single digit should be padded with leading zero
    #(h0, "00"),
  ]

  list.each(cases, fn(c) {
    let #(hh, expected) = c

    hour.to_string(hh)
    |> should.equal(expected)
  })
}

import gleam/list

import gleeunit/should

import m3e/time

pub fn time_from_string_test() {
  let assert Ok(time19_12_31) = time.from_string("19:12:31")
  let assert Ok(time19_1_31) = time.from_string("19:01:31")
  let assert Ok(time19_12_3) = time.from_string("19:12:03")

  let cases = [
    // Happy paths
    #("19:12:31", Ok(time19_12_31)),
    // Happy paths - single digit minute/second
    #("19:1:31", Ok(time19_1_31)),
    #("19:12:3", Ok(time19_12_3)),

    // Sad path - invalid hour
    #("24:12:31", Error("24 is not a valid hour")),
    // Sad path - invalid minute
    #("19:60:31", Error("60 is not a valid minute")),
    // Sad path - invalid second
    #("19:12:60", Error("60 is not a valid second")),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    time.from_string(input)
    |> should.equal(expected)
  })
}

pub fn time_new_test() {
  let cases = [
    // Happy paths
    #(#(19, 12, 30), time.new(19, 12, 30)),
    // Boundary: min
    #(#(0, 0, 0), time.new(0, 0, 0)),

    // Boundary: max
    #(#(23, 59, 59), time.new(23, 59, 59)),

    // Sad path - hour below min
    #(#(-1, 12, 30), Error("-1 is not a valid hour")),
    // Sad path - hour above max
    #(#(24, 12, 30), Error("24 is not a valid hour")),
    // Sad path - minute below min
    #(#(19, -1, 30), Error("-1 is not a valid minute")),
    // Sad path - minute above max
    #(#(19, 61, 30), Error("61 is not a valid minute")),
    // Sad path - second below min
    #(#(19, 12, -1), Error("-1 is not a valid second")),
    // Sad path - second above max
    #(#(19, 12, 62), Error("62 is not a valid second")),
  ]

  list.each(cases, fn(c) {
    let #(#(h, m, s), expected) = c

    time.new(h, m, s)
    |> should.equal(expected)
  })
}

pub fn time_less_than_test() {
  let assert Ok(time19_12_31) = time.from_string("19:12:31")
  let assert Ok(time19_12_32) = time.from_string("19:12:32")

  let cases = [
    // Happy path
    #(time19_12_31, time19_12_32, True),
    #(time19_12_32, time19_12_31, False),

    // Edge case: same time
    #(time19_12_31, time19_12_31, False),
  ]

  list.each(cases, fn(c) {
    let #(input, other, expected) = c

    time.less_than(input, other)
    |> should.equal(expected)
  })
}

pub fn time_to_hhmm_test() {
  let assert Ok(time19_12_31) = time.from_string("19:12:31")

  let cases = [
    #(time19_12_31, "19:12"),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    time.to_hhmm(input)
    |> should.equal(expected)
  })
}

pub fn time_to_string_test() {
  let assert Ok(time19_12_31) = time.from_string("19:12:31")

  let cases = [
    #(time19_12_31, "19:12:31"),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    time.to_string(input)
    |> should.equal(expected)
  })
}

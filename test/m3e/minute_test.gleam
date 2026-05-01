import gleam/list

import gleeunit/should

import m3e/minute

pub fn minute_from_string_test() {
  let cases = [
    // Happy paths  - regular minute
    #("21", minute.new(21)),

    // Boundary: min & single digit minute
    #("0", minute.new(0)),

    // Boundary: max
    #("59", minute.new(59)),

    // Sad path - negative minute
    #("-1", Error("-1 is not a valid minute")),
    // Sad path - too large a minute
    #("60", Error("60 is not a valid minute")),
  ]

  list.each(cases, fn(c) {
    let #(mm, expected) = c

    minute.from_string(mm)
    |> should.equal(expected)
  })
}

pub fn minute_new_test() {
  let cases = [
    // Happy paths  - regular minute
    #(21, minute.new(21)),

    // Boundary: min
    #(0, minute.new(0)),

    // Boundary: max
    #(59, minute.new(59)),

    // Sad path - minute below min
    #(-1, Error("-1 is not a valid minute")),
    // Sad path - minute above max for any month/year
    #(70, Error("70 is not a valid minute")),
  ]

  list.each(cases, fn(c) {
    let #(hh, expected) = c

    minute.new(hh)
    |> should.equal(expected)
  })
}

pub fn minute_minute_test() {
  let assert Ok(m21) = minute.new(21)
  let cases = [
    // Happy paths  - regular minute
    #(m21, 21),
  ]

  list.each(cases, fn(c) {
    let #(hh, expected) = c

    minute.minute(hh)
    |> should.equal(expected)
  })
}

pub fn minute_to_string_test() {
  let assert Ok(m21) = minute.new(21)
  let assert Ok(m0) = minute.new(0)
  let assert Ok(m59) = minute.new(59)

  let cases = [
    // Happy paths  - regular minute
    #(m21, "21"),
    #(m0, "00"),
    #(m59, "59"),
  ]

  list.each(cases, fn(c) {
    let #(mm, expected) = c

    minute.to_string(mm)
    |> should.equal(expected)
  })
}

import gleam/list

import gleeunit/should

import m3e/time
import m3e/timezone

pub fn timezone_from_string_test() {
  let assert Ok(t10_12_31) = time.new(10, 12, 31)
  let assert Ok(t14_00_00) = time.new(14, 00, 00)
  let assert Ok(t12_00_00) = time.new(12, 00, 00)
  // let assert Ok(t15_00_00) = time.new(15, 00, 00)

  let cases = [
    // Happy path - valid positive offset
    #("+10:12:31", timezone.new(timezone.Plus, t10_12_31)),
    // Happy path - valid negative offset
    #("-10:12:31", timezone.new(timezone.Minus, t10_12_31)),

    // Boundary case - positive offset at 14:00:00
    #("+14:00:00", timezone.new(timezone.Plus, t14_00_00)),
    // Boundary case - negative offset at 12:00:00
    #("-12:00:00", timezone.new(timezone.Minus, t12_00_00)),

    // Sad path - positive offset at 15:00:00
    #("+15:00:00", Error("Positive timezone offset must be less than 14:00")),
    // Sad path - negative offset at 15:00:00
    #("-15:00:00", Error("Negative timezone offset must be less than 12:00")),
    // Sad path - invalid offset sign
    #("invalid", Error("Invalid offset sign i must be + or -")),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c
    timezone.from_string(input)
    |> should.equal(expected)
  })
}

pub fn timezone_new_test() {
  let assert Ok(t10_12_31) = time.new(10, 12, 31)
  let assert Ok(t15_00_00) = time.new(15, 00, 00)
  let assert Ok(t14_00_00) = time.new(14, 00, 00)
  let assert Ok(t12_00_00) = time.new(12, 00, 00)

  // 1. Define the test cases in a list of tuples: #(input, expected)
  let cases = [
    // Happy paths - negative offset
    #(#(timezone.Minus, t10_12_31), timezone.new(timezone.Minus, t10_12_31)),
    // Happy paths - positive offset
    #(#(timezone.Plus, t10_12_31), timezone.new(timezone.Plus, t10_12_31)),

    // Boundary case - positive offset exactly 14:00
    #(#(timezone.Plus, t14_00_00), timezone.new(timezone.Plus, t14_00_00)),

    // Boundary case - negative offset exactly 12:00
    #(#(timezone.Minus, t12_00_00), timezone.new(timezone.Minus, t12_00_00)),

    // Sad path - positive offset too large
    #(
      #(timezone.Plus, t15_00_00),
      Error("Positive timezone offset must be less than 14:00"),
    ),
    // Sad path - negative offset too large
    #(
      #(timezone.Minus, t15_00_00),
      Error("Negative timezone offset must be less than 12:00"),
    ),
  ]

  // 2. Iterate over the list and run assertions for each
  list.each(cases, fn(c) {
    let #(#(dir, t), expected) = c

    timezone.new(dir, t)
    |> should.equal(expected)
  })
}

pub fn timezone_to_string_test() {
  let assert Ok(t10_12_31) = time.new(10, 12, 31)
  let assert Ok(tz_plus) = timezone.new(timezone.Plus, t10_12_31)
  let assert Ok(tz_minus) = timezone.new(timezone.Minus, t10_12_31)

  let cases = [
    // Happy path - positive offset
    #(tz_plus, "+10:12"),
    // Happy path - negative offset
    #(tz_minus, "-10:12"),
    // Happy path - Zulu
    #(timezone.zulu(), "Z"),
  ]

  list.each(cases, fn(c) {
    let #(tz, expected) = c
    timezone.to_string(tz)
    |> should.equal(expected)
  })
}

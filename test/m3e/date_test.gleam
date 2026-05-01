import gleam/list
import gleam/option.{None, Some}

import gleeunit/should

import m3e/date

// import m3e/day
// import m3e/month
import m3e/time
import m3e/timezone

// import m3e/year
import m3e/ymd

pub fn date_from_string_test() {
  let assert Ok(t01_54_00) = time.new(1, 54, 0)
  let assert Ok(t10_05_00) = time.new(10, 5, 0)
  let assert Ok(t10_54_00) = time.new(10, 54, 0)
  let assert Ok(t16_04_00) = time.new(16, 4, 0)
  let assert Ok(t16_54_00) = time.new(16, 54, 0)
  let assert Ok(tz01_54) = timezone.new(timezone.Plus, t01_54_00)
  let assert Ok(tz10_05) = timezone.new(timezone.Plus, t10_05_00)
  let assert Ok(tz10_54) = timezone.new(timezone.Plus, t10_54_00)
  let assert Ok(ymd2026_04_23) = ymd.new(2026, 4, 23)
  let date2026_04_23 = date.new(ymd2026_04_23, None, None)
  let assert Ok(ymd2026_04_03) = ymd.new(2026, 4, 3)
  let date2026_04_03 = date.new(ymd2026_04_03, None, None)
  let date2026_04_23_01_54_00 = date.new(ymd2026_04_23, Some(t01_54_00), None)
  let date2026_04_23_16_04_00 = date.new(ymd2026_04_23, Some(t16_04_00), None)
  let date2026_04_23_16_54_00 = date.new(ymd2026_04_23, Some(t16_54_00), None)
  let date2026_04_23_16_54_00tz10_54 =
    date.new(ymd2026_04_23, Some(t16_54_00), Some(tz10_54))
  let date2026_04_23_16_54_00zulu =
    date.new(ymd2026_04_23, Some(t16_54_00), Some(timezone.zulu()))
  let date2026_04_23_16_54_00tz01_54 =
    date.new(ymd2026_04_23, Some(t16_54_00), Some(tz01_54))
  let date2026_04_23_16_54_00tz10_05 =
    date.new(ymd2026_04_23, Some(t16_54_00), Some(tz10_05))

  let cases = [
    // Happy paths - only YMD provided
    #("2026-04-23", Ok(date2026_04_23)),
    // Happy paths - only YMD provided, single digit month
    #("2026-4-23", Ok(date2026_04_23)),
    // Happy paths - only YMD provided, single digit day
    #("2026-4-3", Ok(date2026_04_03)),

    // Happy paths - YMD and time provided
    #("2026-04-23T16:54:00", Ok(date2026_04_23_16_54_00)),
    // Happy paths - YMD and time provided, lower case T separator
    #("2026-04-23t16:54:00", Ok(date2026_04_23_16_54_00)),
    // Happy paths - YMD and time provided, single digit hour
    #("2026-04-23T1:54:00", Ok(date2026_04_23_01_54_00)),
    // Happy paths - YMD and time provided, single digit minute
    #("2026-04-23T16:4:00", Ok(date2026_04_23_16_04_00)),
    // Happy paths - YMD and time provided, single digit second
    #("2026-04-23T16:54:0", Ok(date2026_04_23_16_54_00)),

    // Happy paths - YMD, time, and Zulu timezone provided, upper case Z
    #("2026-04-23T16:54:00Z", Ok(date2026_04_23_16_54_00zulu)),
    // Happy paths - YMD, time, and Zulu timezone provided, lower case z
    #("2026-04-23T16:54:00z", Ok(date2026_04_23_16_54_00zulu)),
    // Happy paths - YMD, time, and timezone provided
    #("2026-04-23T16:54:00+10:54", Ok(date2026_04_23_16_54_00tz10_54)),
    // Happy paths - YMD, time, and timezone provided, sngle digit hour offset
    #("2026-04-23T16:54:00+1:54", Ok(date2026_04_23_16_54_00tz01_54)),
    // Happy paths - YMD, time, and timezone provided, single digit minute offset
    #("2026-04-23T16:54:00+10:5", Ok(date2026_04_23_16_54_00tz10_05)),

    // Sad path - invalid date string
    #("2026-13-23T16:54:00+10:50", Error("13 is out of range >=1 and <=12")),
    // Sad path - invalid time string
    #("2026-04-23T27:54:00+10:50", Error("27 is not a valid hour")),
    // Sad path - invalid positive timezone string
    #(
      "2026-04-23T16:54:00+17:50",
      Error("Positive timezone offset must be less than 14:00"),
    ),
    // Sad path - invalid negative timezone string
    #(
      "2026-04-23T16:54:00-13:50",
      Error("Negative timezone offset must be less than 12:00"),
    ),
    // Sad path - totally rubbish string, no "t" or "T"
    #("junk", Error("JUNK is an invalid date string, must be yyyy-mm-dd")),
    // Sad path - valid string but separated by something other than "t" or "T"
    #(
      "2026-04-23 16:54:00+10:50",
      Error("23 16:54:00+10:50 can't be parsed as a day"),
    ),
    // Sad path - string containing "t" or "T" but no date
    #(
      "T16:54:00+10:50",
      Error(" is an invalid date string, must be yyyy-mm-dd"),
    ),
    // Sad path - string containing "t" or "T" but no time
    #(
      "2026-04-23T+10:50",
      Error(" is an invalid time string, must be hh:mm:ss or hh:mm"),
    ),
    // Sad path - string with date / time / timezone but timezone separator is not "+" or "-"
    #(
      "2026-04-23T16:54:00*10:50",
      Error(
        "16:54:00*10:50 is an invalid time string, must be hh:mm:ss or hh:mm",
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    date.from_string(s)
    |> should.equal(expected)
  })
}

pub fn date_new_test() {
  let assert Ok(t10_54_00) = time.new(10, 54, 0)
  let assert Ok(t16_54_00) = time.new(16, 54, 0)
  let assert Ok(tz1) = timezone.new(timezone.Plus, t10_54_00)
  let assert Ok(ymd2026_04_23) = ymd.new(2026, 4, 23)
  let date2026_04_23 = date.new(ymd2026_04_23, None, None)
  let date2026_04_23_16_54_00 = date.new(ymd2026_04_23, Some(t16_54_00), None)
  let date2026_04_23_16_54_00tz =
    date.new(ymd2026_04_23, Some(t16_54_00), Some(tz1))

  let cases = [
    // Happy paths - only YMD provided
    #(#(ymd2026_04_23, None, None), date2026_04_23),
    // Happy paths - YMD and time provided
    #(#(ymd2026_04_23, Some(t16_54_00), None), date2026_04_23_16_54_00),
    // Happy paths - YMD, time, and timezone provided
    #(#(ymd2026_04_23, Some(t16_54_00), Some(tz1)), date2026_04_23_16_54_00tz),
  ]

  list.each(cases, fn(c) {
    let #(#(y, m, d), expected) = c

    date.new(y, m, d)
    |> should.equal(expected)
  })
}

pub fn date_to_string_test() {
  let assert Ok(ymd2026_04_23) = ymd.new(2026, 4, 23)
  let date2026_04_23 = date.new(ymd2026_04_23, None, None)

  let cases = [
    // Happy paths
    #(date2026_04_23, "2026-04-23"),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    date.to_string(input)
    |> should.equal(expected)
  })
}

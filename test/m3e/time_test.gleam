import gleam/result
import gleeunit/should
import m3e/time

pub fn new_valid_test() {
  time.new(12, 30, 45)
  |> should.be_ok()
  |> time.to_string()
  |> should.equal("12:30:45")
}

pub fn new_single_digit_test() {
  time.new(1, 2, 3)
  |> should.be_ok()
  |> time.to_string()
  |> should.equal("01:02:03")
}

pub fn new_hour_too_high_test() {
  time.new(24, 0, 0)
  |> should.be_error()
}

pub fn new_hour_negative_test() {
  time.new(-1, 0, 0)
  |> should.be_error()
}

pub fn new_minute_too_high_test() {
  time.new(0, 60, 0)
  |> should.be_error()
}

pub fn new_minute_negative_test() {
  time.new(0, -1, 0)
  |> should.be_error()
}

pub fn new_second_too_high_test() {
  time.new(0, 0, 60)
  |> should.be_error()
}

pub fn new_second_negative_test() {
  time.new(0, 0, -1)
  |> should.be_error()
}

pub fn from_string_hh_mm_ss_test() {
  time.from_string("12:30:45")
  |> should.be_ok()
  |> time.to_string()
  |> should.equal("12:30:45")
}

pub fn from_string_single_digit_test() {
  time.from_string("1:2:3")
  |> should.be_ok()
  |> time.to_string()
  |> should.equal("01:02:03")
}

pub fn from_string_hh_mm_test() {
  time.from_string("12:30")
  |> should.be_ok()
  |> time.to_string()
  |> should.equal("12:30:00")
}

pub fn from_string_invalid_hour_test() {
  time.from_string("24:00:00")
  |> should.be_error()
}

pub fn from_string_invalid_minute_test() {
  time.from_string("12:60:00")
  |> should.be_error()
}

pub fn from_string_invalid_second_test() {
  time.from_string("12:30:60")
  |> should.be_error()
}

pub fn from_string_too_few_parts_test() {
  time.from_string("12")
  |> should.be_error()
}

pub fn from_string_too_many_parts_test() {
  time.from_string("12:30:45:67")
  |> should.be_error()
}

pub fn from_string_non_numeric_test() {
  time.from_string("ab:cd:ef")
  |> should.be_error()
}

pub fn zero_test() {
  time.zero()
  |> time.to_string()
  |> should.equal("00:00:00")
}

pub fn is_zero_test() {
  time.is_zero(time.zero())
  |> should.be_true()

  time.is_zero(time.new(0, 0, 1) |> should.be_ok())
  |> should.be_false()

  time.is_zero(time.new(0, 1, 0) |> should.be_ok())
  |> should.be_false()

  time.is_zero(time.new(1, 0, 0) |> should.be_ok())
  |> should.be_false()
}

pub fn to_hhmm_valid_test() {
  let time = time.new(12, 30, 45) |> should.be_ok()
  time.to_hhmm(time) |> should.equal("12:30")
}

pub fn to_hhmm_single_digit_hour_test() {
  let time = time.new(1, 30, 45) |> should.be_ok()
  time.to_hhmm(time) |> should.equal("01:30")
}

pub fn to_hhmm_single_digit_minute_test() {
  let time = time.new(12, 5, 45) |> should.be_ok()
  time.to_hhmm(time) |> should.equal("12:05")
}

pub fn to_hhmm_zero_time_test() {
  let time = time.zero()
  time.to_hhmm(time) |> should.equal("00:00")
}

pub fn to_hhmm_edge_case_midnight_test() {
  let time = time.new(0, 0, 0) |> should.be_ok()
  time.to_hhmm(time) |> should.equal("00:00")
}

pub fn to_hhmm_edge_case_noon_test() {
  let time = time.new(12, 0, 0) |> should.be_ok()
  time.to_hhmm(time) |> should.equal("12:00")
}

pub fn to_hhmm_invalid_hour_error_test() {
  let res = time.from_string("24:30:45")
  should.equal(result.is_error(res), True)
  should.equal(
    result.unwrap_error(res, "none"),
    "24 is out of range >=0 and <=23",
  )
}

pub fn to_hhmm_invalid_minute_error_test() {
  let res = time.from_string("12:60:45")
  should.equal(result.is_error(res), True)
  should.equal(
    result.unwrap_error(res, "none"),
    "60 is out of range >=0 and <=59",
  )
}

pub fn to_hhmm_invalid_second_error_test() {
  let res = time.from_string("12:30:60")
  should.equal(result.is_error(res), True)
  should.equal(
    result.unwrap_error(res, "none"),
    "60 is out of range >=0 and <=59",
  )
}

pub fn less_than_valid_test() {
  let time1 = time.new(12, 30, 45) |> should.be_ok()
  let time2 = time.new(12, 31, 45) |> should.be_ok()
  time.less_than(time1, time2) |> should.be_true()

  let time3 = time.new(11, 30, 45) |> should.be_ok()
  time.less_than(time3, time1) |> should.be_true()
}

pub fn less_than_zero_test() {
  let zero_time = time.zero()
  let time1 = time.new(12, 30, 45) |> should.be_ok()
  time.less_than(zero_time, time1) |> should.be_true()

  let time2 = time.new(0, 0, 0) |> should.be_ok()
  time.less_than(time2, zero_time) |> should.be_false()
}

pub fn less_than_edge_case_midnight_test() {
  let midnight = time.zero()
  let time1 = time.new(1, 0, 0) |> should.be_ok()
  time.less_than(midnight, time1) |> should.be_true()

  let noon = time.new(12, 0, 0) |> should.be_ok()
  time.less_than(noon, midnight) |> should.be_false()
}

pub fn less_than_single_digit_test() {
  let time1 = time.new(1, 30, 45) |> should.be_ok()
  let time2 = time.new(1, 31, 45) |> should.be_ok()
  time.less_than(time1, time2) |> should.be_true()

  let time3 = time.new(1, 29, 45) |> should.be_ok()
  time.less_than(time3, time1) |> should.be_true()
}

pub fn less_than_negative_time_test() {
  let error = time.from_string("-01:00:00")
  should.equal(result.is_error(error), True)
  should.equal(
    result.unwrap_error(error, "none"),
    "-1 is out of range >=0 and <=23",
  )
}

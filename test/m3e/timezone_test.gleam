import gleam/result

import gleeunit/should

import m3e/time
import m3e/timezone

pub fn zulu_test() {
  let tz = timezone.zulu()
  should.equal(timezone.to_string(tz), "Z")
}

pub fn from_string_zulu_test() -> Result(Nil, String) {
  use tz <- result.try(timezone.from_string("Z"))
  should.equal(timezone.to_string(tz), "Z")
  Ok(Nil)
}

pub fn from_string_offset_plus_test() -> Result(Nil, String) {
  use tz <- result.try(timezone.from_string("+00:30"))
  should.equal(timezone.to_string(tz), "+00:30")
  Ok(Nil)
}

pub fn from_string_offset_minus_test() -> Result(Nil, String) {
  use tz <- result.try(timezone.from_string("-05:30"))
  should.equal(timezone.to_string(tz), "-05:30")
  Ok(Nil)
}

pub fn from_string_offset_utc_plus5_test() -> Result(Nil, String) {
  use tz <- result.try(timezone.from_string("+05:30"))
  should.equal(timezone.to_string(tz), "+05:30")
  Ok(Nil)
}

pub fn from_string_offset_utc_plus9_test() -> Result(Nil, String) {
  use tz <- result.try(timezone.from_string("+09:00"))
  should.equal(timezone.to_string(tz), "+09:00")
  Ok(Nil)
}

pub fn from_string_offset_negative_sign_test() {
  use time <- result.try(time.new(0, 2, 30))
  let tz = timezone.from_string("-02:30")
  should.equal(result.is_error(tz), False)
  use tz1 <- result.try(timezone.new("-", time))
  should.equal(timezone.to_string(result.unwrap(tz, tz1)), "-02:30")
  Ok(Nil)
}

pub fn from_string_invalid_test() {
  should.equal(result.is_error(timezone.from_string("invalid")), True)
  should.equal(
    result.unwrap_error(timezone.from_string("invalid"), "none"),
    "nvalid is an invalid time string, must be hh:mm:ss or hh:mm",
  )
}

pub fn from_string_invalid_sign_test() {
  should.equal(result.is_error(timezone.from_string("?10:00")), True)
  should.equal(
    result.unwrap_error(timezone.from_string("*10:00"), "none"),
    "Invalid offset sign * must be + or -",
  )
}

pub fn new_offset_test() -> Result(Nil, String) {
  use time <- result.try(time.new(0, 3, 45))
  use tz <- result.try(timezone.new("+", time))
  should.equal(timezone.to_string(tz), "+00:03")
  Ok(Nil)
}

pub fn new_zulu_test() -> Result(Nil, String) {
  should.equal(timezone.to_string(timezone.zulu()), "Z")
  Ok(Nil)
}

pub fn to_string_roundtrip_test() -> Result(Nil, String) {
  use tz <- result.try(timezone.from_string("+08:15"))
  should.equal(timezone.to_string(tz), "+08:15")
  use tz2 <- result.try(timezone.from_string("-04:30"))
  should.equal(timezone.to_string(tz2), "-04:30")
  Ok(Nil)
}

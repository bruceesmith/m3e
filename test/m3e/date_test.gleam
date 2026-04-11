import gleam/result

import gleeunit/should

import m3e/date

pub fn from_string_test() -> Result(Nil, String) {
  use dt1 <- result.try(date.from_string("2024-01-01"))
  use dt2 <- result.try(date.from_string("2024-12-31"))
  use dt3 <- result.try(date.new(2024, 1, 1))
  use dt4 <- result.try(date.new(2024, 12, 31))

  should.equal(dt1, dt3)
  should.equal(dt2, dt4)

  Ok(Nil)
}

pub fn to_string_test() -> Result(Nil, String) {
  use dt <- result.try(date.from_string("2024-01-01"))
  should.equal(date.to_string(dt), "2024-01-01")

  use dt2 <- result.try(date.from_string("2024-12-31"))
  should.equal(date.to_string(dt2), "2024-12-31")

  use dt3 <- result.try(date.from_string("2024-02-29"))
  should.equal(date.to_string(dt3), "2024-02-29")

  use dt4 <- result.try(date.from_string("2024-06-30"))
  should.equal(date.to_string(dt4), "2024-06-30")

  use dt5 <- result.try(date.from_string("2024-07-31"))
  should.equal(date.to_string(dt5), "2024-07-31")

  use dt6 <- result.try(date.from_string("2024-09-30"))
  should.equal(date.to_string(dt6), "2024-09-30")

  use dt7 <- result.try(date.from_string("2024-11-30"))
  should.equal(date.to_string(dt7), "2024-11-30")

  Ok(Nil)
}

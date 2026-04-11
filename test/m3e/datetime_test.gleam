import gleam/option.{None, Some}
import gleeunit/should
import m3e/date
import m3e/datetime
import m3e/time
import m3e/timezone

pub fn new_valid_test() {
  let date = date.from_string("2024-10-05") |> should.be_ok()
  let time = time.new(12, 30, 45) |> should.be_ok()
  let timezone = timezone.from_string("+02:00") |> should.be_ok()

  let datetime = datetime.new(date, time, Some(timezone))
  datetime.to_string(datetime) |> should.equal("2024-10-05T12:30:45+02:00")
}

pub fn new_no_timezone_test() {
  let date = date.from_string("2024-10-05") |> should.be_ok()
  let time = time.new(12, 30, 45) |> should.be_ok()

  let datetime = datetime.new(date, time, None)
  datetime.to_string(datetime) |> should.equal("2024-10-05T12:30:45")
}

pub fn from_string_valid_date_only_test() {
  let dt = datetime.from_string("2024-10-05") |> should.be_ok()
  datetime.to_string(dt) |> should.equal("2024-10-05")
}

pub fn from_string_valid_datetime_local_test() {
  let dt = datetime.from_string("2024-10-05T12:30:45") |> should.be_ok()
  datetime.to_string(dt) |> should.equal("2024-10-05T12:30:45")
}

pub fn from_string_valid_datetime_utc_test() {
  let dt = datetime.from_string("2024-10-05T12:30:45Z") |> should.be_ok()
  datetime.to_string(dt) |> should.equal("2024-10-05T12:30:45Z")
}

pub fn from_string_valid_datetime_with_offset_test() {
  let dt = datetime.from_string("2024-10-05T12:30:45+02:00") |> should.be_ok()
  datetime.to_string(dt) |> should.equal("2024-10-05T12:30:45+02:00")

  let dt = datetime.from_string("2024-10-05T12:30:45-03:30") |> should.be_ok()
  datetime.to_string(dt) |> should.equal("2024-10-05T12:30:45-03:30")
}

pub fn from_string_invalid_test() {
  datetime.from_string("invalid") |> should.be_error()
}

pub fn from_string_missing_date_part_test() {
  datetime.from_string("T12:30:45") |> should.be_error()
}

pub fn from_string_missing_time_part_test() {
  datetime.from_string("2024-10-05") |> should.be_ok()

  // Invalid timezone offset
  datetime.from_string("2024-10-05T12:30:45+99:00") |> should.be_error()
  datetime.from_string("2024-10-05T12:30:45-99:00") |> should.be_error()

  // Invalid timezone format
  datetime.from_string("2024-10-05T12:30:45+99") |> should.be_error()
  datetime.from_string("2024-10-05T12:30:45-99") |> should.be_error()

  // Invalid time
  datetime.from_string("2024-10-05T60:30:45") |> should.be_error()
  datetime.from_string("2024-10-05T23:60:45") |> should.be_error()
  datetime.from_string("2024-10-05T23:59:60") |> should.be_error()
}

pub fn date_valid_test() {
  let dt =
    datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.new(12, 30, 45) |> should.be_ok(),
      Some(timezone.from_string("+02:00") |> should.be_ok()),
    )

  let new_date = date.from_string("2024-10-06") |> should.be_ok()
  let new_datetime = datetime.date(dt, new_date)
  datetime.to_string(new_datetime) |> should.equal("2024-10-06T12:30:45+02:00")
}

pub fn time_valid_test() {
  let dt =
    datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.new(12, 30, 45) |> should.be_ok(),
      Some(timezone.from_string("+02:00") |> should.be_ok()),
    )

  let new_time = time.new(13, 45, 0) |> should.be_ok()
  let new_datetime = datetime.time(dt, new_time)
  datetime.to_string(new_datetime) |> should.equal("2024-10-05T13:45:00+02:00")
}

pub fn timezone_valid_test() {
  let dt =
    datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.new(12, 30, 45) |> should.be_ok(),
      Some(timezone.from_string("+02:00") |> should.be_ok()),
    )

  let new_timezone = timezone.from_string("-05:00") |> should.be_ok()
  let new_datetime = datetime.timezone(dt, Some(new_timezone))
  datetime.to_string(new_datetime) |> should.equal("2024-10-05T12:30:45-05:00")
}

pub fn timezone_none_test() {
  let dt =
    datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.new(12, 30, 45) |> should.be_ok(),
      Some(timezone.from_string("+02:00") |> should.be_ok()),
    )

  let new_datetime = datetime.timezone(dt, None)
  datetime.to_string(new_datetime) |> should.equal("2024-10-05T12:30:45")
}

pub fn to_string_no_timezone_test() {
  let dt =
    datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.new(12, 30, 45) |> should.be_ok(),
      None,
    )

  datetime.to_string(dt) |> should.equal("2024-10-05T12:30:45")
}

pub fn to_string_zero_time_no_timezone_test() {
  let dt =
    datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.zero(),
      None,
    )

  datetime.to_string(dt) |> should.equal("2024-10-05")
}

pub fn to_string_utc_timezone_test() {
  let dt =
    datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.new(12, 30, 45) |> should.be_ok(),
      Some(timezone.zulu()),
    )

  datetime.to_string(dt) |> should.equal("2024-10-05T12:30:45Z")
}

pub fn to_string_with_timezone_test() {
  let dt =
    datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.new(12, 30, 45) |> should.be_ok(),
      Some(timezone.from_string("+02:00") |> should.be_ok()),
    )

  datetime.to_string(dt) |> should.equal("2024-10-05T12:30:45+02:00")
}

pub fn to_string_zero_time_with_timezone_test() {
  let dt =
    datetime.new(
      date.from_string("2024-10-05") |> should.be_ok(),
      time.zero(),
      Some(timezone.from_string("+02:00") |> should.be_ok()),
    )

  datetime.to_string(dt) |> should.equal("2024-10-05T00:00:00+02:00")
}

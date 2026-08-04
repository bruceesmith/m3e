import gleam/int

pub type TimeParts {
  TimeParts(
    /// The hour, in 24-hour time, from 0..23.
    hour: Int,
    /// The minute, from 0..59.
    minute: Int,
    /// The second, from 0..59.
    second: Int,
  )
}

pub fn to_string(tp: TimeParts) -> String {
  int.to_string(tp.hour)
  <> ":"
  <> int.to_string(tp.minute)
  <> ":"
  <> int.to_string(tp.second)
}

pub fn zero() -> TimeParts {
  TimeParts(0, 0, 0)
}

pub fn zero_string() -> String {
  TimeParts(0, 0, 0) |> to_string
}

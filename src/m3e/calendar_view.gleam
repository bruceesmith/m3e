//// CalendarView
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type CalendarView {
  Month
  Year
  MultiYear
}

pub fn to_string(level: CalendarView) -> String {
  case level {
    Month -> "month"
    Year -> "year"
    MultiYear -> "multi-year"
  }
}

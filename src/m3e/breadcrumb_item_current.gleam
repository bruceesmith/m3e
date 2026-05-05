//// BreadcrumbItemCurrent
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type BreadcrumbItemCurrent {
  Page
  Step
  Location
  Date
  Time
  True
}

pub fn to_string(level: BreadcrumbItemCurrent) -> String {
  case level {
    Page -> "page"
    Step -> "step"
    Location -> "location"
    Date -> "date"
    Time -> "time"
    True -> "true"
  }
}

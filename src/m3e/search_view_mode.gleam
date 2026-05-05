//// SearchViewMode
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type SearchViewMode {
  Fullscreen
  Docked
  Auto
}

pub fn to_string(level: SearchViewMode) -> String {
  case level {
    Fullscreen -> "fullscreen"
    Docked -> "docked"
    Auto -> "auto"
  }
}

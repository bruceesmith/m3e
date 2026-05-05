//// LinkTarget
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type LinkTarget {
  Self
  Blank
  Parent
  Top
}

pub fn to_string(level: LinkTarget) -> String {
  case level {
    Self -> "_self"
    Blank -> "_blank"
    Parent -> "_parent"
    Top -> "_top"
  }
}

//// HeadingLevel
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type HeadingLevel {
  One
  Two
  Three
  Four
  Five
  Six
}

pub fn to_string(level: HeadingLevel) -> String {
  case level {
    One -> "1"
    Two -> "2"
    Three -> "3"
    Four -> "4"
    Five -> "5"
    Six -> "6"
  }
}

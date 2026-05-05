//// ButtonGroupSize
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type ButtonGroupSize {
  ExtraSmall
  Small
  Medium
  Large
  ExtraLarge
}

pub fn to_string(level: ButtonGroupSize) -> String {
  case level {
    ExtraSmall -> "extra-small"
    Small -> "small"
    Medium -> "medium"
    Large -> "large"
    ExtraLarge -> "extra-large"
  }
}

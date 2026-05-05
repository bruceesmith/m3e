//// ButtonVariant
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type ButtonVariant {
  Elevated
  Filled
  Tonal
  Outlined
  Text
}

pub fn to_string(level: ButtonVariant) -> String {
  case level {
    Elevated -> "elevated"
    Filled -> "filled"
    Tonal -> "tonal"
    Outlined -> "outlined"
    Text -> "text"
  }
}

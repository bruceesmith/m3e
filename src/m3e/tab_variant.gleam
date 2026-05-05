//// TabVariant
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type TabVariant {
  Primary
  Secondary
}

pub fn to_string(level: TabVariant) -> String {
  case level {
    Primary -> "primary"
    Secondary -> "secondary"
  }
}

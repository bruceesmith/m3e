//// HeadingVariant
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type HeadingVariant {
  Display
  Headline
  Title
  Label
}

pub fn to_string(level: HeadingVariant) -> String {
  case level {
    Display -> "display"
    Headline -> "headline"
    Title -> "title"
    Label -> "label"
  }
}

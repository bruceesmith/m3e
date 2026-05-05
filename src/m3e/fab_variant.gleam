//// FabVariant
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type FabVariant {
  Primary
  PrimaryContainer
  Secondary
  SecondaryContainer
  Tertiary
  TertiaryContainer
  Surface
}

pub fn to_string(level: FabVariant) -> String {
  case level {
    Primary -> "primary"
    PrimaryContainer -> "primary-container"
    Secondary -> "secondary"
    SecondaryContainer -> "secondary-container"
    Tertiary -> "tertiary"
    TertiaryContainer -> "tertiary-container"
    Surface -> "surface"
  }
}

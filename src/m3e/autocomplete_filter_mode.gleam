//// AutocompleteFilterMode
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type AutocompleteFilterMode {
  Contains
  StartsWith
  EndsWith
  None
}

pub fn to_string(level: AutocompleteFilterMode) -> String {
  case level {
    Contains -> "contains"
    StartsWith -> "starts-with"
    EndsWith -> "ends-with"
    None -> "none"
  }
}

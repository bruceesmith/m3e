//// OptionPanelState
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type OptionPanelState {
  Loading
  NoData
  Content
}

pub fn to_string(level: OptionPanelState) -> String {
  case level {
    Loading -> "loading"
    NoData -> "no-data"
    Content -> "content"
  }
}

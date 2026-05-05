//// IconWeight
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type IconWeight {
  OneZeroZero
  TwoZeroZero
  ThreeZeroZero
  FourZeroZero
  FiveZeroZero
  SixZeroZero
  SevenZeroZero
}

pub fn to_string(level: IconWeight) -> String {
  case level {
    OneZeroZero -> "100"
    TwoZeroZero -> "200"
    ThreeZeroZero -> "300"
    FourZeroZero -> "400"
    FiveZeroZero -> "500"
    SixZeroZero -> "600"
    SevenZeroZero -> "700"
  }
}

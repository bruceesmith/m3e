//// ShapeName
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type ShapeName {
  FourLeafClover
  FourSidedCookie
  SixSidedCookie
  SevenSidedCookie
  EightLeafClover
  NineSidedCookie
  OneTwoSidedCookie
  Arch
  Arrow
  Boom
  Bun
  Burst
  Circle
  Diamond
  Fan
  Flower
  Gem
  GhostIsh
  Heart
  Hexagon
  Oval
  Pentagon
  Pill
  PixelCircle
  PixelTriangle
  Puffy
  PuffyDiamond
  Semicircle
  Slanted
  SoftBoom
  SoftBurst
  Square
  Sunny
  Triangle
  VerySunny
}

pub fn to_string(level: ShapeName) -> String {
  case level {
    FourLeafClover -> "4-leaf-clover"
    FourSidedCookie -> "4-sided-cookie"
    SixSidedCookie -> "6-sided-cookie"
    SevenSidedCookie -> "7-sided-cookie"
    EightLeafClover -> "8-leaf-clover"
    NineSidedCookie -> "9-sided-cookie"
    OneTwoSidedCookie -> "12-sided-cookie"
    Arch -> "arch"
    Arrow -> "arrow"
    Boom -> "boom"
    Bun -> "bun"
    Burst -> "burst"
    Circle -> "circle"
    Diamond -> "diamond"
    Fan -> "fan"
    Flower -> "flower"
    Gem -> "gem"
    GhostIsh -> "ghost-ish"
    Heart -> "heart"
    Hexagon -> "hexagon"
    Oval -> "oval"
    Pentagon -> "pentagon"
    Pill -> "pill"
    PixelCircle -> "pixel-circle"
    PixelTriangle -> "pixel-triangle"
    Puffy -> "puffy"
    PuffyDiamond -> "puffy-diamond"
    Semicircle -> "semicircle"
    Slanted -> "slanted"
    SoftBoom -> "soft-boom"
    SoftBurst -> "soft-burst"
    Square -> "square"
    Sunny -> "sunny"
    Triangle -> "triangle"
    VerySunny -> "very-sunny"
  }
}

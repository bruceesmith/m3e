//// RichTooltipPosition
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    On: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

pub type RichTooltipPosition {
  AboveAfter
  AboveBefore
  BelowBefore
  BelowAfter
  Before
  After
  Above
  Below
}

pub fn to_string(level: RichTooltipPosition) -> String {
  case level {
    AboveAfter -> "above-after"
    AboveBefore -> "above-before"
    BelowBefore -> "below-before"
    BelowAfter -> "below-after"
    Before -> "before"
    After -> "after"
    Above -> "above"
    Below -> "below"
  }
}

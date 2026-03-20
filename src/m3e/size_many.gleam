/// Size is the size of an element, with 5 variations
/// 
pub type Size {
  ExtraSmall
  Small
  Medium
  Large
  ExtraLarge
}

pub fn size_to_string(s: Size) -> String {
  case s {
    ExtraSmall -> "extra-small"
    Small -> "small"
    Medium -> "medium"
    Large -> "large"
    ExtraLarge -> "extra-large"
  }
}

pub const default_size = Small

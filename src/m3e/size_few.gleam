/// Size is the size of an element, restricted to just 3 variations
/// 
pub type Size {
  Large
  Medium
  Small
}

pub fn size_to_string(size: Size) -> String {
  case size {
    Large -> "large"
    Medium -> "medium"
    Small -> "small"
  }
}

pub const default_size = Medium
